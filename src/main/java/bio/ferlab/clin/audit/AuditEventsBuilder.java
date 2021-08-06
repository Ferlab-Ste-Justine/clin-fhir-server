package bio.ferlab.clin.audit;

import bio.ferlab.clin.user.RequesterData;
import lombok.Data;
import org.hl7.fhir.r4.model.*;
import org.hl7.fhir.r4.model.AuditEvent.AuditEventAction;
import org.hl7.fhir.r4.model.AuditEvent.AuditEventAgentComponent;

import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class AuditEventsBuilder {
    public static final String UNKNOWN_HTTP_VERB = "Unknown http verb";
    private final List<AuditResource> resources = new ArrayList<>();
    private final RequesterData requesterData;

    public AuditEventsBuilder(RequesterData requesterData) {
        this.requesterData = requesterData;
    }

    private AuditEventAction getActionFromBundleVerb(Bundle.HTTPVerb verb) {
        switch (verb) {
            case GET:
            case NULL:
            case HEAD:
                return AuditEventAction.R;
            case POST:
                return AuditEventAction.C;
            case PUT:
            case PATCH:
                return AuditEventAction.U;
            case DELETE:
                return AuditEventAction.D;

        }
        throw new IllegalStateException(UNKNOWN_HTTP_VERB);
    }

    public AuditEventsBuilder addBundle(Bundle bundle) {
        bundle.getEntry().forEach(entry -> {
            final AuditEventAction action = this.getActionFromBundleVerb(entry.getRequest().getMethod());
            if (action == AuditEventAction.R) {
                final String url = entry.getRequest().getUrl();
                final int endIndex = !url.contains("?") ? url.indexOf("/") : url.indexOf("?");
                final String resourceType = endIndex > 0 ? url.substring(0, endIndex) : "";
                this.resources.add(AuditResource.fromReadAction(entry.getRequest().getUrl(), resourceType));
            } else {
                this.resources.add(new AuditResource(entry.getResource(), action));
            }
        });
        return this;
    }

    public AuditEventsBuilder addResource(Resource resource, AuditEventAction action) {
        if (action == AuditEventAction.R) {
            this.resources.add(AuditResource.fromReadAction(resource.getId(), resource.fhirType()));
        } else {
            this.resources.add(new AuditResource(resource, action));
        }

        return this;
    }

    public AuditEventsBuilder addReadAction(String resource) {
        this.resources.add(AuditResource.fromReadAllAction(resource));
        return this;
    }

    private AuditEvent generateAuditEvent(AuditResource auditResource) {
        final AuditEvent event = new AuditEvent();
        event.setRecorded(Date.from(Instant.now()));

        final AuditEventAgentComponent agent = new AuditEventAgentComponent();

        if (requesterData.getName() != null) {
            agent.setName(requesterData.getName());
        } else {
            agent.setName(requesterData.getUsername());
        }

        if (requesterData.getPractitionerId() != null) {
            agent.setWho(new Reference().setReference(String.format("Practitioner/%s", requesterData.getPractitionerId())));
        }
        event.addAgent(agent);

        final AuditEvent.AuditEventEntityComponent target = new AuditEvent.AuditEventEntityComponent();

        target.setType(auditResource.getType());
        if (!auditResource.isReadAll() && auditResource.getResource() != null) {
            target.setWhat(auditResource.getReference());
        }

        if (auditResource.getQuery() != null) {
            target.setQuery(auditResource.getQuery());
        }

        event.addEntity(target);
        event.setAction(auditResource.getAction());

        return event;
    }

    public List<AuditEvent> build() {
        return this.resources.stream().map(this::generateAuditEvent).collect(Collectors.toList());
    }

    @Data
    static class AuditResource {
        public static final String AUDIT_ENTITY_TYPE_SYSTEM = "https://www.hl7.org/fhir/valueset-audit-entity-type.html";
        private final Resource resource;
        private final AuditEventAction action;
        private Reference reference;
        private Coding type;
        private byte[] query;

        public AuditResource(Resource resource, AuditEventAction action) {
            this.resource = resource;
            this.action = action;
            if (resource != null) {
                this.reference = new Reference().setReference(resource.getId());
                this.type = createTypeCoding().setCode(resource.getResourceType().toString());
            }
        }

        public static AuditResource fromReadAction(String url, String type) {
            final AuditResource auditResource = new AuditResource(null, AuditEventAction.R);
            if (url != null) {
                auditResource.setQuery(url.getBytes(StandardCharsets.UTF_8));
            }
            auditResource.setType(createTypeCoding().setCode(type));
            return auditResource;
        }


        public static AuditResource fromReadAllAction(String type) {
            final AuditResource auditResource = new AuditResource(null, AuditEventAction.R);
            auditResource.setType(createTypeCoding().setCode(type));
            return auditResource;
        }

        private static Coding createTypeCoding() {
            return new Coding().setSystem(AUDIT_ENTITY_TYPE_SYSTEM);
        }

        public boolean isReadAll() {
            return this.action == AuditEventAction.R && this.reference == null;
        }
    }
}
