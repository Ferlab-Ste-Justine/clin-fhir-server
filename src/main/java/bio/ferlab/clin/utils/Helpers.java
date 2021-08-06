package bio.ferlab.clin.utils;

import ca.uhn.fhir.rest.server.exceptions.AuthenticationException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.jetbrains.annotations.NotNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Helpers {
    private static final Logger logger = LoggerFactory.getLogger(Helpers.class);
    public static final String FORBIDDEN = "FORBIDDEN";

    @NotNull
    public static String extractAccessTokenFromBearer(String bearer) {
        String authorization = null;
        if (StringUtils.isNotBlank(bearer)) {
            authorization = bearer.split(" ")[1];
        }
        if (authorization == null) {
            logger.info("No access token provided in header");
            throw new AuthenticationException(FORBIDDEN);
        }

        return authorization;
    }
}
