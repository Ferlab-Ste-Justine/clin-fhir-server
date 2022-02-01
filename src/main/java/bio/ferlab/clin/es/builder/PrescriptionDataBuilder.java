package bio.ferlab.clin.es.builder;

import bio.ferlab.clin.es.config.ResourceDaoConfiguration;
import bio.ferlab.clin.es.data.FamilyGroupInfoData;
import bio.ferlab.clin.es.data.PatientData;
import bio.ferlab.clin.es.data.PrescriptionData;
import bio.ferlab.clin.utils.Extensions;
import ca.uhn.fhir.interceptor.model.RequestPartitionId;
import ca.uhn.fhir.jpa.partition.SystemRequestDetails;
import ca.uhn.fhir.rest.api.server.IBundleProvider;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import static bio.ferlab.clin.interceptors.TenantPartitionInterceptor.systemRequestDetails;

@Component
public class PrescriptionDataBuilder {
    private static final Logger log = LoggerFactory.getLogger(PrescriptionDataBuilder.class);

    private static final SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    public static final String MRN_CODE = "MR";

    private final ResourceDaoConfiguration configuration;

    public PrescriptionDataBuilder(ResourceDaoConfiguration configuration) {
        this.configuration = configuration;
    }

    public List<PrescriptionData> fromIds(Set<String> ids, RequestDetails requestDetails) {
        final List<PrescriptionData> prescriptionDataList = new ArrayList<>();
        for (final String serviceRequestId : ids) {
            final PrescriptionData prescriptionData = new PrescriptionData();
            final ServiceRequest serviceRequest = this.configuration.serviceRequestDAO.read(new IdType(serviceRequestId), systemRequestDetails);
            if (!serviceRequest.hasSubject()) {
                log.error(String.format("Cannot index ServiceRequest [%s]: resource has no subject.", serviceRequestId));
                continue;
            }
            final Reference subject = serviceRequest.getSubject();
            final Patient patient = this.configuration.patientDAO.read(new IdType(subject.getReference()), systemRequestDetails);

            this.handlePatient(patient, prescriptionData.getPatientInfo());
            this.handleServiceRequest(serviceRequest, prescriptionData);
            if (patient.hasExtension(Extensions.FAMILY_ID)) {
                final Extension extension = patient.getExtensionByUrl(Extensions.FAMILY_ID);
                final Reference ref = (Reference) extension.getValue();
                final Group group = this.configuration.groupDao.read(ref.getReferenceElement(), systemRequestDetails);
                this.handleFamilyGroup(group, prescriptionData.getFamilyInfo());
            }
            // clean-up + full text
            prescriptionData.getPatientInfo().setRequests(null);
            prescriptionData.applyFullText();
            prescriptionDataList.add(prescriptionData);
        }
        return prescriptionDataList;
    }

    void handlePatient(Patient patient, PatientData patientInfo) {
        patientInfo.setCid(patient.getIdElement().getIdPart());
        final List<String> mrns = Objects.requireNonNull(patient.getIdentifier()).stream()
                .filter(id -> id.getType().getCodingFirstRep().getCode().contentEquals(MRN_CODE))
                .map(Identifier::getValue).collect(Collectors.toList());

        patientInfo.getMrn().addAll(mrns);
        patientInfo.setGender(patient.getGender().getDisplay());

        if (patient.hasName()) {
            final Name name = extractName(patient.getName());
            patientInfo.setLastName(name.lastName);
            patientInfo.setFirstName(name.firstName);
            patientInfo.setLastNameFirstName(name.lastNameFirstName);
        }
        if (patient.getIdentifier().size() > 1) {
            patientInfo.setRamq(patient.getIdentifier().get(1).getValue());
        }

        if (patient.hasExtension(Extensions.IS_PROBAND)) {
            final Extension extension = patient.getExtensionByUrl(Extensions.IS_PROBAND);
            if (extension.hasValue()) {
                final BooleanType value = (BooleanType) extension.getValue();
                patientInfo.setPosition(value.booleanValue() ? "Proband" : "Parent");
            }
        }

        if (patient.hasExtension(Extensions.IS_FETUS)) {
            final Extension extension = patient.getExtensionByUrl(Extensions.IS_FETUS);
            if (extension.hasValue()) {
                final BooleanType value = (BooleanType) extension.getValue();
                patientInfo.setFetus(value.booleanValue());
            }
        }

        if (patient.hasManagingOrganization()) {
            final String id = patient.getManagingOrganization().getReference();
            final Organization organization = configuration.organizationDAO.read(new IdType(id), systemRequestDetails);
            patientInfo.getOrganization().setCid(organization.getIdElement().getIdPart());
            patientInfo.getOrganization().setName(organization.hasName() ? organization.getName() : "");
        }

        if (patient.hasBirthDate()) {
            patientInfo.setBirthDate(simpleDateFormat.format(patient.getBirthDate()));
        }

    }

    void handleServiceRequest(ServiceRequest serviceRequest, PrescriptionData prescriptionData) {
        prescriptionData.setCid(serviceRequest.getIdElement().getIdPart());
        prescriptionData.setStatus(serviceRequest.getStatus().toCode());
        if (serviceRequest.hasCode()) {
            final CodeableConcept code = serviceRequest.getCode();
            if (code.hasCoding()) {
                final Coding coding = code.getCoding().get(0);
                prescriptionData.getAnalysis().setCode(coding.getCode());
                prescriptionData.getAnalysis().setDisplay(coding.getDisplay());
            }
        }

        if (serviceRequest.hasExtension(Extensions.IS_SUBMITTED)) {
            final Extension extension = serviceRequest.getExtensionByUrl(Extensions.IS_SUBMITTED);
            final BooleanType valueBoolean = (BooleanType) extension.getValue();
            prescriptionData.setSubmitted(valueBoolean.getValue());
        }
        
        if (serviceRequest.hasExtension(Extensions.PROCEDURE_DIRECTED_BY)) {
            final Extension extension = serviceRequest.getExtensionByUrl(Extensions.PROCEDURE_DIRECTED_BY);
            final Reference ref = (Reference) extension.getValue();
            final PractitionerRole role = this.configuration.practitionerRoleDao.read(ref.getReferenceElement(), systemRequestDetails);
            final Practitioner practitioner = this.configuration.practitionerDao.read(role.getPractitioner().getReferenceElement(), systemRequestDetails);
            final Name name = extractName(practitioner.getName());
            prescriptionData.getApprover().setCid(practitioner.getIdElement().getIdPart());
            prescriptionData.getApprover().setFirstName(name.firstName);
            prescriptionData.getApprover().setLastName(name.lastName);
            prescriptionData.getApprover().setLastNameFirstName(name.lastNameFirstName);
        }
        
        if (serviceRequest.hasPerformer()) {
            prescriptionData.setLaboratory(serviceRequest.getPerformer().get(0).getReference());
        }

        if (serviceRequest.hasAuthoredOn()) {
            prescriptionData.setAuthoredOn(simpleDateFormat.format(serviceRequest.getAuthoredOn()));
        }

        if (serviceRequest.hasRequester()) {
            final String id = serviceRequest.getRequester().getReference();
            final Practitioner practitioner = configuration.practitionerDao.read(new IdType(id), systemRequestDetails);
            final Name name = extractName(practitioner.getName());
            prescriptionData.getPrescriber().setCid(practitioner.getIdElement().getIdPart());
            prescriptionData.getPrescriber().setLastName(name.lastName);
            prescriptionData.getPrescriber().setFirstName(name.firstName);
            prescriptionData.getPrescriber().setLastNameFirstName(name.lastNameFirstName);
        }

        if (serviceRequest.hasIdentifier()) {
            final var identifier = serviceRequest.getIdentifier().get(0);
            if (identifier.hasValue()) {
                prescriptionData.setMrn(identifier.getValue());
            }
            if (identifier.hasAssigner()) {
                final String id = identifier.getAssigner().getReference();
                final Organization organization = configuration.organizationDAO.read(new IdType(id), systemRequestDetails);
                prescriptionData.getOrganization().setCid(organization.getIdElement().getIdPart());
                prescriptionData.getOrganization().setName(organization.hasName() ? organization.getName() : "");
            }
        }

        prescriptionData.buildState();
    }

    void handleFamilyGroup(Group group, FamilyGroupInfoData familyGroupInfo) {
        familyGroupInfo.setCid(group.getIdElement().getIdPart());
        if (group.hasExtension(Extensions.FAMILY_ID)) {
            final Extension extension = group.getExtensionByUrl(Extensions.FAMILY_ID);
            final Coding coding = (Coding) extension.getValue();
            familyGroupInfo.setType(coding.getDisplay());
        } else {
            familyGroupInfo.setType("solo");
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
