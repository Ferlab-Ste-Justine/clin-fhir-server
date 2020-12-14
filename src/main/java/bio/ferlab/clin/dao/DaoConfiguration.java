package bio.ferlab.clin.dao;

import ca.uhn.fhir.jpa.api.dao.DaoRegistry;
import ca.uhn.fhir.jpa.api.dao.IFhirResourceDao;
import org.hl7.fhir.r4.model.AuditEvent;
import org.hl7.fhir.r4.model.Organization;
import org.hl7.fhir.r4.model.Practitioner;
import org.hl7.fhir.r4.model.ServiceRequest;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DaoConfiguration {
    public IFhirResourceDao<ServiceRequest> serviceRequestDao(DaoRegistry daoRegistry) {
        return daoRegistry.getResourceDao(ServiceRequest.class);
    }

    public IFhirResourceDao<Organization> organizationDao(DaoRegistry daoRegistry) {
        return daoRegistry.getResourceDao(Organization.class);
    }

    public IFhirResourceDao<Practitioner> practitionerDao(DaoRegistry daoRegistry) {
        return daoRegistry.getResourceDao(Practitioner.class);
    }

    public IFhirResourceDao<AuditEvent> auditEventDao(DaoRegistry daoRegistry) {
        return daoRegistry.getResourceDao(AuditEvent.class);
    }
}
