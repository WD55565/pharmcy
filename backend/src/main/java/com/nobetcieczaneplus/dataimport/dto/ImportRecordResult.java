package com.nobetcieczaneplus.dataimport.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

/**
 * Outcome of processing a single record within a pharmacy import run.
 */
@Getter
@Builder
@ToString
public class ImportRecordResult {

    private final String externalId;
    private final ImportOutcome outcome;
    private final String message;

    public static ImportRecordResult of(String externalId, ImportOutcome outcome, String message) {
        return ImportRecordResult.builder()
                .externalId(externalId)
                .outcome(outcome)
                .message(message)
                .build();
    }

}
