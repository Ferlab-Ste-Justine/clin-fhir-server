package bio.ferlab.clin.interceptors;

import ca.uhn.fhir.model.dstu2.resource.Patient;
import ca.uhn.fhir.model.dstu2.resource.Person;
import ca.uhn.fhir.rest.api.server.IPreResourceShowDetails;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.api.server.SimplePreResourceAccessDetails;
import ca.uhn.fhir.rest.api.server.SimplePreResourceShowDetails;
import ca.uhn.fhir.rest.server.servlet.ServletRequestDetails;
import org.hl7.fhir.r4.model.ServiceRequest;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import javax.servlet.http.HttpServletRequest;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

class SameRequestInterceptorTest {

  @Test
  void concatResources() {
    final var sr1 = Mockito.mock(HttpServletRequest.class);
    final var rd1 = Mockito.mock(ServletRequestDetails.class);
    when(rd1.getServletRequest()).thenReturn(sr1);
    final SimplePreResourceAccessDetails part11 = new SimplePreResourceAccessDetails(new ServiceRequest());
    final SimplePreResourceAccessDetails part12 = new SimplePreResourceAccessDetails(new Patient());
    final SimplePreResourceAccessDetails part13 = new SimplePreResourceAccessDetails(new Person());

    final var sr2 = Mockito.mock(HttpServletRequest.class);
    final var rd2 = Mockito.mock(ServletRequestDetails.class);
    when(rd2.getServletRequest()).thenReturn(sr2);
    final SimplePreResourceAccessDetails part21 = new SimplePreResourceAccessDetails(new ServiceRequest());
    final SimplePreResourceAccessDetails part22 = new SimplePreResourceAccessDetails(new Patient());
    
    final SameRequestInterceptor interceptor = new SameRequestInterceptor();
    interceptor.concatResources(part11, rd1);
    interceptor.concatResources(part12, rd1);
    interceptor.concatResources(part13, rd1);

    interceptor.concatResources(part21, rd2);
    interceptor.concatResources(part22, rd2);
    
    assertEquals(3, interceptor.get(rd1).size());
    assertEquals(2, interceptor.get(rd2).size());
  }

  @Test
  void concatResources_batch() {
    final var rootRequest = Mockito.mock(HttpServletRequest.class);

    final var rd1 = Mockito.mock(ServletRequestDetails.class);
    when(rd1.getServletRequest()).thenReturn(rootRequest);
    final SimplePreResourceAccessDetails part11 = new SimplePreResourceAccessDetails(new ServiceRequest());
    final SimplePreResourceAccessDetails part12 = new SimplePreResourceAccessDetails(new Patient());
    final SimplePreResourceAccessDetails part13 = new SimplePreResourceAccessDetails(new Person());

    final var rd2 = Mockito.mock(ServletRequestDetails.class);
    when(rd2.getServletRequest()).thenReturn(rootRequest);
    final SimplePreResourceAccessDetails part21 = new SimplePreResourceAccessDetails(new ServiceRequest());
    final SimplePreResourceAccessDetails part22 = new SimplePreResourceAccessDetails(new Patient());

    final SameRequestInterceptor interceptor = new SameRequestInterceptor();
    interceptor.concatResources(part11, rd1);
    interceptor.concatResources(part12, rd1);
    interceptor.concatResources(part13, rd1);

    interceptor.concatResources(part21, rd2);
    interceptor.concatResources(part22, rd2);

    assertEquals(5, interceptor.get(rd1).size());
    assertEquals(5, interceptor.get(rd2).size());
  }
}