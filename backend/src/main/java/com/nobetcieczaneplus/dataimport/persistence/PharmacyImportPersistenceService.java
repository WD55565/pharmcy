package com.nobetcieczaneplus.dataimport.persistence;

import com.nobetcieczaneplus.dataimport.dto.ImportRecordResult;
import com.nobetcieczaneplus.dataimport.dto.ImportedPharmacyDto;

/**
 * Persists a single validated imported pharmacy record: creates it if unseen,
 * updates it if it already exists and changed, or reports no-op if it is
 * an unchanged duplicate.
 */
public interface PharmacyImportPersistenceService {

    ImportRecordResult saveOrUpdate(ImportedPharmacyDto dto);

}
