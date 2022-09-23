package bio.ferlab.clin.interceptors.metatag;

import bio.ferlab.clin.exceptions.RptIntrospectionException;
import bio.ferlab.clin.properties.BioProperties;
import bio.ferlab.clin.utils.Helpers;
import ca.uhn.fhir.rest.api.RequestTypeEnum;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import com.auth0.jwt.JWT;
import com.auth0.jwt.interfaces.Claim;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.hl7.fhir.instance.model.api.IBaseCoding;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.ServiceRequest;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.EnumSet;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class MetaTagResourceAccess {

  // all meta/tags compatible resources, adding one need an implementation in MetaTagResourceVisitor
  public static final List<String> RESOURCES_WITH_TAGS = List.of("ServiceRequest", "Patient", "Observation", "ClinicalImpression");
  public static final String TOKEN_ATTR_FHIR_ORG_ID = "fhir_organization_id";
  public static final String USER_ALL_TAGS = "*";
  public static final String LDM_TAG_PREFIX = "LDM";
  
  private final BioProperties bioProperties;

  public boolean canSeeResource(RequestDetails requestDetails, IBaseResource resource) {
    // POST can be a bundle or graphql query
    return EnumSet.of(RequestTypeEnum.GET, RequestTypeEnum.POST).contains(requestDetails.getRequestType())
        && canAccessResource(requestDetails, resource);
  }

  public boolean canModifyResource(RequestDetails requestDetails, IBaseResource resource) {
    return EnumSet.of(RequestTypeEnum.POST, RequestTypeEnum.PUT, RequestTypeEnum.DELETE).contains(requestDetails.getRequestType())
       && canAccessResource(requestDetails, resource);
  }

  private boolean canAccessResource(RequestDetails requestDetails, IBaseResource resource) {
    if (bioProperties.isTaggingEnabled() && isResourceWithTags(resource)) {
      final List<String> userTags = getUserTags(requestDetails);
      final List<String> resourceTags = getResourceTags(resource);
      if (userTags.contains(USER_ALL_TAGS)) {
        return true;  // can see all
      } else if (resource instanceof ServiceRequest) {
        return resourceTags.stream().anyMatch(userTags::contains) || // EP ...
            userTags.stream().anyMatch(t -> t.startsWith(LDM_TAG_PREFIX)); // ... any LDM can see all
      } else {
        return true; // every other tagged resources are visible
      }
    }
    return true;
  }
  
  public List<String> getResourceTags(IBaseResource resource) {
    return resource.getMeta().getSecurity().stream().map(IBaseCoding::getCode).collect(Collectors.toList());
  }

  public List<String> getUserTags(RequestDetails requestDetails) {
    final var bearer = requestDetails.getHeader(HttpHeaders.AUTHORIZATION);
    final var rpt = Helpers.extractAccessTokenFromBearer(bearer);
    final var jwt = JWT.decode(rpt);

    final List<String> tags = new ArrayList<>();

    final var isSystem = Optional.ofNullable(jwt.getClaim("azp")).map(Claim::asString)
        .orElse("").equals(bioProperties.getAuthSystemId());

    if (isSystem) {
      tags.add(USER_ALL_TAGS);
    } else {
      tags.addAll(Optional.ofNullable(jwt.getClaim(TOKEN_ATTR_FHIR_ORG_ID)).map(c -> c.asList(String.class))
          .orElseThrow(() -> new RptIntrospectionException("missing " + TOKEN_ATTR_FHIR_ORG_ID)));
    }

    return tags;
  }

  public boolean isResourceWithTags(String resourceName) {
    return StringUtils.isNotBlank(resourceName) && RESOURCES_WITH_TAGS.contains(resourceName);
  }

  public boolean isResourceWithTags(IBaseResource resource) {
    return resource != null && this.isResourceWithTags(resource.getClass().getSimpleName());
  }
}
