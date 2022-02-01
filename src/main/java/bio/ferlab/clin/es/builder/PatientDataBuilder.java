package bio.ferlab.clin.es.builder;

import bio.ferlab.clin.es.config.ResourceDaoConfiguration;
import bio.ferlab.clin.es.data.PatientData;
import bio.ferlab.clin.es.data.PrescriptionData;
import bio.ferlab.clin.utils.Extensions;
import ca.uhn.fhir.interceptor.model.RequestPartitionId;
import ca.uhn.fhir.jpa.partition.SystemRequestDetails;
import ca.uhn.fhir.jpa.searchparam.SearchParameterMap;
import ca.uhn.fhir.rest.api.server.IBundleProvider;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.param.ReferenceParam;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.*;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import static bio.ferlab.clin.interceptors.TenantPartitionInterceptor.systemRequestDetails;

@Component
public class PatientDataBuilder {
    private static final SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    private static final String ID_SEPARATOR = "/";
    public static final String MRN_CODE = "MR";

    private final ResourceDaoConfiguration configuration;

    public PatientDataBuilder(ResourceDaoConfiguration configuration) {
        this.configuration = configuration;
    }

    public List<PatientData> fromIds(Set<String> ids, RequestDetails requestDetails) {
        final List<PatientData> patientDataList = new ArrayList<>();
        for (final String patientId : ids) {
            final PatientData patientData = new PatientData();
            final Patient patient = this.configuration.patientDAO.read(new IdType(patientId), systemRequestDetails);

            this.handlePatient(patient, patientData);
            if (patient.hasExtension(Extensions.FAMILY_ID)) {
                final Extension extension = patient.getExtensionByUrl(Extensions.FAMILY_ID);
                final Reference ref = (Reference) extension.getValue();
                final Group group = this.configuration.groupDao.read(ref.getReferenceElement(), systemRequestDetails);
                this.handleFamilyGroup(group, patientData);
            }

            final SearchParameterMap searchMap = SearchParameterMap.newSynchronous("subject", new ReferenceParam(patientId));
            final IBundleProvider srProvider = this.configuration.serviceRequestDAO.search(searchMap, systemRequestDetails);

            final List<ServiceRequest> serviceRequests = getListFromProvider(srProvider);
            for (ServiceRequest serviceRequest : serviceRequests) {
                patientData.getRequests().add(this.handleServiceRequest(serviceRequest));
            }
            // clean-up + full text
            patientData.getRequests().forEach(r -> r.setPatientInfo(null));
            patientData.applyFullText();
            patientDataList.add(patientData);
        }
        return patientDataList;
    }

    void handlePatient(Patient patient, PatientData patientData) {
        patientData.setCid(patient.getIdElement().getIdPart());
        final List<String> mrns = Objects.requireNonNull(patient.getIdentifier()).stream()
                .filter(id -> id.getType().getCodingFirstRep().getCode().contentEquals(MRN_CODE))
                .map(Identifier::getValue).collect(Collectors.toList());

        patientData.getMrn().addAll(mrns);
        patientData.setGender(Optional.ofNullable(patient.getGender()).map(Enumerations.AdministrativeGender::getDisplay).orElse(null));

        if (patient.hasName()) {
            final Name name = extractName(patient.getName());
            patientData.setLastName(name.lastName);
            patientData.setFirstName(name.firstName);
            patientData.setLastNameFirstName(name.lastNameFirstName);
        }
        if (patient.getIdentifier().size() > 1) {
            patientData.setRamq(patient.getIdentifier().get(1).getValue());
        }

        if (patient.hasExtension(Extensions.BLOOD_RELATIONSHIP)) {
            final Extension extension = patient.getExtensionByUrl(Extensions.BLOOD_RELATIONSHIP);
            if (extension.hasValue() && extension.getValue() instanceof Coding) {
                final Coding value = (Coding) extension.getValue();
                patientData.setBloodRelationship(value.getDisplay());
            }
        }

        if (patient.hasExtension(Extensions.ETHNICITY)) {
            final Extension extension = patient.getExtensionByUrl(Extensions.ETHNICITY);
            if (extension.hasValue() && extension.getValue() instanceof Coding) {
                final Coding value = (Coding) extension.getValue();
                patientData.setEthnicity(value.getDisplay());
            }
        }

        if (patient.hasExtension(Extensions.IS_PROBAND)) {
            final Extension extension = patient.getExtensionByUrl(Extensions.IS_PROBAND);
            if (extension.hasValue()) {
                final BooleanType value = (BooleanType) extension.getValue();
                patientData.setPosition(value.booleanValue() ? "Proband" : "Parent");
            }
        }

        if (patient.hasExtension(Extensions.IS_FETUS)) {
            final Extension extension = patient.getExtensionByUrl(Extensions.IS_FETUS);
            if (extension.hasValue()) {
                final BooleanType value = (BooleanType) extension.getValue();
                patientData.setFetus(value.booleanValue());
            }
        }

        if (patient.hasExtension(Extensions.FAMILY_ID)) {
            final Extension extension = patient.getExtensionByUrl(Extensions.FAMILY_ID);
            if (extension.hasValue() && extension.getValue() instanceof Reference) {
                final Reference value = (Reference) extension.getValue();
                final String[] idParts = value.getReference().split(ID_SEPARATOR);
                patientData.setFamilyId(idParts.length > 1 ? idParts[1] : idParts[0]);
            }
        }

        if (patient.hasGeneralPractitioner()) {
            final String id = patient.getGeneralPractitioner().get(0).getReference();
            final PractitionerRole practitionerRole = configuration.practitionerRoleDao.read(new IdType(id), systemRequestDetails);
            final Practitioner practitioner = configuration.practitionerDao.read(practitionerRole.getPractitioner().getReferenceElement(), systemRequestDetails);
            final Name name = extractName(practitioner.getName());
            patientData.getPractitioner().setCid(practitioner.getIdElement().getIdPart());
            patientData.getPractitioner().setLastName(name.lastName);
            patientData.getPractitioner().setFirstName(name.firstName);
            patientData.getPractitioner().setLastNameFirstName(name.lastNameFirstName);
        }

        if (patient.hasManagingOrganization()) {
            final String id = patient.getManagingOrganization().getReference();
            final Organization organization = configuration.organizationDAO.read(new IdType(id), systemRequestDetails);
            patientData.getOrganization().setCid(organization.getIdElement().getIdPart());
            patientData.getOrganization().setName(organization.hasName() ? organization.getName() : "");
        }

        if (patient.hasBirthDate()) {
            patientData.setBirthDate(simpleDateFormat.format(patient.getBirthDate()));
        }

    }

    PrescriptionData handleServiceRequest(ServiceRequest serviceRequest) {
        final PrescriptionData requestData = new PrescriptionData();
        requestData.setCid(serviceRequest.getIdElement().getIdPart());
        requestData.setStatus(serviceRequest.getStatus().toCode());
        if (serviceRequest.hasCode()) {
            final CodeableConcept code = serviceRequest.getCode();
            if (code.hasCoding()) {
                final Coding coding = code.getCoding().get(0);
                requestData.getAnalysis().setCode(coding.getCode());
                requestData.getAnalysis().setDisplay(coding.getDisplay());
            }
        }

        if (serviceRequest.hasAuthoredOn()) {
            requestData.setAuthoredOn(simpleDateFormat.format(serviceRequest.getAuthoredOn()));
        }

        if (serviceRequest.hasExtension(Extensions.IS_SUBMITTED)) {
            final Extension extension = serviceRequest.getExtensionByUrl(Extensions.IS_SUBMITTED);
            final BooleanType valueBoolean = (BooleanType) extension.getValue();
            requestData.setSubmitted(valueBoolean.getValue());
        }

        if (serviceRequest.hasAuthoredOn()) {
            requestData.setAuthoredOn(simpleDateFormat.format(serviceRequest.getAuthoredOn()));
        }
        
        if (serviceRequest.hasPerformer()) {
            requestData.setLaboratory(serviceRequest.getPerformer().get(0).getReference());
        }

        if (serviceRequest.hasRequester()) {
            final String id = serviceRequest.getRequester().getReference();
            final Practitioner practitioner = configuration.practitionerDao.read(new IdType(id), systemRequestDetails);
            final Name name = extractName(practitioner.getName());
            requestData.getPrescriber().setCid(practitioner.getIdElement().getIdPart());
            requestData.getPrescriber().setLastName(name.lastName);
            requestData.getPrescriber().setFirstName(name.firstName);
            requestData.getPrescriber().setLastNameFirstName(name.lastNameFirstName);
        }

        if (serviceRequest.hasExtension(Extensions.PROCEDURE_DIRECTED_BY)) {
            final Extension extension = serviceRequest.getExtensionByUrl(Extensions.PROCEDURE_DIRECTED_BY);
            final Reference ref = (Reference) extension.getValue();
            final PractitionerRole role = this.configuration.practitionerRoleDao.read(ref.getReferenceElement(), systemRequestDetails);
            final Practitioner practitioner = this.configuration.practitionerDao.read(role.getPractitioner().getReferenceElement(), systemRequestDetails);
            final Name name = extractName(practitioner.getName());
            requestData.getApprover().setCid(practitioner.getIdElement().getIdPart());
            requestData.getApprover().setFirstName(name.firstName);
            requestData.getApprover().setLastName(name.lastName);
            requestData.getApprover().setLastNameFirstName(name.lastNameFirstName);
        }

        if (serviceRequest.hasIdentifier()) {
            final var identifier = serviceRequest.getIdentifier().get(0);
            if (identifier.hasValue()) {
                requestData.setMrn(identifier.getValue());
            }
            if (identifier.hasAssigner()) {
                final String id = identifier.getAssigner().getReference();
                final Organization organization = configuration.organizationDAO.read(new IdType(id), systemRequestDetails);
                requestData.getOrganization().setCid(organization.getIdElement().getIdPart());
                requestData.getOrganization().setName(organization.hasName() ? organization.getName() : "");
            }
        }
        requestData.buildState();
        return requestData;
    }

    void handleFamilyGroup(Group group, PatientData patientData) {
        patientData.setFamilyId(group.getIdElement().getIdPart());
        if (group.hasExtension(Extensions.FAMILY_ID)) {
            final Extension extension = group.getExtensionByUrl(Extensions.FAMILY_ID);
            final Coding coding = (Coding) extension.getValue();
            patientData.setFamilyType(coding.getDisplay());
        } else {
            patientData.setFamilyType("solo");
        }
    }

    private static Name extractName(List<HumanName> humanNames) {
        final HumanName name = humanNames.get(0);
        return new Name(name.getFamily(), name.getGivenAsSingleString());
    }

    @SuppressWarnings("unchecked")
    private <T extends IBaseResource> List<T> getListFromProvider(IBundleProvider provider) {
        final List<T> resources = new ArrayList<>();
        if (!provider.isEmpty()) {
            for (IBaseResource sr : provider.getResources(0, provider.size())) {
                resources.add((T) sr);
            }
        }
        return resources;
    }

    private static class Name {
        public final String lastName;
        public final String firstName;
        public final String lastNameFirstName;

        public Name(String lastName, String firstName) {
            this.lastName = lastName;
            this.firstName = firstName;
            this.lastNameFirstName = lastName + ", " + firstName;
        }
    }
}
