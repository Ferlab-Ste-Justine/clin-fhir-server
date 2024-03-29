package bio.ferlab.clin.validation;

import bio.ferlab.clin.properties.BioProperties;
import bio.ferlab.clin.validation.validators.nanuq.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ValidationConfiguration {
    
    @Autowired
    private BioProperties bioProperties;
    
    @Bean
    public ValidationChain validationChain() {
            return new ValidationChain()
                .withValidator(new PatientValidator())
                .withValidator(new PersonValidator())
                .withValidator(new RelatedPersonValidator())
                .withValidator(new ServiceRequestValidator())
                .withValidator(new ClinicalImpressionValidator())
                .withValidator(new ObservationValidator())
                .withValidator(new SpecimenValidator())
                .withValidator(new TaskValidator());
    }
}
