package com.nobetcieczaneplus.dataimport.validator;

import com.nobetcieczaneplus.dataimport.dto.ImportedPharmacyDto;

/**
 * Validates a single imported pharmacy record before it is mapped and persisted.
 * Kept independent of any particular data source so the same rules apply
 * regardless of which {@link com.nobetcieczaneplus.dataimport.provider.PharmacyDataProvider}
 * produced the record.
 */
public interface PharmacyDataValidator {

    ValidationResult validate(ImportedPharmacyDto dto);

}
