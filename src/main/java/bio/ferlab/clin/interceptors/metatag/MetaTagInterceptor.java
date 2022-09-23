package bio.ferlab.clin.interceptors.metatag;

import bio.ferlab.clin.properties.BioProperties;
import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import ca.uhn.fhir.rest.api.RequestTypeEnum;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.exceptions.ForbiddenOperationException;
import org.apache.commons.lang3.StringUtils;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.springframework.stereotype.Component;

import java.util.EnumSet;
import java.util.List;
import java.util.Optional;

import static bio.ferlab.clin.interceptors.metatag.MetaTagResourceAccess.LDM_TAG_PREFIX;
import static bio.ferlab.clin.interceptors.metatag.MetaTagResourceAccess.USER_ALL_TAGS;

@Component
@Interceptor
public class MetaTagInterceptor {

  private final BioProperties bioProperties;
  private final MetaTagResourceAccess metaTagResourceAccess;
  private final MetaTagResourceVisitor metaTagResourceVisitor;
  
  public MetaTagInterceptor(BioProperties bioProperties, MetaTagResourceAccess metaTagResourceAccess, MetaTagResourceVisitor metaTagResourceVisitor) {
    this.bioProperties = bioProperties;
    this.metaTagResourceAccess = metaTagResourceAccess;
    this.metaTagResourceVisitor = metaTagResourceVisitor;
  }

  @Hook(Pointcut.STORAGE_PRESTORAGE_RESOURCE_CREATED)
  public void created(RequestDetails requestDetails, IBaseResource resource) {
    this.handleRequestAndResource(requestDetails, resource);
  }

  @Hook(Pointcut.STORAGE_PRESTORAGE_RESOURCE_UPDATED)
  public void updated(RequestDetails requestDetails, IBaseResource oldResource, IBaseResource newResource) {
    this.handleRequestAndResource(requestDetails, newResource);
  }

  // this hook (optional) will increase performance by adding _security in the query before SQL calls
  @Hook(Pointcut.SERVER_INCOMING_REQUEST_POST_PROCESSED)
  public void addTagParameter(RequestDetails requestDetails) {
    if (bioProperties.isTaggingEnabled() && bioProperties.isTaggingQueryParam() 
        && RequestTypeEnum.GET.equals(requestDetails.getRequestType()) 
        && metaTagResourceAccess.isResourceWithTags(requestDetails.getResourceName())) {
      final List<String> userTags =  metaTagResourceAccess.getUserTags(requestDetails);
      // ignore filter if no tags or system or LDM (because not all resources have LDM tags, so we want to see them)
      if(!userTags.isEmpty() && !userTags.contains(USER_ALL_TAGS) && userTags.stream().noneMatch(t -> t.startsWith(LDM_TAG_PREFIX))) {
        // we use "," separated query param _security because it's a OR relation, at least one should match.
        final String orTags = String.join(",", userTags);
        requestDetails.addParameter("_security", new String[]{orTags});
      }
    }
  }

  private boolean isValidRequestAndResource(RequestDetails requestDetails, IBaseResource resource) {
    return bioProperties.isTaggingEnabled() && EnumSet.of(RequestTypeEnum.POST, RequestTypeEnum.PUT).contains(requestDetails.getRequestType())
        && metaTagResourceAccess.isResourceWithTags(resource);
  }

  private void handleRequestAndResource(RequestDetails requestDetails, IBaseResource resource) {
    if(isValidRequestAndResource(requestDetails, resource)) {
      // clear all tags, easy solution to manage tags update
      Optional.ofNullable(resource.getMeta().getSecurity()).ifPresent(List::clear);
      this.addTagCode(resource, metaTagResourceVisitor.extractEpCode(requestDetails, resource));
      this.addTagCode(resource, metaTagResourceVisitor.extractLdmCode(requestDetails, resource));
      // we could allow cross modify if needed with a custom config boolean, for now it's mandatory
      if(!metaTagResourceAccess.canModifyResource(requestDetails, resource)) {
        throw new ForbiddenOperationException("Resource belongs to another organization");
      }
    }
  }
  
  private void addTagCode(IBaseResource resource, String code) {
    if (StringUtils.isNotBlank(code)) {
      resource.getMeta().addSecurity().setCode(code);
    }
  }
  
}
