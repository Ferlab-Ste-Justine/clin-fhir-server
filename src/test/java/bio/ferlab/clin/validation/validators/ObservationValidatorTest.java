package bio.ferlab.clin.validation.validators;

import bio.ferlab.clin.utils.Extensions;
import org.hl7.fhir.r4.model.Annotation;
import org.hl7.fhir.r4.model.CodeableConcept;
import org.hl7.fhir.r4.model.Coding;
import org.hl7.fhir.r4.model.Observation;
import org.junit.jupiter.api.*;

import java.util.Arrays;
import java.util.Collections;

public class ObservationValidatorTest {
    private final ObservationValidator observationValidator = new ObservationValidator();
    private final Observation observation = new Observation();


    private CodeableConcept createInterpretation(String code) {
        final CodeableConcept interpretation = new CodeableConcept();
        interpretation.addCoding().setCode(code);
        return interpretation;
    }

    @Nested
    @DisplayName("Valid")
    class Valid {
        @Nested
        @DisplayName("Phenotype Observation")
        class HPO {
            @BeforeEach
            void setup() {
                final CodeableConcept code = new CodeableConcept();
                code.addCoding()
                        .setSystem("http://fhir.cqgc.ferlab.bio/CodeSystem/observation-code")
                        .setCode("PHENO")
                        .setDisplay("phenotype");
                observation.setCode(code);
            }

            @Test
            @DisplayName("With interpretation and age at onset")
            void withInterpretationAndAgeAtOnset() {
                observation.setInterpretation(Collections.singletonList(createInterpretation("NEG")));
                observation.addExtension(Extensions.AGE_AT_ONSET, new Coding().setCode("HP:0011462"));
                Assertions.assertTrue(observationValidator.validateResource(observation));
            }
        }
    }

    @Nested
    @DisplayName("With Invalid")
    class Invalid {
        @Nested
        @DisplayName("Observation Note")
        class Note {
            @Nested
            @DisplayName("When not trimmed")
            class NotTrimmed {
                @Test
                @DisplayName("Should return false")
                void returnFalse() {
                    observation.setInterpretation(Collections.singletonList(createInterpretation("IND")));
                    final Annotation annotation = observation.addNote();
                    annotation.setText(" ");
                    Assertions.assertFalse(observationValidator.validateResource(observation));
                    annotation.setText(" note");
                    Assertions.assertFalse(observationValidator.validateResource(observation));
                    annotation.setText("note ");
                    Assertions.assertFalse(observationValidator.validateResource(observation));
                    annotation.setText(" note ");
                    Assertions.assertFalse(observationValidator.validateResource(observation));
                }
            }
        }

        @Nested
        @DisplayName("CGH Observation")
        class CGH {
            @BeforeEach
            void setup() {
                final CodeableConcept code = new CodeableConcept();
                code.addCoding().setCode("CGH");
                observation.setCode(code);
            }

            @Nested
            @DisplayName("When abnormal interpretation")
            class Abnormal {
                @Nested
                @DisplayName("With malformed precision")
                class MalformedPrecision {
                    @Test
                    @DisplayName("Should return false")
                    void withoutPrecision() {
                        observation.setInterpretation(Collections.singletonList(createInterpretation("A")));
                        observation.addNote().setText("  Note");
                        Assertions.assertFalse(observationValidator.validateResource(observation));
                    }
                }
            }
        }

        @Nested
        @DisplayName("Phenotype Observation")
        class HPO {
            @BeforeEach
            void setup() {
                final CodeableConcept code = new CodeableConcept();
                code.addCoding()
                        .setSystem("http://fhir.cqgc.ferlab.bio/CodeSystem/observation-code")
                        .setCode("PHENO")
                        .setDisplay("phenotype");
                observation.setCode(code);
            }

            @Test
            @DisplayName("With multiple interpretations")
            void withMultipleInterpretations() {
                observation.setInterpretation(Arrays.asList(createInterpretation("POS"), createInterpretation("NEG")));
                observation.addExtension(Extensions.AGE_AT_ONSET, new Coding().setCode("HP:0011462"));
                Assertions.assertFalse(observationValidator.validateResource(observation));
            }

            @Test
            @DisplayName("With multiple interpretation codings")
            void withMultipleInterpretationCodings() {
                observation.setInterpretation(Collections.singletonList(createInterpretation("POS").addCoding(new Coding().setCode("NEG"))));
                observation.addExtension(Extensions.AGE_AT_ONSET, new Coding().setCode("HP:0011462"));
                Assertions.assertFalse(observationValidator.validateResource(observation));
            }

            @Test
            @DisplayName("With no interpretation")
            void withNoInterpretation() {
                observation.addExtension(Extensions.AGE_AT_ONSET, new Coding().setCode("HP:0011462"));
                Assertions.assertFalse(observationValidator.validateResource(observation));
            }

            @Test
            @DisplayName("With invalid interpretation")
            void withInvalidInterpretation() {
                observation.setInterpretation(Collections.singletonList(createInterpretation("INVALID")));
                observation.addExtension(Extensions.AGE_AT_ONSET, new Coding().setCode("HP:0011462"));
                Assertions.assertFalse(observationValidator.validateResource(observation));
            }

            @Test
            @DisplayName("With invalid age at onset")
            void withInvalidAgeAtOnset() {
                observation.setInterpretation(Collections.singletonList(createInterpretation("POS")));
                observation.addExtension(Extensions.AGE_AT_ONSET, new Coding().setCode("1234"));
                Assertions.assertFalse(observationValidator.validateResource(observation));
            }
        }
    }
}
