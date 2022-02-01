package bio.ferlab.clin.properties;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "bio")
@Data
public class BioProperties {
    private final boolean isBioEsEnabled;
    private final String esHost;
    private final int esPort;
    private final String esScheme;
    private final String esPatientsIndex;
    private final String esPrescriptionsIndex;
    private final boolean isAuthEnabled;
    private final String authServerUrl;
    private final String authRealm;
    private final boolean isDisableSslValidation;
    private final boolean isAuditsEnabled;
    private final boolean isAuthorizationEnabled;
    private final String authClientId;
    private final String authClientSecret;
    private final String authSystemId;

    public BioProperties(
            @Value("${bio.elasticsearch.enabled}") boolean isBioEsEnabled,
            @Value("${bio.elasticsearch.host}") String esHost,
            @Value("${bio.elasticsearch.port}") int esPort,
            @Value("${bio.elasticsearch.scheme}") String esScheme,
            @Value("${bio.elasticsearch.patients-index}") String esPatientsIndex,
            @Value("${bio.elasticsearch.prescriptions-index}") String esPrescriptionsIndex,
            @Value("${bio.auth.enabled}") boolean isAuthEnabled,
            @Value("${bio.auth.server-url}") String authServerUrl,
            @Value("${bio.auth.realm}") String authRealm,
            @Value("${bio.auth.disable-ssl-validation}") boolean isDisableSslValidation,
            @Value("${bio.audits.enabled}") boolean isAuditsEnabled,
            @Value("${bio.auth.authorization.enabled}") boolean isAuthorizationEnabled,
            @Value("${bio.auth.authorization.client-id}") String authClientId,
            @Value("${bio.auth.authorization.client-secret}") String authClientSecret,
            @Value("${bio.auth.authorization.system-id}") String authSystemId
    ) {
        this.isBioEsEnabled = isBioEsEnabled;
        this.esHost = esHost;
        this.esPort = esPort;
        this.esScheme = esScheme;
        this.esPatientsIndex = esPatientsIndex;
        this.esPrescriptionsIndex = esPrescriptionsIndex;
        this.isAuthEnabled = isAuthEnabled;
        this.authServerUrl = authServerUrl;
        this.authRealm = authRealm;
        this.isDisableSslValidation = isDisableSslValidation;
        this.isAuditsEnabled = isAuditsEnabled;
        this.isAuthorizationEnabled = isAuthorizationEnabled;
        this.authClientId = authClientId;
        this.authClientSecret = authClientSecret;
        this.authSystemId = authSystemId;
    }
}
