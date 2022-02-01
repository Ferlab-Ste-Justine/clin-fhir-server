package bio.ferlab.clin.audit;


import ca.uhn.fhir.interceptor.model.RequestPartitionId;
import ca.uhn.fhir.jpa.api.dao.IFhirResourceDao;
import ca.uhn.fhir.jpa.partition.SystemRequestDetails;
import org.hl7.fhir.r4.model.AuditEvent;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class AuditTrail {
    private final IFhirResourceDao<AuditEvent> auditEventDao;

    public AuditTrail(IFhirResourceDao<AuditEvent> auditEventDao) {
        this.auditEventDao = auditEventDao;
    }

    public void auditEvents(List<AuditEvent> events, boolean successful) {
        events.forEach(event -> this.auditEvent(event, successful));
    }

    public void auditEvent(AuditEvent event, boolean successful) {
        event.setOutcome(successful ? AuditEvent.AuditEventOutcome._0 : AuditEvent.AuditEventOutcome._4);
        SystemRequestDetails req = new SystemRequestDetails();
        req.setRequestPartitionId(RequestPartitionId.defaultPartition());
        this.auditEventDao.create(event, req);
    }
}
