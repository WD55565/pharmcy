package com.nobetcieczaneplus.assistant.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientException;

import com.nobetcieczaneplus.assistant.dto.ChatMessageDto;
import com.nobetcieczaneplus.assistant.exception.AiServiceException;

/**
 * {@link AiClient} backed by Google's Gemini API
 * (generativelanguage.googleapis.com). The API key is read exclusively
 * from configuration ({@code gemini.api-key}, backed by the
 * {@code GEMINI_API_KEY} environment variable) — never hardcoded, never
 * logged.
 */
@Component
public class GeminiAiClient implements AiClient {

    private static final Logger log = LoggerFactory.getLogger(GeminiAiClient.class);

    private final RestClient restClient;
    private final String apiKey;
    private final String model;

    public GeminiAiClient(
            RestClient.Builder restClientBuilder,
            @Value("${gemini.api-key:}") String apiKey,
            @Value("${gemini.model:gemini-2.0-flash}") String model,
            @Value("${gemini.base-url:https://generativelanguage.googleapis.com/v1beta}") String baseUrl) {
        this.apiKey = apiKey;
        this.model = model;
        this.restClient = restClientBuilder.baseUrl(baseUrl).build();
    }

    @Override
    public String generateReply(String systemInstruction, List<ChatMessageDto> history, String userMessage) {
        if (apiKey == null || apiKey.isBlank()) {
            throw new AiServiceException("The AI assistant is not configured (missing GEMINI_API_KEY).");
        }

        GeminiRequest request = buildRequest(systemInstruction, history, userMessage);

        try {
            GeminiResponse response = restClient.post()
                    .uri("/models/{model}:generateContent?key={key}", model, apiKey)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(request)
                    .retrieve()
                    .body(GeminiResponse.class);

            return extractText(response);
        } catch (RestClientException e) {
            log.error("Gemini request failed", e);
            throw new AiServiceException("The AI assistant is temporarily unavailable. Please try again shortly.", e);
        }
    }

    private GeminiRequest buildRequest(String systemInstruction, List<ChatMessageDto> history, String userMessage) {
        List<GeminiContent> contents = new ArrayList<>();
        for (ChatMessageDto turn : history) {
            contents.add(new GeminiContent(toGeminiRole(turn.getRole()), List.of(new GeminiPart(turn.getContent()))));
        }
        contents.add(new GeminiContent("user", List.of(new GeminiPart(userMessage))));

        GeminiSystemInstruction system = new GeminiSystemInstruction(List.of(new GeminiPart(systemInstruction)));
        return new GeminiRequest(system, contents);
    }

    private String toGeminiRole(String role) {
        // Gemini uses "model" where the rest of this app says "assistant".
        return "assistant".equals(role) ? "model" : "user";
    }

    private String extractText(GeminiResponse response) {
        if (response == null || response.candidates() == null || response.candidates().isEmpty()) {
            throw new AiServiceException("The AI assistant returned an empty response.");
        }
        GeminiContent content = response.candidates().get(0).content();
        if (content == null || content.parts() == null || content.parts().isEmpty()) {
            throw new AiServiceException("The AI assistant returned an empty response.");
        }
        String text = content.parts().get(0).text();
        if (text == null || text.isBlank()) {
            throw new AiServiceException("The AI assistant returned an empty response.");
        }
        return text;
    }

    // ---- Gemini REST API request/response shapes (internal to this class) ----

    private record GeminiRequest(GeminiSystemInstruction systemInstruction, List<GeminiContent> contents) {
    }

    private record GeminiSystemInstruction(List<GeminiPart> parts) {
    }

    private record GeminiContent(String role, List<GeminiPart> parts) {
    }

    private record GeminiPart(String text) {
    }

    private record GeminiResponse(List<GeminiCandidate> candidates) {
    }

    private record GeminiCandidate(GeminiContent content) {
    }

}
