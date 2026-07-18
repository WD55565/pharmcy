package com.nobetcieczaneplus.dataimport.validator;

import java.util.List;
import java.util.Set;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;

import org.springframework.stereotype.Component;

import com.nobetcieczaneplus.dataimport.dto.ImportedPharmacyDto;

/**
 * Bean-validation-backed {@link PharmacyDataValidator}. Reuses the same
 * {@code jakarta.validation} constraints declared on {@link ImportedPharmacyDto}
 * so validation rules live in one place.
 */
@Component
public class PharmacyDataValidatorImpl implements PharmacyDataValidator {

    private final Validator beanValidator;

    public PharmacyDataValidatorImpl(Validator beanValidator) {
        this.beanValidator = beanValidator;
    }

    @Override
    public ValidationResult validate(ImportedPharmacyDto dto) {
        Set<ConstraintViolation<ImportedPharmacyDto>> violations = beanValidator.validate(dto);
        if (violations.isEmpty()) {
            return ValidationResult.valid();
        }

        List<String> errors = violations.stream()
                .map(violation -> violation.getPropertyPath() + ": " + violation.getMessage())
                .toList();
        return ValidationResult.invalid(errors);
    }

}
