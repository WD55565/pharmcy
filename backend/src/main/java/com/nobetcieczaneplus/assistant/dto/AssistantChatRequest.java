package com.nobetcieczaneplus.assistant.dto;

import java.util.List;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AssistantChatRequest {

    @NotBlank
    private String message;

    /** Prior turns, oldest first, not including {@link #message}. */
    @Valid
    @Builder.Default
    private List<ChatMessageDto> history = List.of();

    /**
     * The app's currently selected conversation language ("en", "tr", or
     * "ar") — used as the default/fallback language; the assistant still
     * auto-detects and prioritizes whatever language the user actually
     * wrote {@link #message} in.
     */
    private String language;

}
