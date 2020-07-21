package bio.ferlab.clin.interceptors;

import bio.ferlab.clin.context.ServiceContext;
import bio.ferlab.clin.context.ThreadLocalServiceContext;
import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import ca.uhn.fhir.jpa.starter.HapiProperties;
import com.auth0.jwk.Jwk;
import com.auth0.jwk.JwkProvider;
import com.auth0.jwk.JwkProviderBuilder;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.Verification;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.net.ssl.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.security.interfaces.RSAPublicKey;

@Interceptor
public class AccessTokenInterceptor {

  private static final ObjectMapper mapper = new ObjectMapper();
  private final Logger logger = LoggerFactory.getLogger(AccessTokenInterceptor.class);

  static{
    if(HapiProperties.isSSLValidationDisabled()) {
      getDisabledSSLContext();
    }
  }

  @Hook(Pointcut.SERVER_INCOMING_REQUEST_PRE_PROCESSED)
  public void validateToken(HttpServletRequest request, HttpServletResponse response){
    String bearer = request.getHeader(HttpHeaders.AUTHORIZATION);
    String accessToken = null;

    try {
      if(StringUtils.isNotBlank(bearer)){
        //The access token is always preceeded by "Bearer "
        accessToken = bearer.split(" ")[1];
      }

      //Decode token
      DecodedJWT decodedJWT = JWT.decode(accessToken);

      //Save user info in ThreadLocal for later use
      ServiceContext sc = new ServiceContext();
      sc.setUserId(decodedJWT.getSubject());
      sc.setLocale(request.getLocale());
      ThreadLocalServiceContext.getInstance().set(sc);

      //Get public keys
      String url = StringUtils.appendIfMissing(HapiProperties.getAuthServerUrl(), "/") + "auth/realms/" + HapiProperties.getAuthRealm() + "/protocol/openid-connect/certs";
      JwkProvider provider =  new JwkProviderBuilder(new URL(url)).build();
      Jwk jwk = provider.get(decodedJWT.getKeyId());
      Algorithm algorithm = Algorithm.RSA256((RSAPublicKey) jwk.getPublicKey(), null);
      Verification verifier = JWT.require(algorithm);

      //Will throw exception if invalid
      verifier.build().verify(decodedJWT);
    } catch (Exception e) {
      response.setStatus(HttpStatus.SC_FORBIDDEN);
      throw new ca.uhn.fhir.rest.server.exceptions.AuthenticationException(e.getMessage());
    }
  }

  private static SSLContext getDisabledSSLContext(){
    //Disable SSL Validation during local development with self signed certificates.
    SSLContext sc = null;
    try {
      // Create a trust manager that does not validate certificate chains
      TrustManager[] trustAllCerts = new TrustManager[] {
              new X509TrustManager() {
                public X509Certificate[] getAcceptedIssuers() {
                  return null;
                }
                public void checkClientTrusted(X509Certificate[] certs, String authType) {
                }
                public void checkServerTrusted(X509Certificate[] certs, String authType) {
                }
              }
      };

      // Install the all-trusting trust manager
      sc = SSLContext.getInstance("SSL");
      sc.init(null, trustAllCerts, new java.security.SecureRandom());
      HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

      // Create all-trusting host name verifier
      HostnameVerifier allHostsValid = new HostnameVerifier() {
        public boolean verify(String hostname, SSLSession session) {
          return true;
        }
      };

      // Install the all-trusting host verifier
      HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);

    } catch (NoSuchAlgorithmException | KeyManagementException e) {
      e.printStackTrace();
    }

    return sc;
  }
}
