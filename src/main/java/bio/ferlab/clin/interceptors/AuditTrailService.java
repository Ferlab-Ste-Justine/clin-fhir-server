package bio.ferlab.clin.interceptors;

import ca.uhn.fhir.jpa.api.dao.IFhirResourceDao;
import org.hl7.fhir.r4.model.*;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.Date;
import java.util.List;

@Component
public class AuditTrailService {

    private final IFhirResourceDao<AuditEvent> auditEventDao;

    public AuditTrailService(IFhirResourceDao<AuditEvent> auditEventDao) {
        this.auditEventDao = auditEventDao;
    }

    public void auditResource(Bundle bundle) {
        if (bundle.getType().equals(Bundle.BundleType.TRANSACTION)) {
            final List<Bundle.BundleEntryComponent> entries = bundle.getEntry();
            entries.forEach(e -> {
                AuditEvent.AuditEventAction action = getActionFromBundleVerb(e.getRequest().getMethod());
                auditResource(e.getResource(), action);
            });
        }
    }

    private AuditEvent.AuditEventAction getActionFromBundleVerb(Bundle.HTTPVerb verb) {
        switch (verb) {
            case GET:
            case NULL:
            case HEAD:
                return AuditEvent.AuditEventAction.R;
            case POST:
                return AuditEvent.AuditEventAction.C;
            case PUT:
            case PATCH:
                return AuditEvent.AuditEventAction.U;
            case DELETE:
                return AuditEvent.AuditEventAction.D;

        }
        throw new IllegalStateException("HTTP Verb is unknown");
    }

    public void auditResource(Resource resource, AuditEvent.AuditEventAction action) {
        //We dont want log audit event read
        if (resource.getResourceType() != ResourceType.AuditEvent) {
            AuditEvent event = new AuditEvent();
            event.setRecorded(Date.from(Instant.now()));

            AuditEvent.AuditEventAgentComponent a = new AuditEvent.AuditEventAgentComponent();
            a.setName("Adam Careful");
            a.setWho(new Reference().setReference("Practitioner/1052"));
            event.addAgent(a);

            AuditEvent.AuditEventEntityComponent t = new AuditEvent.AuditEventEntityComponent();
            t.setWhatTarget(resource);
            t.setWhat(new Reference().setReference(resource.getId()));
            event.addEntity(t);
            event.setAction(action);
            auditEventDao.create(event);
        }
    }
}
