package bio.ferlab.clin.interceptors;

import bio.ferlab.clin.auth.RPTPermissionExtractor;
import bio.ferlab.clin.auth.data.Permission;
import bio.ferlab.clin.auth.data.UserPermissions;
import ca.uhn.fhir.jpa.app.AppProperties;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.interceptor.auth.IAuthRule;
import org.hl7.fhir.r4.model.Patient;
import org.hl7.fhir.r4.model.Resource;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

class BioAuthInterceptorTest {
  
  final AppProperties appProperties = new AppProperties();
  final RPTPermissionExtractor rptPermissionExtractor = Mockito.mock(RPTPermissionExtractor.class);
  final BioAuthInterceptor bioAuthInterceptor = new BioAuthInterceptor(rptPermissionExtractor, appProperties);
  
  private static final boolean testRule(IAuthRule rule, String operation, Class<? extends Resource> clazz) {
    final String ruleStr = rule.toString();
    return ruleStr.contains(operation.toUpperCase()) && ruleStr.contains(clazz.getSimpleName());
  }

  private static final boolean testRule(IAuthRule rule, String operation) {
    final String ruleStr = rule.toString();
    return ruleStr.contains(operation.toUpperCase());
  }

  @Nested
  class BuildRuleList {
    @Test
    void lastRuleDenyAll() {
      final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
      final List<Permission> perms = List.of();
      final UserPermissions userPermissions = new UserPermissions(perms.toArray(Permission[]::new));

      when(rptPermissionExtractor.extract(any())).thenReturn(userPermissions);
      var rules = bioAuthInterceptor.buildRuleList(requestDetails);
      
      assertTrue(testRule(rules.get(rules.size() - 1), "ALL"));
    }
    
    @Test
    void crudPatient() {
      final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
      final List<Permission> perms = List.of(
        new Permission(Patient.class, true, true, true, true)
      );
      final UserPermissions userPermissions = new UserPermissions(perms.toArray(Permission[]::new));
      
      when(rptPermissionExtractor.extract(any())).thenReturn(userPermissions);
      var rules = bioAuthInterceptor.buildRuleList(requestDetails);
      
      assertTrue(testRule(rules.get(0), "READ", Patient.class));
      assertTrue(testRule(rules.get(1), "WRITE", Patient.class));
      assertTrue(testRule(rules.get(2), "CREATE", Patient.class));
      assertTrue(testRule(rules.get(3), "DELETE", Patient.class));
    }

    @Test
    void readPatient() {
      final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
      final List<Permission> perms = List.of(
          new Permission(Patient.class, false, true, false, false)
      );
      final UserPermissions userPermissions = new UserPermissions(perms.toArray(Permission[]::new));

      when(rptPermissionExtractor.extract(any())).thenReturn(userPermissions);
      var rules = bioAuthInterceptor.buildRuleList(requestDetails);

      assertTrue(testRule(rules.get(0), "READ", Patient.class));
    }
    
    @Test
    void createPatient() {
      final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
      final List<Permission> perms = List.of(
          new Permission(Patient.class, true, false, false, false)
      );
      final UserPermissions userPermissions = new UserPermissions(perms.toArray(Permission[]::new));

      when(rptPermissionExtractor.extract(any())).thenReturn(userPermissions);
      var rules = bioAuthInterceptor.buildRuleList(requestDetails);

      assertTrue(testRule(rules.get(0), "CREATE", Patient.class));
    }

    @Test
    void writePatient() {
      final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
      final List<Permission> perms = List.of(
          new Permission(Patient.class, false, false, true, false)
      );
      final UserPermissions userPermissions = new UserPermissions(perms.toArray(Permission[]::new));

      when(rptPermissionExtractor.extract(any())).thenReturn(userPermissions);
      var rules = bioAuthInterceptor.buildRuleList(requestDetails);

      assertTrue(testRule(rules.get(0), "WRITE", Patient.class));
    }

    @Test
    void deletePatient() {
      final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
      final List<Permission> perms = List.of(
          new Permission(Patient.class, false, false, false, true)
      );
      final UserPermissions userPermissions = new UserPermissions(perms.toArray(Permission[]::new));

      when(rptPermissionExtractor.extract(any())).thenReturn(userPermissions);
      var rules = bioAuthInterceptor.buildRuleList(requestDetails);

      assertTrue(testRule(rules.get(0), "DELETE", Patient.class));
    }

    @Test
    void graphql() {
      final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
      final List<Permission> perms = List.of();
      final UserPermissions userPermissions = new UserPermissions(perms.toArray(Permission[]::new));

      when(rptPermissionExtractor.extract(any())).thenReturn(userPermissions);
      var rules = bioAuthInterceptor.buildRuleList(requestDetails);

      assertTrue(testRule(rules.get(1), "GRAPHQL"));
    }
  }

}