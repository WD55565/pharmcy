package com.nobetcieczaneplus.dataimport.mapper;

import com.nobetcieczaneplus.dataimport.dto.ImportedPharmacyDto;
import com.nobetcieczaneplus.entity.Pharmacy;

/**
 * Translates between {@link ImportedPharmacyDto} and the {@link Pharmacy} entity.
 */
public interface PharmacyImportMapper {

    /**
     * Builds a brand-new, unpersisted {@link Pharmacy} from an imported record.
     */
    Pharmacy toNewEntity(ImportedPharmacyDto dto);

    /**
     * Copies the imported record's fields onto an existing pharmacy.
     *
     * @return {@code true} if any field actually changed, {@code false} if the
     *         existing row already matches the imported data
     */
    boolean applyChanges(Pharmacy existing, ImportedPharmacyDto dto);

}
