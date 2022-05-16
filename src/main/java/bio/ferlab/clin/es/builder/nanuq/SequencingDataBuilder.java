package bio.ferlab.clin.es.builder.nanuq;

import bio.ferlab.clin.es.config.ResourceDaoConfiguration;
import bio.ferlab.clin.es.data.nanuq.SequencingData;
import ca.uhn.fhir.rest.api.server.RequestDetails;
import org.hl7.fhir.r4.model.IdType;
import org.hl7.fhir.r4.model.Reference;
import org.hl7.fhir.r4.model.ServiceRequest;
import org.hl7.fhir.r4.model.Specimen;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Component
public class SequencingDataBuilder extends AbstractPrescriptionDataBuilder {

  private final ResourceDaoConfiguration configuration;

  public SequencingDataBuilder(ResourceDaoConfiguration configuration) {
    super(Type.SEQUENCING, configuration);
    this.configuration = configuration;
  }

  public List<SequencingData> fromIds(Set<String> ids, RequestDetails requestDetails) {
    final List<SequencingData> sequencings = new ArrayList<>();
    for (final String serviceRequestId : ids) {
      final SequencingData sequencingData = new SequencingData();
      final ServiceRequest serviceRequest = this.configuration.serviceRequestDAO.read(new IdType(serviceRequestId), requestDetails);
      if (this.isValidType(serviceRequest)) {

        this.handlePrescription(serviceRequest, sequencingData);
        
        if(serviceRequest.hasBasedOn()) {
          sequencingData.setPrescriptionId(serviceRequest.getBasedOn().get(0).getReferenceElement().getIdPart());
        }
        
        if(serviceRequest.hasSpecimen()) {
          for(Reference specimenRef: serviceRequest.getSpecimen()) {
            final Specimen specimen = this.configuration.specimenDao.read(new IdType(specimenRef.getReference()), requestDetails);
            if(specimen.hasParent()) {
              sequencingData.setSample(specimenRef.getDisplay());
            }
          }
        }

        sequencings.add(sequencingData);
      }
    }
    return sequencings;
  }

}
