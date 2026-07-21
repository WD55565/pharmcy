package com.nobetcieczaneplus.assistant.service;

import java.time.LocalTime;
import java.util.List;

import org.junit.jupiter.api.Test;

import com.nobetcieczaneplus.dto.PharmacyResponse;
import com.nobetcieczaneplus.service.PharmacyService;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class PharmacyContextServiceTest {

    private final PharmacyService pharmacyService = mock(PharmacyService.class);
    private final PharmacyContextService service = new PharmacyContextService(pharmacyService);

    @Test
    void recognizesEnglishPharmacyKeywords() {
        assertThat(service.isPharmacyRelated("which pharmacies are on duty right now?")).isTrue();
        assertThat(service.isPharmacyRelated("what is the address of the nearest one?")).isTrue();
    }

    @Test
    void recognizesTurkishPharmacyKeywordsWithRealDiacritics() {
        // Regression guard: an ASCII-approximated keyword like "nobetci"
        // would never match real Turkish text like "nöbetçi" — this
        // exact class of bug bit the mobile mock assistant earlier.
        assertThat(service.isPharmacyRelated("hangi eczaneler nöbetçi?")).isTrue();
        assertThat(service.isPharmacyRelated("saat kaçta kapanıyor?")).isTrue();
    }

    @Test
    void recognizesArabicPharmacyKeywords() {
        assertThat(service.isPharmacyRelated("ما هي الصيدليات المناوبة؟")).isTrue();
    }

    @Test
    void doesNotFlagUnrelatedQuestions() {
        assertThat(service.isPharmacyRelated("what's the weather like today?")).isFalse();
        assertThat(service.isPharmacyRelated("tell me a joke")).isFalse();
    }

    @Test
    void buildContextListsEachPharmacyWithKeyFields() {
        when(pharmacyService.getAllPharmacies()).thenReturn(List.of(
                PharmacyResponse.builder()
                        .name("Kadıköy Merkez Eczanesi")
                        .district("Kadıköy")
                        .address("Söğütlüçeşme Cad. No:12")
                        .phone("0216 336 12 34")
                        .isOnDuty(true)
                        .openingTime(LocalTime.of(20, 0))
                        .closingTime(LocalTime.of(8, 0))
                        .build()
        ));

        String context = service.buildContext();

        assertThat(context).contains("Kadıköy Merkez Eczanesi");
        assertThat(context).contains("ON DUTY");
        assertThat(context).contains("20:00");
    }

    @Test
    void buildContextHandlesAnEmptyDatabaseGracefully() {
        when(pharmacyService.getAllPharmacies()).thenReturn(List.of());

        assertThat(service.buildContext()).contains("no pharmacy data");
    }

}
