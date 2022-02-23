package bio.ferlab.clin.validation.validators;

import bio.ferlab.clin.utils.Extensions;
import bio.ferlab.clin.validation.utils.ValidatorUtils;
import org.apache.commons.lang3.EnumUtils;
import org.hl7.fhir.r4.model.*;

public class ObservationValidator extends SchemaValidator<Observation> {
    private static final String AGE_AT_ONSET_PREFIX_VALUE = "HP:";
    public static final String ETHNICITY_SYSTEM = "http://fhir.cqgc.ferlab.bio/CodeSystem/qc-ethnicity";

    private enum SupportedCodesEnum {
        CGH,
        INDIC,
        PHENO,
        INVES,
        ETH,
        CONS,
    }

    private enum PhenotypeInterpretationEnum {
        NEG,
        POS,
        IND,
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
            case ETH:
                return validateEthnicity(resource);
            case CONS:
                return validateConsumption(resource);
            default:
                return false;
        }
    }

    private boolean validateCgh(Observation resource) {
        // Make sure the note is valid if present
        return validateNote(resource);
    }

    private boolean validateIndications(Observation resource) {
        return validateNote(resource);
    }

    private boolean validatePhenotype(Observation resource) {
        final boolean validInterpretation = resource.hasInterpretation() &&
                resource.getInterpretation().size() == 1 &&
                isValidPhenotypeInterpretation(resource.getInterpretation().get(0));

        return validInterpretation && hasValidAgAtOnset(resource) && validateNote(resource);
    }

    private boolean hasValidAgAtOnset(Observation observation) {
        if (!observation.hasExtension(Extensions.AGE_AT_ONSET)) {
            return true;
        }
        final Coding coding = (Coding) observation.getExtensionByUrl(Extensions.AGE_AT_ONSET).getValue();
        return coding.getCode().startsWith(AGE_AT_ONSET_PREFIX_VALUE);
    }

    private boolean isValidPhenotypeInterpretation(CodeableConcept interpretation) {
        if (interpretation.isEmpty() || interpretation.getCoding().size() != 1) {
            return false;
        }

        return EnumUtils.isValidEnum(PhenotypeInterpretationEnum.class, interpretation.getCoding().get(0).getCode());
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

    private boolean validateInvestigations(Observation resource) {
        return validateNote(resource);
    }

    private boolean validateEthnicity(Observation resource) {
        try{
            final CodeableConcept concept = (CodeableConcept) resource.getValue();
            return !concept.getCoding().isEmpty() && concept.getCoding().get(0).getSystem().contentEquals(ETHNICITY_SYSTEM);
        }catch(Exception e){
            return false;
        }
    }

    private boolean validateConsumption(Observation resource) {
        try{
            final BooleanType concept = (BooleanType) resource.getValue();
            return true;
        }catch(Exception e){
            return false;
        }
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
