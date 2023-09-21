package bio.ferlab.clin.interceptors;

import ca.uhn.fhir.interceptor.api.Hook;
import ca.uhn.fhir.interceptor.api.Interceptor;
import ca.uhn.fhir.interceptor.api.Pointcut;
import ca.uhn.fhir.rest.api.server.IPreResourceAccessDetails;
import ca.uhn.fhir.rest.api.server.IPreResourceShowDetails;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.servlet.ServletRequestDetails;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.springframework.stereotype.Component;

import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Component
@Interceptor
public class SameRequestInterceptor {

  private final Map<String, List<IBaseResource>> requests = new ConcurrentHashMap<>();

  @Hook(Pointcut.STORAGE_PREACCESS_RESOURCES)
  public void concatResources(IPreResourceAccessDetails preResourceShowDetails, RequestDetails requestDetails) {
    List<IBaseResource> resources = new ArrayList<>();
    for (int i=0; i<preResourceShowDetails.size(); i++) {
      resources.add(preResourceShowDetails.getResource(i));
    }
    final var requestId = getRequestId(requestDetails);
    requests.computeIfAbsent(requestId, rd -> new ArrayList<>());
    requests.get(requestId).addAll(resources);
  }
  
  @Hook(Pointcut.SERVER_PROCESSING_COMPLETED)
  public void remove(RequestDetails requestDetails) {
    requests.remove(getRequestId(requestDetails));
  }

  /**
   * Return list of immutable resources associated to a RequestDetails.
   * 
   * @param requestDetails current RequestDetails
   * @return immutable resources of the RequestDetails
   */
  public List<IBaseResource> get(RequestDetails requestDetails) {
    return requests.get(getRequestId(requestDetails));
  }

  private String getRequestId(RequestDetails requestDetails) {
    // batch requests share the same root HttpServletRequest, that one is valid as ID, otherwise every batch entries are considered as a request
    return ((ServletRequestDetails) requestDetails).getServletRequest().toString();
  }
}
