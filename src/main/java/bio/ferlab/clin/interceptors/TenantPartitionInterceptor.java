package bio.ferlab.clin.interceptors;

import bio.ferlab.clin.auth.RPTPermissionExtractor;
import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import ca.uhn.fhir.interceptor.model.RequestPartitionId;
import ca.uhn.fhir.jpa.dao.data.IPartitionDao;
import ca.uhn.fhir.jpa.entity.PartitionEntity;
import ca.uhn.fhir.jpa.partition.SystemRequestDetails;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.exceptions.InvalidRequestException;
import ca.uhn.fhir.rest.server.exceptions.NotImplementedOperationException;
import ca.uhn.fhir.rest.server.servlet.ServletRequestDetails;
import ca.uhn.fhir.rest.server.tenant.ITenantIdentificationStrategy;
import ca.uhn.fhir.util.UrlPathTokenizer;
import org.apache.commons.lang3.StringUtils;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.Organization;
import org.hl7.fhir.r4.model.ServiceRequest;
import org.hl7.fhir.r4.model.StringType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Interceptor
public class TenantPartitionInterceptor implements ITenantIdentificationStrategy {
  
  // list of all partitioned resources, if you add one here don't forget to add the
  // extractPartitionIdFromResource implementation how to extract the partition id
  public final static List<String> PARTITIONED_RESOURCES = List.of("ServiceRequest", "Organization");

  // every internal DOA can use this SystemRequestDetails when performing queries it will
  // allow to query every partitions
  public final static SystemRequestDetails systemRequestDetails = new SystemRequestDetails();
  static {
    systemRequestDetails.setRequestPartitionId(RequestPartitionId.allPartitions());
  }

  private final Logger log = LoggerFactory.getLogger(TenantPartitionInterceptor.class);
  
  private final RPTPermissionExtractor rptPermissionExtractor;
  private final IPartitionDao partitionDao;
  
  public TenantPartitionInterceptor(RPTPermissionExtractor rptPermissionExtractor, IPartitionDao partitionDao) {
    this.rptPermissionExtractor = rptPermissionExtractor;
    this.partitionDao = partitionDao;
  }

  @Hook(Pointcut.STORAGE_PARTITION_IDENTIFY_CREATE)
  public RequestPartitionId partitionIdentifyCreate(IBaseResource theResource, ServletRequestDetails theRequestDetails) {
    // extract the partition name from the created resource
    final RequestPartitionId partition = extractPartitionIdFromResource(theResource);
    this.createPartitionIfNeeded(partition);  // it's required + we don't want to do it manually
    return partition;
  }
  
  @Hook(Pointcut.STORAGE_PARTITION_IDENTIFY_READ)
  public RequestPartitionId partitionIdentifyRead(ServletRequestDetails theRequestDetails) {
    // extract partition id from token if resource is partitioned
    if(PARTITIONED_RESOURCES.contains(theRequestDetails.getResourceName())) {
      return RequestPartitionId.fromPartitionName(theRequestDetails.getTenantId());
    } else {
      return RequestPartitionId.defaultPartition(); // if not partitioned then default
    }
  }

  @Override
  public void extractTenant(UrlPathTokenizer urlPathTokenizer, RequestDetails requestDetails) {
    final String tenantId = rptPermissionExtractor.getFhirOrganizationId(requestDetails);
    requestDetails.setTenantId(tenantId);
  }

  @Override
  public String massageServerBaseUrl(String theFhirServerBase, RequestDetails requestDetails) {
    return theFhirServerBase; // + "/" + requestDetails.getTenantId();
  }
  
  private void createPartitionIfNeeded(RequestPartitionId partitionId) {
    partitionId.getPartitionNames().forEach(name -> {
      if(partitionDao.findForName(name).isEmpty()) {
        log.info("Create new partition named: {}", name);
        PartitionEntity partitionEntity = new PartitionEntity();
        partitionEntity.setId(name.hashCode()); // ID isn't auto-generated
        partitionEntity.setName(name);
        partitionDao.save(partitionEntity);
      }
    });
    partitionDao.flush();
  }

  private RequestPartitionId extractPartitionIdFromResource(IBaseResource theResource) {
    String partition = null;
    final String resourceName = theResource.getClass().getSimpleName();
    if(PARTITIONED_RESOURCES.contains(resourceName)) {
      if(theResource instanceof ServiceRequest) {
        final var res = (ServiceRequest) theResource;
        final var id = res.getIdentifier().stream()
            .filter(i -> i.getType().getCoding().stream().anyMatch(c -> "MR".equals(c.getCode())))
            .findFirst();
        partition = id.map(p -> p.getAssigner().getReference().split("/")[1]).orElseThrow(() ->
            new InvalidRequestException("Identifier of type MR with assigner organization is required"));
      } else if(theResource instanceof Organization) {
        final var res = (Organization) theResource;
        partition = res.getAlias().stream().filter(StringType::hasValue).map(StringType::getValue).findFirst().orElseThrow(() ->
            new InvalidRequestException("At least one alias is required"));
      }
      
      if(StringUtils.isBlank(partition)) {
        throw new NotImplementedOperationException(String.format("Missing implementation for partitionId of %s", resourceName));
      }
    }
    RequestPartitionId partitionId = partition != null ? RequestPartitionId.fromPartitionName(partition): RequestPartitionId.defaultPartition();
    log.debug("{} => {}", theResource.getClass().getSimpleName(), partitionId.getPartitionNames());
    return partitionId;
  }
}
