package bio.ferlab.clin.validation.validators;

import bio.ferlab.clin.validation.utils.ValidatorUtils;
import org.apache.commons.lang3.EnumUtils;
import org.hl7.fhir.r4.model.Annotation;
import org.hl7.fhir.r4.model.CodeableConcept;
import org.hl7.fhir.r4.model.Coding;
import org.hl7.fhir.r4.model.Observation;

public class ObservationValidator extends SchemaValidator<Observation> {
    private enum SupportedCodesEnum {
        CGH,
        INDIC,
        PHENO,
        INVES
    }

    private enum CghInterpretationEnum {
        A,
        N,
        IND
    }

    public ObservationValidator() {
        super(Observation.class);
    }

    @Override
    public boolean validateResource(Observation resource) {
        final String resourceCode = getCode(resource);
        final SupportedCodesEnum code = EnumUtils.getEnum(SupportedCodesEnum.class, resourceCode);
        if (resourceCode == null || code == null) {
            return false;
        }
        switch (code) {
            case CGH:
                return validateCgh(resource);
            case INDIC:
                return validateIndications(resource);
            case PHENO:
                return validatePhenotype(resource);
            case INVES:
                return validateInvestigations(resource);
            default:
                return false;
        }
    }

    private boolean validateCgh(Observation resource) {
        // Make sure the CGH Observation has only one interpretation
        if (resource.getInterpretation().size() != 1) {
            return false;
        }

        // Make sure the interpretation has only one coding
        final CodeableConcept interpretation = resource.getInterpretation().get(0);
        if (interpretation.isEmpty() || interpretation.getCoding().size() != 1) {
            return false;
        }

        final String code = interpretation.getCoding().get(0).getCode();

        // Make sur the CGH interpretation is supported
        if (!EnumUtils.isValidEnum(CghInterpretationEnum.class, code)) {
            return false;
        }

        // Make sure there is a note if the interpretation is abnormal
        if (code.contentEquals(CghInterpretationEnum.A.name()) && !resource.hasNote()) {
            return false;
        }

        // Make sure the note is valid if present
        return validateNote(resource);
    }

    private boolean validateNote(Observation resource) {
        if (resource.hasNote()) {
            final Annotation note = resource.getNote().get(0);
            return !note.isEmpty() &&
                    note.getText() != null &&
                    ValidatorUtils.isTrimmed(note.getText());
        }

        return true;
    }


    private boolean validateIndications(Observation resource) {
        return validateNote(resource);
    }

    private boolean validatePhenotype(Observation resource) {
        return validateNote(resource);
    }

    private boolean validateInvestigations(Observation resource) {
        return validateNote(resource);
    }

    private String getCode(Observation resource) {
        final CodeableConcept code = resource.getCode();
        if (code.isEmpty() || code.getCoding().isEmpty()) {
            return null;
        }
        final Coding coding = code.getCoding().get(0);
        return coding.getCode();
    }
}