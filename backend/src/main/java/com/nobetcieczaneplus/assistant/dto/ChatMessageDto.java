package com.nobetcieczaneplus.assistant.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * One turn of prior conversation, provider-agnostic ("user"/"assistant" —
 * not, say, Gemini's own "user"/"model" convention). Mapped to whatever
 * shape a given {@link com.nobetcieczaneplus.assistant.service.AiClient}
 * implementation needs internally.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatMessageDto {

    @NotBlank
    @Pattern(regexp = "user|assistant", message = "role must be 'user' or 'assistant'")
    private String role;

    @NotBlank
    private String content;

}
