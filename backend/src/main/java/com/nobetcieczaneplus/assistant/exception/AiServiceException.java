package com.nobetcieczaneplus.assistant.exception;

/**
 * Thrown when the underlying AI provider can't produce a reply — missing
 * configuration, network failure, quota exhaustion, or a malformed
 * response. Caught centrally by {@code GlobalExceptionHandler} and turned
 * into a clean 503 rather than a raw 500.
 */
public class AiServiceException extends RuntimeException {

    public AiServiceException(String message) {
        super(message);
    }

    public AiServiceException(String message, Throwable cause) {
        super(message, cause);
    }

}
