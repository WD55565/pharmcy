package com.nobetcieczaneplus.assistant.service;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.web.client.RestClient;

import com.nobetcieczaneplus.assistant.exception.AiServiceException;

import static org.assertj.core.api.Assertions.assertThatThrownBy;

class GeminiAiClientTest {

    @Test
    void throwsACleanErrorWhenNoApiKeyIsConfigured() {
        GeminiAiClient client = new GeminiAiClient(
                RestClient.builder(), "", "gemini-2.0-flash", "https://generativelanguage.googleapis.com/v1beta"
        );

        assertThatThrownBy(() -> client.generateReply("system", List.of(), "hello"))
                .isInstanceOf(AiServiceException.class)
                .hasMessageContaining("not configured");
    }

    @Test
    void throwsACleanErrorWhenApiKeyIsBlank() {
        GeminiAiClient client = new GeminiAiClient(
                RestClient.builder(), "   ", "gemini-2.0-flash", "https://generativelanguage.googleapis.com/v1beta"
        );

        assertThatThrownBy(() -> client.generateReply("system", List.of(), "hello"))
                .isInstanceOf(AiServiceException.class);
    }

}
