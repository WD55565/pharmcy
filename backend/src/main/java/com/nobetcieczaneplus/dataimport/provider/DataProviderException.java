package com.nobetcieczaneplus.dataimport.provider;

/**
 * Thrown when a {@link PharmacyDataProvider} fails to obtain raw pharmacy data.
 */
public class DataProviderException extends Exception {

    public DataProviderException(String message) {
        super(message);
    }

    public DataProviderException(String message, Throwable cause) {
        super(message, cause);
    }

}
