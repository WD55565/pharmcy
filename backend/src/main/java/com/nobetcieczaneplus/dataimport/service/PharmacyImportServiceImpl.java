package com.nobetcieczaneplus.dataimport.service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.nobetcieczaneplus.dataimport.dto.ImportOutcome;
import com.nobetcieczaneplus.dataimport.dto.ImportRecordResult;
import com.nobetcieczaneplus.dataimport.dto.ImportSummary;
import com.nobetcieczaneplus.dataimport.dto.ImportedPharmacyDto;
import com.nobetcieczaneplus.dataimport.parser.DataParsingException;
import com.nobetcieczaneplus.dataimport.parser.PharmacyDataParser;
import com.nobetcieczaneplus.dataimport.persistence.PharmacyImportPersistenceService;
import com.nobetcieczaneplus.dataimport.provider.DataProviderException;
import com.nobetcieczaneplus.dataimport.provider.PharmacyDataProvider;
import com.nobetcieczaneplus.dataimport.validator.PharmacyDataValidator;
import com.nobetcieczaneplus.dataimport.validator.ValidationResult;

/**
 * Default {@link PharmacyImportService}. Each record is validated then handed to
 * the persistence layer independently, so one bad or duplicate record does not
 * stop the rest of the batch from being imported.
 */
@Service
public class PharmacyImportServiceImpl implements PharmacyImportService {

    private static final Logger log = LoggerFactory.getLogger(PharmacyImportServiceImpl.class);

    private final PharmacyDataValidator pharmacyDataValidator;
    private final PharmacyImportPersistenceService pharmacyImportPersistenceService;

    public PharmacyImportServiceImpl(PharmacyDataValidator pharmacyDataValidator,
                                      PharmacyImportPersistenceService pharmacyImportPersistenceService) {
        this.pharmacyDataValidator = pharmacyDataValidator;
        this.pharmacyImportPersistenceService = pharmacyImportPersistenceService;
    }

    @Override
    public ImportSummary importFrom(PharmacyDataProvider provider, PharmacyDataParser parser) {
        Instant startedAt = Instant.now();
        String providerName = provider.getProviderName();
        log.info("Starting pharmacy import from provider [{}] using parser format [{}]",
                providerName, parser.getSupportedFormat());

        List<ImportedPharmacyDto> records;
        try {
            String rawData = provider.fetchRawData();
            records = parser.parse(rawData);
        } catch (DataProviderException | DataParsingException ex) {
            log.error("Pharmacy import aborted: could not obtain data from provider [{}]", providerName, ex);
            return ImportSummary.aborted(providerName, startedAt, ex.getMessage());
        }

        log.info("Provider [{}] returned {} raw record(s) to process", providerName, records.size());

        List<ImportRecordResult> results = new ArrayList<>(records.size());
        for (ImportedPharmacyDto record : records) {
            results.add(processRecord(record));
        }

        ImportSummary summary = ImportSummary.of(providerName, startedAt, Instant.now(), results);
        log.info("Completed pharmacy import from provider [{}]: total={}, created={}, updated={}, "
                        + "skipped={}, failed={}",
                providerName, summary.getTotalRecords(),
                summary.countByOutcome(ImportOutcome.CREATED),
                summary.countByOutcome(ImportOutcome.UPDATED),
                summary.countByOutcome(ImportOutcome.SKIPPED),
                summary.countByOutcome(ImportOutcome.FAILED));
        return summary;
    }

    private ImportRecordResult processRecord(ImportedPharmacyDto record) {
        ValidationResult validationResult = pharmacyDataValidator.validate(record);
        if (!validationResult.isValid()) {
            log.warn("Skipping invalid pharmacy record [externalId={}]: {}",
                    record.getExternalId(), validationResult.getErrors());
            return ImportRecordResult.of(record.getExternalId(), ImportOutcome.SKIPPED,
                    String.join("; ", validationResult.getErrors()));
        }

        return pharmacyImportPersistenceService.saveOrUpdate(record);
    }

}
