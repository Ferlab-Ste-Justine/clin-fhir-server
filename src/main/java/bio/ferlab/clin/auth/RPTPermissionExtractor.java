package bio.ferlab.clin.auth;

import bio.ferlab.clin.auth.data.UserPermissions;
import bio.ferlab.clin.auth.data.UserPermissionsBuilder;
import bio.ferlab.clin.exceptions.RptIntrospectionException;
import bio.ferlab.clin.utils.Helpers;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import com.auth0.jwt.JWT;
import com.auth0.jwt.interfaces.Claim;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.Optional;

import static bio.ferlab.clin.auth.KeycloakClient.TOKEN_ATTR_FHIR_ORG_ID;


@Component
public class RPTPermissionExtractor {
    private final KeycloakClient client;
    public RPTPermissionExtractor(KeycloakClient client) {
        this.client = client;
    }
    
    public String getFhirOrganizationId(RequestDetails requestDetails) {
        final var bearer = requestDetails.getHeader(HttpHeaders.AUTHORIZATION);
        final var rpt = Helpers.extractAccessTokenFromBearer(bearer);
        return Optional.ofNullable(JWT.decode(rpt).getClaim(TOKEN_ATTR_FHIR_ORG_ID)).map(Claim::asString)
            .orElseThrow(() -> new RptIntrospectionException("missing " + TOKEN_ATTR_FHIR_ORG_ID));
    }

    public UserPermissions extract(RequestDetails requestDetails) {
        final var bearer = requestDetails.getHeader(HttpHeaders.AUTHORIZATION);
        final var rpt = Helpers.extractAccessTokenFromBearer(bearer);
        final var response = this.client.introspectRpt(rpt);
        
        if (Optional.ofNullable(response.getPermissions()).isEmpty()) {
            throw new RptIntrospectionException("rpt token is required");
        }
    
        if (!response.isActive()) {
            throw new RptIntrospectionException("token is not active");
        }
    
        if (response.isExpired()) {
            throw new RptIntrospectionException("token is expired");
        }
    
        final var builder = new UserPermissionsBuilder();
        Optional.ofNullable(response.getPermissions())
                .orElse(Collections.emptyList())
                .forEach(permission -> builder.allowResource(permission.getResourceName(), permission.getScopes()));
        return builder.build();
    }
}
