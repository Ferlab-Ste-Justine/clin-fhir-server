package bio.ferlab.clin.validation.validators;

import bio.ferlab.clin.validation.utils.ValidatorUtils;
import org.hl7.fhir.r4.model.HumanName;
import org.hl7.fhir.r4.model.Patient;
import org.hl7.fhir.r4.model.StringType;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class PatientValidator extends SchemaValidator<Patient> {
    public PatientValidator() {
        super(Patient.class);
    }

    @Override
    public boolean validateResource(Patient patient) {
        return validateNames(patient) && validateBirthDate(patient);
    }

    private boolean validateBirthDate(Patient patient) {
        return patient.hasBirthDate() && patient.getBirthDate().before(new Date());
    }

    private boolean validateNames(Patient patient) {
        final List<HumanName> names = patient.getName();

        if (names.size() == 0) {
            return false;
        }

        return names.stream().allMatch(this::validateName);
    }

    private boolean validateName(HumanName name) {
        final String family = name.getFamilyElement().getValue();
        final List<String> givens = name.getGiven().stream().map(StringType::getValue).collect(Collectors.toList());

        return isValidName(family) && givens.stream().allMatch(this::isValidName);
    }

    private boolean isValidName(String name) {
        return name.length() > 2 &&
                !ValidatorUtils.hasSpecialCharacters(name) &&
                ValidatorUtils.isTrimmed(name);
    }
}
