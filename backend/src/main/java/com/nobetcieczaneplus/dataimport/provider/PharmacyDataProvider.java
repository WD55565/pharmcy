package com.nobetcieczaneplus.dataimport.provider;

/**
 * Supplies raw, unparsed pharmacy data from a single external source.
 * <p>
 * Concrete implementations are added per data source (e.g. a specific municipality
 * or chamber-of-pharmacists feed). This interface intentionally says nothing about
 * transport (HTTP, file, etc.) or format (JSON, CSV, HTML) — that is the concern of
 * the implementation and of the paired
 * {@link com.nobetcieczaneplus.dataimport.parser.PharmacyDataParser}.
 */
public interface PharmacyDataProvider {

    /**
     * Stable identifier for this data source, used for logging and for tagging
     * imported records so duplicates can be detected across import runs.
     */
    String getProviderName();

    /**
     * Retrieves the raw data for this source in whatever textual format it publishes.
     *
     * @throws DataProviderException if the data could not be obtained
     */
    String fetchRawData() throws DataProviderException;

}
