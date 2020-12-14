package bio.ferlab.clin.interceptors;

import ca.uhn.fhir.rest.api.RestOperationTypeEnum;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.exceptions.BaseServerResponseException;
import ca.uhn.fhir.rest.server.interceptor.consent.ConsentOutcome;
import ca.uhn.fhir.rest.server.interceptor.consent.IConsentContextServices;
import ca.uhn.fhir.rest.server.interceptor.consent.IConsentService;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.AuditEvent;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Resource;
import org.springframework.context.ApplicationContext;

public class ConsentInterceptorService implements IConsentService {

    private final AuditTrailService service;

    public ConsentInterceptorService(ApplicationContext appContext) {
        this.service = appContext.getBean(AuditTrailService.class);
    }
    @Override
    public ConsentOutcome startOperation(RequestDetails theRequestDetails, IConsentContextServices theContextServices) {
        return ConsentOutcome.PROCEED;
    }

    @Override
    public ConsentOutcome canSeeResource(RequestDetails theRequestDetails, IBaseResource theResource, IConsentContextServices theContextServices) {
        return ConsentOutcome.PROCEED;
    }

    @Override
    public ConsentOutcome willSeeResource(RequestDetails theRequestDetails, IBaseResource theResource, IConsentContextServices theContextServices) {
        return ConsentOutcome.AUTHORIZED;
    }

    @Override
    public void completeOperationSuccess(RequestDetails theRequestDetails, IConsentContextServices theContextServices) {
        IBaseResource resource = theRequestDetails.getResource();
        if (resource instanceof Bundle) {
            service.auditResource((Bundle) resource);
        }else if (resource instanceof Resource)  {
            service.auditResource((Resource) resource, getActionFromRestOperationType(theRequestDetails.getRestOperationType()));
        }
        System.out.println(theRequestDetails);
    }

    private AuditEvent.AuditEventAction getActionFromRestOperationType(RestOperationTypeEnum type) {
       switch (type){
           case ADD_TAGS:
           case PATCH:
           case META_DELETE:
           case META:
           case META_ADD:
           case UPDATE:
           case TRANSACTION:
           case EXTENDED_OPERATION_INSTANCE:
           case EXTENDED_OPERATION_SERVER:
           case DELETE_TAGS:
               return AuditEvent.AuditEventAction.U;
           case GET_TAGS:
           case METADATA:
           case VREAD:
           case VALIDATE:
           case SEARCH_TYPE:
           case SEARCH_SYSTEM:
           case READ:
           case HISTORY_TYPE:
           case HISTORY_SYSTEM:
           case HISTORY_INSTANCE:
           case GRAPHQL_REQUEST:
           case GET_PAGE:
           case EXTENDED_OPERATION_TYPE:
               return AuditEvent.AuditEventAction.R;
           case CREATE:
               return AuditEvent.AuditEventAction.C;
           case DELETE:
               return AuditEvent.AuditEventAction.D;
       }
       throw new IllegalStateException("Invalid rest operation type");
    }

    @Override
    public void completeOperationFailure(RequestDetails theRequestDetails, BaseServerResponseException theException, IConsentContextServices theContextServices) {

    }
}
