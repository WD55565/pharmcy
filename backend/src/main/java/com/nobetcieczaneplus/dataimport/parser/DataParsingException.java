package com.nobetcieczaneplus.dataimport.parser;

/**
 * Thrown when a {@link PharmacyDataParser} cannot interpret the raw data supplied
 * by a {@link com.nobetcieczaneplus.dataimport.provider.PharmacyDataProvider}.
 */
public class DataParsingException extends Exception {

    public DataParsingException(String message) {
        super(message);
    }

    public DataParsingException(String message, Throwable cause) {
        super(message, cause);
    }

}
