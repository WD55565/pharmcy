package com.nobetcieczaneplus.assistant.service;

import java.util.List;

import com.nobetcieczaneplus.assistant.dto.ChatMessageDto;
import com.nobetcieczaneplus.assistant.exception.AiServiceException;

/**
 * Provider-agnostic seam for whatever generative AI backend actually
 * answers a message. Today implemented by {@link GeminiAiClient}; swapping
 * to a different provider later (OpenAI, Claude, a self-hosted model, ...)
 * means writing a new implementation of this interface and changing one
 * Spring bean — {@link AssistantServiceImpl} and the controller never
 * change.
 */
public interface AiClient {

    /**
     * @param systemInstruction persona/behavior instructions (language,
     *                          tone, retrieved pharmacy context if any) —
     *                          not part of the visible conversation
     * @param history           prior turns, oldest first
     * @param userMessage       the new message to answer
     * @throws AiServiceException if the provider can't be reached or fails
     */
    String generateReply(String systemInstruction, List<ChatMessageDto> history, String userMessage);

}
