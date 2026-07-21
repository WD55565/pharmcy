package com.nobetcieczaneplus.assistant.service;

import java.util.List;

import org.junit.jupiter.api.Test;

import com.nobetcieczaneplus.assistant.dto.AssistantChatRequest;
import com.nobetcieczaneplus.assistant.dto.ChatMessageDto;
import com.nobetcieczaneplus.dto.PharmacyResponse;
import com.nobetcieczaneplus.service.PharmacyService;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class AssistantServiceImplTest {

    private final PharmacyService pharmacyService = mock(PharmacyService.class);
    private final PharmacyContextService pharmacyContextService = new PharmacyContextService(pharmacyService);

    /** Captures exactly what would be sent to the AI provider, without any network call. */
    private static final class CapturingAiClient implements AiClient {
        String capturedSystemInstruction;
        List<ChatMessageDto> capturedHistory;
        String capturedUserMessage;

        @Override
        public String generateReply(String systemInstruction, List<ChatMessageDto> history, String userMessage) {
            this.capturedSystemInstruction = systemInstruction;
            this.capturedHistory = history;
            this.capturedUserMessage = userMessage;
            return "canned reply";
        }
    }

    @Test
    void includesPharmacyContextWhenTheQuestionIsPharmacyRelated() {
        when(pharmacyService.getAllPharmacies()).thenReturn(List.of(
                PharmacyResponse.builder().name("Merkez Eczanesi").district("Kadıköy")
                        .address("Test Sk.").phone("0212").isOnDuty(true).build()
        ));
        CapturingAiClient aiClient = new CapturingAiClient();
        AssistantServiceImpl service = new AssistantServiceImpl(pharmacyContextService, aiClient);

        String reply = service.reply(AssistantChatRequest.builder()
                .message("which pharmacies are on duty?")
                .language("English")
                .history(List.of())
                .build());

        assertThat(reply).isEqualTo("canned reply");
        assertThat(aiClient.capturedSystemInstruction).contains("Merkez Eczanesi");
        assertThat(aiClient.capturedUserMessage).isEqualTo("which pharmacies are on duty?");
    }

    @Test
    void omitsPharmacyContextForUnrelatedQuestions() {
        CapturingAiClient aiClient = new CapturingAiClient();
        AssistantServiceImpl service = new AssistantServiceImpl(pharmacyContextService, aiClient);

        service.reply(AssistantChatRequest.builder()
                .message("tell me a joke")
                .language("English")
                .history(List.of())
                .build());

        assertThat(aiClient.capturedSystemInstruction).doesNotContain("Current pharmacy database");
    }

    @Test
    void systemInstructionMentionsTheSelectedLanguage() {
        CapturingAiClient aiClient = new CapturingAiClient();
        AssistantServiceImpl service = new AssistantServiceImpl(pharmacyContextService, aiClient);

        service.reply(AssistantChatRequest.builder()
                .message("merhaba")
                .language("Turkish")
                .history(List.of())
                .build());

        assertThat(aiClient.capturedSystemInstruction).contains("Turkish");
    }

    @Test
    void defaultsToEnglishWhenNoLanguageIsProvided() {
        CapturingAiClient aiClient = new CapturingAiClient();
        AssistantServiceImpl service = new AssistantServiceImpl(pharmacyContextService, aiClient);

        service.reply(AssistantChatRequest.builder()
                .message("hello")
                .history(List.of())
                .build());

        assertThat(aiClient.capturedSystemInstruction).contains("English");
    }

    @Test
    void forwardsConversationHistoryUnchanged() {
        CapturingAiClient aiClient = new CapturingAiClient();
        AssistantServiceImpl service = new AssistantServiceImpl(pharmacyContextService, aiClient);
        List<ChatMessageDto> history = List.of(
                ChatMessageDto.builder().role("user").content("hi").build(),
                ChatMessageDto.builder().role("assistant").content("hello!").build()
        );

        service.reply(AssistantChatRequest.builder()
                .message("follow up question")
                .language("English")
                .history(history)
                .build());

        assertThat(aiClient.capturedHistory).isEqualTo(history);
    }

}
