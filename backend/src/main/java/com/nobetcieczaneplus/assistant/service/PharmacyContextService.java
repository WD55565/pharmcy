package com.nobetcieczaneplus.assistant.service;

import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Service;

import com.nobetcieczaneplus.dto.PharmacyResponse;
import com.nobetcieczaneplus.service.PharmacyService;

/**
 * Decides whether a user message is asking about pharmacies and, if so,
 * builds a compact, factual snapshot of the current pharmacy data to give
 * Gemini as grounding context — a lightweight retrieval-augmented-generation
 * step: search the database first, then let the model phrase the answer
 * using only that retrieved data.
 */
@Service
public class PharmacyContextService {

    /** Capped so the prompt stays a reasonable size regardless of how many
     * pharmacies exist; small enough today that this never triggers. */
    private static final int MAX_PHARMACIES_IN_CONTEXT = 200;

    // Keywords in all three supported languages. Written with real
    // diacritics (not ASCII approximations) — a lowercase-only match on
    // 'nobetci' would never match the actual Turkish text 'nöbetçi'.
    private static final List<String> PHARMACY_KEYWORDS = List.of(
            "pharmac", "eczane", "nöbetçi", "nobetci", "duty", "district", "ilçe", "ilce",
            "hour", "saat", "address", "adres", "phone", "telefon", "open", "açık", "acik",
            "صيدلي", "صيدلية", "مناوب", "منطقة", "ساعة", "عنوان", "هاتف"
    );

    private final PharmacyService pharmacyService;

    public PharmacyContextService(PharmacyService pharmacyService) {
        this.pharmacyService = pharmacyService;
    }

    public boolean isPharmacyRelated(String message) {
        String normalized = message.toLowerCase(Locale.forLanguageTag("tr"));
        return PHARMACY_KEYWORDS.stream().anyMatch(keyword -> normalized.contains(keyword.toLowerCase(Locale.ROOT)));
    }

    /**
     * A markdown-ish block listing current pharmacies, meant to be embedded
     * in the system instruction sent to the AI provider.
     */
    public String buildContext() {
        List<PharmacyResponse> pharmacies = pharmacyService.getAllPharmacies();
        if (pharmacies.isEmpty()) {
            return "There is currently no pharmacy data available in the database.";
        }

        StringBuilder sb = new StringBuilder();
        sb.append("Current pharmacy database (this is the complete, authoritative list — do not invent ")
                .append("pharmacies that aren't in it):\n");
        pharmacies.stream().limit(MAX_PHARMACIES_IN_CONTEXT).forEach(pharmacy -> sb.append("- ")
                .append(pharmacy.getName())
                .append(" | district: ").append(pharmacy.getDistrict())
                .append(" | address: ").append(pharmacy.getAddress())
                .append(" | phone: ").append(pharmacy.getPhone())
                .append(" | status: ").append(Boolean.TRUE.equals(pharmacy.getIsOnDuty()) ? "ON DUTY" : "not on duty")
                .append(pharmacy.getOpeningTime() != null && pharmacy.getClosingTime() != null
                        ? " | hours: " + pharmacy.getOpeningTime() + "-" + pharmacy.getClosingTime()
                        : "")
                .append('\n'));
        return sb.toString();
    }

}
