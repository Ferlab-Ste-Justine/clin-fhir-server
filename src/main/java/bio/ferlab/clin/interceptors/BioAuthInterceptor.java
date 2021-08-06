package bio.ferlab.clin.interceptors;

import bio.ferlab.clin.auth.RPTPermissionExtractor;
import bio.ferlab.clin.auth.data.Permission;
import bio.ferlab.clin.auth.data.UserPermissions;
import bio.ferlab.clin.utils.Constants;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.interceptor.auth.AuthorizationInterceptor;
import ca.uhn.fhir.rest.server.interceptor.auth.IAuthRule;
import ca.uhn.fhir.rest.server.interceptor.auth.IAuthRuleBuilder;
import ca.uhn.fhir.rest.server.interceptor.auth.RuleBuilder;
import org.hl7.fhir.r4.model.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BioAuthInterceptor extends AuthorizationInterceptor {
    private final RPTPermissionExtractor permissionExtractor;

    public BioAuthInterceptor(RPTPermissionExtractor permissionExtractor) {
        this.permissionExtractor = permissionExtractor;
    }

    private <T extends Resource> void
    allowReadPermissionByType(IAuthRuleBuilder builder, Class<T> resourceType) {
        builder.allow().read().resourcesOfType(resourceType).withAnyId().andThen();
    }

    private <T extends Resource> void
    allowWritePermissionByType(IAuthRuleBuilder builder, Class<T> resourceType) {
        builder.allow().create().resourcesOfType(resourceType).withAnyId().andThen();
    }

    private <T extends Resource> void
    allowUpdatePermissionByType(IAuthRuleBuilder builder, Class<T> resourceType) {
        builder.allow().write().resourcesOfType(resourceType).withAnyId().andThen();
    }

    private <T extends Resource> void
    allowDeletePermissionByType(IAuthRuleBuilder builder, Class<T> resourceType) {
        builder.allow().delete().resourcesOfType(resourceType).withAnyId().andThen();
    }

    private void handlePermission(IAuthRuleBuilder builder, Permission<? extends Resource> permission) {
        if (permission.isRead()) {
            allowReadPermissionByType(builder, permission.getResourceType());
        }
        if (permission.isUpdate()) {
            allowUpdatePermissionByType(builder, permission.getResourceType());
        }
        if (permission.isCreate()) {
            allowWritePermissionByType(builder, permission.getResourceType());
        }
        if (permission.isDelete()) {
            allowDeletePermissionByType(builder, permission.getResourceType());
        }
    }

    private IAuthRuleBuilder handleUserPermissions(UserPermissions userPermissions) {
        final var builder = new RuleBuilder();
        for (Permission<? extends Resource> permission : userPermissions.getPermissions()) {
            handlePermission(builder, permission);
        }
        return builder;
    }

    private void applyRulesOnTransactions(IAuthRuleBuilder ruleBuilder) {
        ruleBuilder.allow().transaction().withAnyOperation().andApplyNormalRules().andThen();
    }

    private void applyRulesOnGraphql(IAuthRuleBuilder ruleBuilder) {
        ruleBuilder.allow().graphQL().any().andThen();
    }

    private void applyRulesOnValidate(IAuthRuleBuilder ruleBuilder) {
        ruleBuilder.allow().operation().named(Constants.VALIDATE_OPERATION).onAnyType().andRequireExplicitResponseAuthorization().andThen();
    }

    @Override
    public List<IAuthRule> buildRuleList(RequestDetails requestDetails) {
        final var permissions = this.permissionExtractor.extract(requestDetails);
        final var ruleBuilder = this.handleUserPermissions(permissions);
        this.applyRulesOnTransactions(ruleBuilder);
        this.applyRulesOnGraphql(ruleBuilder);
        this.applyRulesOnValidate(ruleBuilder);
        return ruleBuilder.denyAll().build();
    }
}
