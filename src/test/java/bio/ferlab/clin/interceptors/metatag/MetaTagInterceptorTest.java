package bio.ferlab.clin.interceptors.metatag;

import bio.ferlab.clin.exceptions.RptIntrospectionException;
import bio.ferlab.clin.properties.BioProperties;
import ca.uhn.fhir.rest.api.RequestTypeEnum;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.exceptions.ForbiddenOperationException;
import org.hl7.fhir.instance.model.api.IBaseCoding;
import org.hl7.fhir.instance.model.api.IBaseMetaType;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.List;

import static bio.ferlab.clin.interceptors.metatag.MetaTagResourceAccess.USER_ALL_TAGS;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

class MetaTagInterceptorTest {

  final BioProperties bioProperties = Mockito.mock(BioProperties.class);
  final MetaTagResourceAccess metaTagResourceAccess = Mockito.mock(MetaTagResourceAccess.class);
  final MetaTagResourceVisitor metaTagResourceVisitor = Mockito.mock(MetaTagResourceVisitor.class);
  final MetaTagInterceptor metaTagInterceptor = new MetaTagInterceptor(bioProperties, metaTagResourceAccess, metaTagResourceVisitor);
  
  @BeforeEach
  void beforeEach() {
    when(bioProperties.isTaggingEnabled()).thenReturn(true);
    when(bioProperties.isTaggingQueryParam()).thenReturn(true);
  }
  
  @Test
  void addTagParameter_GET_valid_resource() {
    final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.GET);
    when(requestDetails.getResourceName()).thenReturn("ValidResource");
    when(metaTagResourceAccess.isResourceWithTags(any(String.class))).thenReturn(true);
    when(metaTagResourceAccess.getUserTags(any())).thenReturn(List.of("tag1", "tag2"));
    metaTagInterceptor.addTagParameter(requestDetails);
    verify(bioProperties).isTaggingEnabled();
    verify(bioProperties).isTaggingQueryParam();
    verify(metaTagResourceAccess).isResourceWithTags(eq("ValidResource"));
    verify(metaTagResourceAccess).getUserTags(eq(requestDetails));
    verify(requestDetails).addParameter(eq("_security"), eq(new String[]{"tag1,tag2"}));
  }

  @Test
  void addTagParameter_GET_valid_resource_LDM() {
    final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.GET);
    when(requestDetails.getResourceName()).thenReturn("ValidResource");
    when(metaTagResourceAccess.isResourceWithTags(any(String.class))).thenReturn(true);
    when(metaTagResourceAccess.getUserTags(any())).thenReturn(List.of("tag1", "tag2", "LDM-X"));
    metaTagInterceptor.addTagParameter(requestDetails);
    verify(bioProperties).isTaggingEnabled();
    verify(bioProperties).isTaggingQueryParam();
    verify(metaTagResourceAccess).isResourceWithTags(eq("ValidResource"));
    verify(metaTagResourceAccess).getUserTags(eq(requestDetails));
    verify(requestDetails, never()).addParameter(any(), any());
  }

  @Test
  void addTagParameter_ignore_if_all_tags() {
    final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.GET);
    when(requestDetails.getResourceName()).thenReturn("ValidResource");
    when(metaTagResourceAccess.isResourceWithTags(any(String.class))).thenReturn(true);
    when(metaTagResourceAccess.getUserTags(any())).thenReturn(List.of(USER_ALL_TAGS));
    metaTagInterceptor.addTagParameter(requestDetails);
    verify(bioProperties).isTaggingEnabled();
    verify(bioProperties).isTaggingQueryParam();
    verify(metaTagResourceAccess).isResourceWithTags(eq("ValidResource"));
    verify(metaTagResourceAccess).getUserTags(eq(requestDetails));
    verify(requestDetails, never()).addParameter(any(), any());
  }

  @Test
  void addTagParameter_not_valid_request() {
    final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.DELETE);
    metaTagInterceptor.addTagParameter(requestDetails);
    verify(bioProperties).isTaggingEnabled();
    verify(bioProperties).isTaggingQueryParam();
    verify(requestDetails, never()).addParameter(any(), any());
  }

  @Test
  void addTagParameter_not_valid_resource() {
    final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.GET);
    when(requestDetails.getResourceName()).thenReturn("NotValidResource");
    when(metaTagResourceAccess.isResourceWithTags(any(String.class))).thenReturn(false);
    metaTagInterceptor.addTagParameter(requestDetails);
    verify(metaTagResourceAccess).isResourceWithTags(eq("NotValidResource"));
    verify(requestDetails, never()).addParameter(any(), any());
  }

  @Test
  void addTagParameter_tagging_disabled() {
    final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
    when(bioProperties.isTaggingEnabled()).thenReturn(false);
    metaTagInterceptor.addTagParameter(requestDetails);
    verify(bioProperties).isTaggingEnabled();
    verify(bioProperties, never()).isTaggingQueryParam();
  }
  
  @Test
  void addTagCode_POST_valid_resource() {
    final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
    final IBaseResource resource = Mockito.mock(IBaseResource.class);
    final IBaseMetaType meta = Mockito.mock(IBaseMetaType.class);
    final IBaseCoding tag = Mockito.mock(IBaseCoding.class);
    when(resource.getMeta()).thenReturn(meta);
    when(meta.addSecurity()).thenReturn(tag);
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.POST);
    when(metaTagResourceAccess.isResourceWithTags(any(IBaseResource.class))).thenReturn(true);
    when(metaTagResourceVisitor.extractEpCode(any(), any())).thenReturn("ep1");
    when(metaTagResourceVisitor.extractLdmCode(any(), any())).thenReturn("ldm1");
    when(metaTagResourceAccess.canModifyResource(any(), any())).thenReturn(true);
    metaTagInterceptor.created(requestDetails, resource);
    verify(metaTagResourceVisitor).extractEpCode(any(), eq(resource));
    verify(metaTagResourceVisitor).extractLdmCode(any(), eq(resource));
    verify(tag).setCode(eq("ep1"));
    verify(tag).setCode(eq("ldm1"));
  }

  @Test
  void addTagCode_PUT_valid_resource() {
    final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
    final IBaseResource resource = Mockito.mock(IBaseResource.class);
    final IBaseMetaType meta = Mockito.mock(IBaseMetaType.class);
    final IBaseCoding tag = Mockito.mock(IBaseCoding.class);
    when(resource.getMeta()).thenReturn(meta);
    when(meta.addSecurity()).thenReturn(tag);
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.PUT);
    when(metaTagResourceAccess.isResourceWithTags(any(IBaseResource.class))).thenReturn(true);
    when(metaTagResourceVisitor.extractEpCode(any(), any())).thenReturn("ep1");
    when(metaTagResourceVisitor.extractLdmCode(any(), any())).thenReturn("ldm1");
    when(metaTagResourceAccess.canModifyResource(any(), any())).thenReturn(true);
    metaTagInterceptor.updated(requestDetails, null, resource);
    verify(metaTagResourceVisitor).extractEpCode(any(), eq(resource));
    verify(metaTagResourceVisitor).extractLdmCode(any(), eq(resource));
    verify(tag).setCode(eq("ep1"));
    verify(tag).setCode(eq("ldm1"));
  }

  @Test
  void addTagCode_tagging_disabled() {
    final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
    final IBaseResource resource = Mockito.mock(IBaseResource.class);
    when(bioProperties.isTaggingEnabled()).thenReturn(false);
    metaTagInterceptor.created(requestDetails, resource);
    verify(bioProperties).isTaggingEnabled();
    verify(metaTagResourceAccess, never()).isResourceWithTags(eq(resource));
  }

  @Test
  void addTagCode_POST_not_same_organization() {
    final RequestDetails requestDetails = Mockito.mock(RequestDetails.class);
    final IBaseResource resource = Mockito.mock(IBaseResource.class);
    final IBaseMetaType meta = Mockito.mock(IBaseMetaType.class);
    final IBaseCoding tag = Mockito.mock(IBaseCoding.class);
    when(resource.getMeta()).thenReturn(meta);
    when(meta.addSecurity()).thenReturn(tag);
    when(requestDetails.getRequestType()).thenReturn(RequestTypeEnum.POST);
    when(metaTagResourceAccess.isResourceWithTags(any(IBaseResource.class))).thenReturn(true);
    when(metaTagResourceVisitor.extractEpCode(any(), any())).thenReturn("ep1");
    when(metaTagResourceVisitor.extractLdmCode(any(), any())).thenReturn("ldm1");
    when(metaTagResourceAccess.canModifyResource(any(), any())).thenReturn(false);

    Exception ex = Assertions.assertThrows(
        ForbiddenOperationException.class,
        () ->  metaTagInterceptor.created(requestDetails, resource)
    );
    assertEquals("Resource belongs to another organization", ex.getMessage());
    
    verify(metaTagResourceVisitor).extractEpCode(any(), eq(resource));
    verify(metaTagResourceVisitor).extractLdmCode(any(), eq(resource));
    verify(metaTagResourceAccess).canModifyResource(eq(requestDetails), eq(resource));


  }

}