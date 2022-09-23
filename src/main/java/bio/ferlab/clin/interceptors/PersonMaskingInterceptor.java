package bio.ferlab.clin.interceptors;

import bio.ferlab.clin.es.config.ResourceDaoConfiguration;
import bio.ferlab.clin.interceptors.metatag.MetaTagResourceAccess;
import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import ca.uhn.fhir.jpa.searchparam.SearchParameterMap;
import ca.uhn.fhir.rest.api.server.IBundleProvider;
import ca.uhn.fhir.rest.api.server.IPreResourceShowDetails;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.param.ReferenceParam;
import ca.uhn.fhir.rest.param.TokenParam;
import lombok.RequiredArgsConstructor;
import org.hl7.fhir.instance.model.api.IAnyResource;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.*;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static bio.ferlab.clin.interceptors.metatag.MetaTagResourceAccess.USER_ALL_TAGS;

@Component
@Interceptor
@RequiredArgsConstructor
public class PersonMaskingInterceptor {
  
  public static final String RESTRICTED_FIELD = "*****";
  
  private final MetaTagResourceAccess metaTagResourceAccess;
  private final ResourceDaoConfiguration daoConfiguration;
  
  @Hook(Pointcut.STORAGE_PRESHOW_RESOURCES)
  public void preShow(IPreResourceShowDetails preResourceShowDetails, RequestDetails requestDetails) {
    final List<String> userTags = metaTagResourceAccess.getUserTags(requestDetails);
    preResourceShowDetails.forEach(resource -> {
      if (resource instanceof  Person) {
        this.maskSensitiveData(userTags, (Person) resource);
      } else if (resource instanceof  Bundle) { // not sure if it's possible but just in case because it's sensitive data
        ((Bundle) resource).getEntry().stream().map(Bundle.BundleEntryComponent::getResource).filter(Person.class::isInstance)
            .forEach(r -> this.maskSensitiveData(userTags, (Person) r));
      }
    });
  }

  private void maskSensitiveData( List<String> userTags, Person person) {
    // Person resources aren't tagged with EP, instead let's find out all related Patients
    final List<Patient> patients = fetchPatients(person);
    final List<ServiceRequest> serviceRequests = fetchServiceRequests(patients);
    // extract tags from all patients and service requests
    final Set<String> resourceTags = patients.stream().flatMap(p -> metaTagResourceAccess.getResourceTags(p).stream()).collect(Collectors.toSet());
    resourceTags.addAll(serviceRequests.stream().flatMap(sr -> metaTagResourceAccess.getResourceTags(sr).stream()).collect(Collectors.toSet()));
    // if user has no reasons to see this person data, mask them
    if (!userTags.contains(USER_ALL_TAGS) && resourceTags.stream().noneMatch(userTags::contains)) {
      person.getNameFirstRep().setFamily(RESTRICTED_FIELD);
      person.getNameFirstRep().setGiven(List.of(new StringType(RESTRICTED_FIELD)));
      person.getIdentifierFirstRep().setValue(RESTRICTED_FIELD);
    }
  }
  
  private List<Patient> fetchPatients(Person person) {
    final IBundleProvider results = daoConfiguration.personDAO.search(SearchParameterMap.newSynchronous()
        .add(IAnyResource.SP_RES_ID, new TokenParam(person.getIdElement().getIdPart()))
        .addInclude(Person.INCLUDE_PATIENT));
    return results.isEmpty() ? List.of() : results.getAllResources().stream()
        .filter(Patient.class::isInstance).map(Patient.class::cast).collect(Collectors.toList());
  }
  
  private List<ServiceRequest> fetchServiceRequests(List<Patient> patients) {
    final List<ServiceRequest> serviceRequests = new ArrayList<>();
    patients.forEach(patient -> {
      final IBundleProvider results = daoConfiguration.serviceRequestDAO.search(SearchParameterMap.newSynchronous()
          .add(ServiceRequest.SP_PATIENT, new ReferenceParam(patient.getIdElement().getIdPart())));
      serviceRequests.addAll(results.isEmpty() ? List.of() :
          results.getAllResources().stream().map(ServiceRequest.class::cast).collect(Collectors.toList()));
    });
    return serviceRequests;
  }
}
