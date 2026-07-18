package com.nobetcieczaneplus.dataimport.dto;

import java.time.Instant;
import java.util.List;

import lombok.Getter;
import lombok.ToString;

/**
 * Aggregate result of a single pharmacy import run, produced by
 * {@link com.nobetcieczaneplus.dataimport.service.PharmacyImportService}.
 */
@Getter
@ToString
public class ImportSummary {

    private final String providerName;
    private final Instant startedAt;
    private final Instant finishedAt;
    private final boolean aborted;
    private final String abortReason;
    private final List<ImportRecordResult> results;

    private ImportSummary(String providerName, Instant startedAt, Instant finishedAt,
                           boolean aborted, String abortReason, List<ImportRecordResult> results) {
        this.providerName = providerName;
        this.startedAt = startedAt;
        this.finishedAt = finishedAt;
        this.aborted = aborted;
        this.abortReason = abortReason;
        this.results = results;
    }

    public static ImportSummary of(String providerName, Instant startedAt, Instant finishedAt,
                                    List<ImportRecordResult> results) {
        return new ImportSummary(providerName, startedAt, finishedAt, false, null, results);
    }

    public static ImportSummary aborted(String providerName, Instant startedAt, String reason) {
        return new ImportSummary(providerName, startedAt, Instant.now(), true, reason, List.of());
    }

    public long countByOutcome(ImportOutcome outcome) {
        return results.stream().filter(result -> result.getOutcome() == outcome).count();
    }

    public int getTotalRecords() {
        return results.size();
    }

}
