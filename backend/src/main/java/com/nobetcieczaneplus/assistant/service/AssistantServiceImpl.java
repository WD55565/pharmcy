package com.nobetcieczaneplus.assistant.service;

import org.springframework.stereotype.Service;

import com.nobetcieczaneplus.assistant.dto.AssistantChatRequest;

/**
 * Orchestrates a single assistant turn:
 * 1. Decide if the question is pharmacy-related ({@link PharmacyContextService}).
 * 2. If so, retrieve current pharmacy data from the database first and fold
 *    it into the system instruction as grounding context.
 * 3. Delegate the actual language generation to {@link AiClient} — provider
 *    swappable independent of this orchestration logic.
 */
@Service
public class AssistantServiceImpl implements AssistantService {

    private static final String BASE_PERSONA = """
            You are the helpful in-app assistant for "Nöbetçi Eczane+", an app that helps people in \
            Istanbul, Turkey find on-duty ("nöbetçi") pharmacies. Be concise, friendly, and factual. \
            Detect the language the user is writing their message in and reply in that same language. \
            The app's currently selected language is "%s" — if the user's message is too short or \
            ambiguous to detect a language from, reply in that language instead. You support exactly \
            three languages: Arabic, English, and Turkish; never reply in any other language.""";

    private final PharmacyContextService pharmacyContextService;
    private final AiClient aiClient;

    public AssistantServiceImpl(PharmacyContextService pharmacyContextService, AiClient aiClient) {
        this.pharmacyContextService = pharmacyContextService;
        this.aiClient = aiClient;
    }

    @Override
    public String reply(AssistantChatRequest request) {
        String language = request.getLanguage() == null || request.getLanguage().isBlank()
                ? "English"
                : request.getLanguage();

        StringBuilder systemInstruction = new StringBuilder(BASE_PERSONA.formatted(language));

        if (pharmacyContextService.isPharmacyRelated(request.getMessage())) {
            systemInstruction.append("\n\n").append(pharmacyContextService.buildContext());
            systemInstruction.append(
                    "\nAnswer using only the data above. If what's asked isn't covered by it, say so honestly ")
                    .append("rather than guessing.");
        }

        return aiClient.generateReply(systemInstruction.toString(), request.getHistory(), request.getMessage());
    }

}
