package com.nobetcieczaneplus.dataimport.parser;

import java.util.List;

import com.nobetcieczaneplus.dataimport.dto.ImportedPharmacyDto;

/**
 * Converts the raw text produced by a
 * {@link com.nobetcieczaneplus.dataimport.provider.PharmacyDataProvider} into a list
 * of provider-agnostic {@link ImportedPharmacyDto} records.
 * <p>
 * Each source format (JSON, CSV, HTML table, ...) gets its own implementation,
 * allowing new providers to be plugged in without touching the rest of the
 * import pipeline.
 */
public interface PharmacyDataParser {

    /**
     * The raw data format this parser understands (e.g. "JSON", "CSV"), used for
     * pairing a parser with a compatible provider and for logging.
     */
    String getSupportedFormat();

    /**
     * Parses raw provider output into importable pharmacy records.
     *
     * @throws DataParsingException if the raw data is not in the expected format
     */
    List<ImportedPharmacyDto> parse(String rawData) throws DataParsingException;

}
