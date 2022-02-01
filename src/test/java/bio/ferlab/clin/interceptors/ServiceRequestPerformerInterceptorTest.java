package bio.ferlab.clin.interceptors;

import bio.ferlab.clin.es.config.ResourceDaoConfiguration;
import bio.ferlab.clin.exceptions.RptIntrospectionException;
import ca.uhn.fhir.jpa.api.dao.IFhirResourceDao;
import ca.uhn.fhir.rest.api.RequestTypeEnum;
import ca.uhn.fhir.rest.api.server.IBundleProvider;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.exceptions.InvalidRequestException;
import com.auth0.jwk.Jwk;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.*;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.List;
import java.util.Locale;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

class ServiceRequestPerformerInterceptorTest {

  final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
  final IFhirResourceDao<OrganizationAffiliation> dao = Mockito.mock(IFhirResourceDao.class);
  final ResourceDaoConfiguration configuration = new ResourceDaoConfiguration(null, null, null, null
  , dao, null, null, null, null);
  final ServiceRequestPerformerInterceptor interceptor = new ServiceRequestPerformerInterceptor(configuration);
  
  @Test
  @DisplayName("ServiceRequest - missing code")
  void missingCode() {
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.POST);
    final ServiceRequest serviceRequest = new ServiceRequest().setCode(null);
    Exception ex = Assertions.assertThrows(
        InvalidRequestException.class,
        () -> interceptor.created(requestDetails, serviceRequest)
    );
    assertEquals("Missing code/coding in service request", ex.getMessage());
  }

  @Test
  @DisplayName("ServiceRequest - missing coding")
  void missingCoding() {
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.POST);
    final ServiceRequest serviceRequest = new ServiceRequest().setCode(new CodeableConcept().setCoding(null));
    Exception ex = Assertions.assertThrows(
        InvalidRequestException.class,
        () -> interceptor.created(requestDetails, serviceRequest)
    );
    assertEquals("Missing code/coding in service request", ex.getMessage());
  }

  @Test
  @DisplayName("ServiceRequest - empty code")
  void emptyCode() {
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.POST);
    final ServiceRequest serviceRequest = new ServiceRequest().setCode(new CodeableConcept().setCoding(List.of(new Coding().setCode(""))));
    Exception ex = Assertions.assertThrows(
        InvalidRequestException.class,
        () -> interceptor.created(requestDetails, serviceRequest)
    );
    assertEquals("Missing code/coding in service request", ex.getMessage());
  }

  @Test
  @DisplayName("ServiceRequest - no matching affiliation")
  void noAffiliation() {
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.POST);
    final ServiceRequest serviceRequest = new ServiceRequest().setCode(new CodeableConcept().setCoding(List.of(new Coding().setCode("foo"))));
    final IBundleProvider bundle = Mockito.mock(IBundleProvider.class);
    when(dao.search(any(), any())).thenReturn(bundle);
    when(bundle.isEmpty()).thenReturn(true);
    Exception ex = Assertions.assertThrows(
        InvalidRequestException.class,
        () -> interceptor.created(requestDetails, serviceRequest)
    );
    assertEquals("Can't find organization affiliation attached to code foo", ex.getMessage());
  }

  @Test
  @DisplayName("ServiceRequest - create found an affiliation")
  void createMatchAnAffiliation() {
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.POST);
    final ServiceRequest serviceRequest = new ServiceRequest().setCode(new CodeableConcept().setCoding(List.of(new Coding().setCode("foo"))));
    final IBundleProvider bundle = Mockito.mock(IBundleProvider.class);
    when(dao.search(any(), any())).thenReturn(bundle);
    when(bundle.isEmpty()).thenReturn(false);
    final OrganizationAffiliation affiliation = new OrganizationAffiliation().setParticipatingOrganization(new Reference("bar"));
    when(bundle.getAllResources()).thenReturn(List.of(affiliation));
    interceptor.created(requestDetails, serviceRequest);
    assertEquals("bar", serviceRequest.getPerformer().get(0).getReference());
  }

  @Test
  @DisplayName("ServiceRequest - update found an affiliation")
  void updateMatchAnAffiliation() {
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.PUT);
    final ServiceRequest serviceRequest = new ServiceRequest().setCode(new CodeableConcept().setCoding(List.of(new Coding().setCode("foo"))));
    final IBundleProvider bundle = Mockito.mock(IBundleProvider.class);
    when(dao.search(any(), any())).thenReturn(bundle);
    when(bundle.isEmpty()).thenReturn(false);
    final OrganizationAffiliation affiliation = new OrganizationAffiliation().setParticipatingOrganization(new Reference("bar"));
    when(bundle.getAllResources()).thenReturn(List.of(affiliation));
    interceptor.updated(requestDetails, null, serviceRequest);
    assertEquals("bar", serviceRequest.getPerformer().get(0).getReference());
  }

}