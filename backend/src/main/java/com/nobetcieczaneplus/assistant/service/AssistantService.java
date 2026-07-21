package com.nobetcieczaneplus.assistant.service;

import com.nobetcieczaneplus.assistant.dto.AssistantChatRequest;

public interface AssistantService {

    /** Orchestrates intent detection, DB retrieval, and the AI call; returns the assistant's reply text. */
    String reply(AssistantChatRequest request);

}
