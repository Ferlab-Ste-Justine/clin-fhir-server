package bio.ferlab.clin.utils;

import org.hl7.fhir.r4.model.*;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class FhirUtilsTest {

  @Test
  void formatResource() {
    final Resource patient = new Patient().setId("foo");
    assertEquals("Patient/foo", FhirUtils.formatResource(patient));
  }

  @Test
  void toReference() {
    final Resource patient = new Patient().setId("foo");
    final String expected = new Reference("Patient/foo").getReference();
    assertEquals(expected, FhirUtils.toReference(patient).getReference());
  }

  @Test
  void extractId() {
    assertNull(FhirUtils.extractId((Reference) null));
    assertNull(FhirUtils.extractId(new Reference()));
    assertNull(FhirUtils.extractId(new Reference().setReference("foo")));
    assertEquals("id", FhirUtils.extractId(new Reference().setReference("TypeResource/id")));
  }

  @Test
  void extractId_string() {
    assertNull(FhirUtils.extractId((String) null));
    assertNull(FhirUtils.extractId(""));
    assertNull(FhirUtils.extractId("foo"));
    assertEquals("100307", FhirUtils.extractId("Patient/100307/_history/2"));
  }

  @Test
  void extractAllOfType() {
    final Bundle innerBundle = new Bundle();
    innerBundle.addEntry().setResource(new ServiceRequest());
    List<ServiceRequest> results = FhirUtils.extractAllOfType(List.of(new Person(), new Patient(), new ServiceRequest(), innerBundle), ServiceRequest.class);
    assertEquals(2, results.size());
  }
  
  @Test
  void equals() {
    final Patient p1 = new Patient();
    p1.setId("1");
    final Patient p2 = new Patient();
    p2.setId("1");
    assertTrue(FhirUtils.equals(p1, p2));
  }

  @Test
  void getPerformerIds() {
    final var serviceRequest = new ServiceRequest();
    assertTrue(FhirUtils.getPerformerIds(serviceRequest, null).isEmpty());
    serviceRequest.getPerformer().add(new Reference("Organization/bar"));
    assertTrue(FhirUtils.getPerformerIds(serviceRequest, null).isEmpty());
    assertEquals(1, FhirUtils.getPerformerIds(serviceRequest, Organization.class).size());
    assertEquals("bar", FhirUtils.getPerformerIds(serviceRequest, Organization.class).stream().findFirst().orElse(null));
    serviceRequest.getPerformer().add(new Reference("PractitionerRole/1"));
    serviceRequest.getPerformer().add(new Reference("PractitionerRole/2"));
    assertEquals(2, FhirUtils.getPerformerIds(serviceRequest, PractitionerRole.class).size());
    assertEquals("1", FhirUtils.getPerformerIds(serviceRequest, PractitionerRole.class).get(0));
    assertEquals("2", FhirUtils.getPerformerIds(serviceRequest, PractitionerRole.class).get(1));
  }

}