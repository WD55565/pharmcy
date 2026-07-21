package com.nobetcieczaneplus.assistant.controller;

import jakarta.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nobetcieczaneplus.assistant.dto.AssistantChatRequest;
import com.nobetcieczaneplus.assistant.dto.AssistantChatResponse;
import com.nobetcieczaneplus.assistant.service.AssistantService;

@RestController
@RequestMapping("/api/assistant")
public class AssistantController {

    private final AssistantService assistantService;

    public AssistantController(AssistantService assistantService) {
        this.assistantService = assistantService;
    }

    @PostMapping("/chat")
    public ResponseEntity<AssistantChatResponse> chat(@Valid @RequestBody AssistantChatRequest request) {
        String reply = assistantService.reply(request);
        return ResponseEntity.ok(AssistantChatResponse.builder().reply(reply).build());
    }

}
