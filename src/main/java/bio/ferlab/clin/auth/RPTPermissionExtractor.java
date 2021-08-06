package bio.ferlab.clin.auth;

import bio.ferlab.clin.auth.data.UserPermissions;
import bio.ferlab.clin.auth.data.UserPermissionsBuilder;
import bio.ferlab.clin.exceptions.RptIntrospectionException;
import bio.ferlab.clin.utils.Helpers;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;


@Component
public class RPTPermissionExtractor {
    private final KeycloakClient client;

    public RPTPermissionExtractor(KeycloakClient client) {
        this.client = client;
    }

    public UserPermissions extract(RequestDetails requestDetails) {
        try {
            final var bearer = requestDetails.getHeader(HttpHeaders.AUTHORIZATION);
            final var rpt = Helpers.extractAccessTokenFromBearer(bearer);
            final var response = this.client.introspectRpt(rpt);

            if (!response.getActive()) {
                throw new RptIntrospectionException(rpt);
            }

            final var builder = new UserPermissionsBuilder();
            response.getPermissions().forEach(permission -> builder.allowResource(permission.getResourceName(), permission.getScopes()));
            return builder.build();
        } catch (Exception e) {
            throw new RptIntrospectionException("");
        }
    }
}
