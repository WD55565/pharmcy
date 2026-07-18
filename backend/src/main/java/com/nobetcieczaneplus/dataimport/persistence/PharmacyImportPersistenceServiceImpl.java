package com.nobetcieczaneplus.dataimport.persistence;

import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.nobetcieczaneplus.dataimport.dto.ImportOutcome;
import com.nobetcieczaneplus.dataimport.dto.ImportRecordResult;
import com.nobetcieczaneplus.dataimport.dto.ImportedPharmacyDto;
import com.nobetcieczaneplus.dataimport.mapper.PharmacyImportMapper;
import com.nobetcieczaneplus.entity.Pharmacy;
import com.nobetcieczaneplus.repository.PharmacyRepository;

/**
 * Each record is persisted in its own {@code REQUIRES_NEW} transaction so that a
 * failure on one record cannot roll back others already committed in the same
 * batch, and so a single bad row cannot abort the whole import.
 */
@Service
public class PharmacyImportPersistenceServiceImpl implements PharmacyImportPersistenceService {

    private static final Logger log = LoggerFactory.getLogger(PharmacyImportPersistenceServiceImpl.class);

    private final PharmacyRepository pharmacyRepository;
    private final PharmacyImportMapper pharmacyImportMapper;

    public PharmacyImportPersistenceServiceImpl(PharmacyRepository pharmacyRepository,
                                                  PharmacyImportMapper pharmacyImportMapper) {
        this.pharmacyRepository = pharmacyRepository;
        this.pharmacyImportMapper = pharmacyImportMapper;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public ImportRecordResult saveOrUpdate(ImportedPharmacyDto dto) {
        try {
            Optional<Pharmacy> existing =
                    pharmacyRepository.findBySourceAndExternalId(dto.getSource(), dto.getExternalId());

            if (existing.isPresent()) {
                return updateIfChanged(existing.get(), dto);
            }
            return create(dto);
        } catch (Exception ex) {
            log.error("Failed to persist pharmacy record [source={}, externalId={}]",
                    dto.getSource(), dto.getExternalId(), ex);
            return ImportRecordResult.of(dto.getExternalId(), ImportOutcome.FAILED, ex.getMessage());
        }
    }

    private ImportRecordResult create(ImportedPharmacyDto dto) {
        Pharmacy pharmacy = pharmacyImportMapper.toNewEntity(dto);
        pharmacyRepository.save(pharmacy);
        log.info("Created pharmacy [source={}, externalId={}, name={}]",
                dto.getSource(), dto.getExternalId(), dto.getName());
        return ImportRecordResult.of(dto.getExternalId(), ImportOutcome.CREATED, "Pharmacy created");
    }

    private ImportRecordResult updateIfChanged(Pharmacy existing, ImportedPharmacyDto dto) {
        boolean changed = pharmacyImportMapper.applyChanges(existing, dto);
        if (!changed) {
            log.debug("No changes for pharmacy [source={}, externalId={}]", dto.getSource(), dto.getExternalId());
            return ImportRecordResult.of(dto.getExternalId(), ImportOutcome.SKIPPED, "No changes detected");
        }

        pharmacyRepository.save(existing);
        log.info("Updated pharmacy [source={}, externalId={}, name={}]",
                dto.getSource(), dto.getExternalId(), dto.getName());
        return ImportRecordResult.of(dto.getExternalId(), ImportOutcome.UPDATED, "Pharmacy updated");
    }

}
