package com.nobetcieczaneplus.dataimport.validator;

import java.util.List;

import lombok.Getter;

/**
 * Outcome of validating a single {@link com.nobetcieczaneplus.dataimport.dto.ImportedPharmacyDto}.
 */
@Getter
public class ValidationResult {

    private final boolean valid;
    private final List<String> errors;

    private ValidationResult(boolean valid, List<String> errors) {
        this.valid = valid;
        this.errors = errors;
    }

    public static ValidationResult valid() {
        return new ValidationResult(true, List.of());
    }

    public static ValidationResult invalid(List<String> errors) {
        return new ValidationResult(false, errors);
    }

}
