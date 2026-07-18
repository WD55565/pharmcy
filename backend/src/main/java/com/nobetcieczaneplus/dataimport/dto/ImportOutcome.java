package com.nobetcieczaneplus.dataimport.dto;

/**
 * Result of attempting to persist a single imported pharmacy record.
 */
public enum ImportOutcome {

    /** A new pharmacy row was created. */
    CREATED,

    /** An existing pharmacy row was found and its data changed. */
    UPDATED,

    /** The record was valid but no persistence was necessary (duplicate with no changes, or failed validation). */
    SKIPPED,

    /** Persisting the record failed unexpectedly. */
    FAILED

}
