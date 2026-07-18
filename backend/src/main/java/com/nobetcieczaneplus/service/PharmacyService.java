package com.nobetcieczaneplus.service;

import java.util.List;

import com.nobetcieczaneplus.dto.PharmacyRequest;
import com.nobetcieczaneplus.dto.PharmacyResponse;

public interface PharmacyService {

    List<PharmacyResponse> getAllPharmacies();

    PharmacyResponse getPharmacyById(Long id);

    PharmacyResponse createPharmacy(PharmacyRequest request);

    PharmacyResponse updatePharmacy(Long id, PharmacyRequest request);

    void deletePharmacy(Long id);

}
