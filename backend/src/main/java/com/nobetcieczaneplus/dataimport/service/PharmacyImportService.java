package com.nobetcieczaneplus.dataimport.service;

import com.nobetcieczaneplus.dataimport.dto.ImportSummary;
import com.nobetcieczaneplus.dataimport.parser.PharmacyDataParser;
import com.nobetcieczaneplus.dataimport.provider.PharmacyDataProvider;

/**
 * Orchestrates a full pharmacy import run: fetch raw data from a provider, parse
 * it, validate each record, and persist it. The provider and parser are supplied
 * by the caller so new data sources can be added without changing this service.
 */
public interface PharmacyImportService {

    ImportSummary importFrom(PharmacyDataProvider provider, PharmacyDataParser parser);

}
