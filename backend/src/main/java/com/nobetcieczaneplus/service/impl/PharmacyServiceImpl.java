package com.nobetcieczaneplus.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nobetcieczaneplus.dto.PharmacyRequest;
import com.nobetcieczaneplus.dto.PharmacyResponse;
import com.nobetcieczaneplus.entity.Pharmacy;
import com.nobetcieczaneplus.exception.ResourceNotFoundException;
import com.nobetcieczaneplus.repository.PharmacyRepository;
import com.nobetcieczaneplus.service.PharmacyService;

@Service
@Transactional
public class PharmacyServiceImpl implements PharmacyService {

    private final PharmacyRepository pharmacyRepository;

    public PharmacyServiceImpl(PharmacyRepository pharmacyRepository) {
        this.pharmacyRepository = pharmacyRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<PharmacyResponse> getAllPharmacies() {
        return pharmacyRepository.findAll()
                .stream()
                .map(this::toResponse)
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public PharmacyResponse getPharmacyById(Long id) {
        Pharmacy pharmacy = findPharmacyOrThrow(id);
        return toResponse(pharmacy);
    }

    @Override
    public PharmacyResponse createPharmacy(PharmacyRequest request) {
        Pharmacy pharmacy = toEntity(request);
        Pharmacy saved = pharmacyRepository.save(pharmacy);
        return toResponse(saved);
    }

    @Override
    public PharmacyResponse updatePharmacy(Long id, PharmacyRequest request) {
        Pharmacy pharmacy = findPharmacyOrThrow(id);

        pharmacy.setName(request.getName());
        pharmacy.setPhone(request.getPhone());
        pharmacy.setAddress(request.getAddress());
        pharmacy.setDistrict(request.getDistrict());
        pharmacy.setLatitude(request.getLatitude());
        pharmacy.setLongitude(request.getLongitude());
        pharmacy.setIsOnDuty(request.getIsOnDuty());

        Pharmacy updated = pharmacyRepository.save(pharmacy);
        return toResponse(updated);
    }

    @Override
    public void deletePharmacy(Long id) {
        Pharmacy pharmacy = findPharmacyOrThrow(id);
        pharmacyRepository.delete(pharmacy);
    }

    private Pharmacy findPharmacyOrThrow(Long id) {
        return pharmacyRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Pharmacy not found with id: " + id));
    }

    private Pharmacy toEntity(PharmacyRequest request) {
        return Pharmacy.builder()
                .name(request.getName())
                .phone(request.getPhone())
                .address(request.getAddress())
                .district(request.getDistrict())
                .latitude(request.getLatitude())
                .longitude(request.getLongitude())
                .isOnDuty(request.getIsOnDuty())
                .build();
    }

    private PharmacyResponse toResponse(Pharmacy pharmacy) {
        return PharmacyResponse.builder()
                .id(pharmacy.getId())
                .name(pharmacy.getName())
                .phone(pharmacy.getPhone())
                .address(pharmacy.getAddress())
                .district(pharmacy.getDistrict())
                .latitude(pharmacy.getLatitude())
                .longitude(pharmacy.getLongitude())
                .isOnDuty(pharmacy.getIsOnDuty())
                .openingTime(pharmacy.getOpeningTime())
                .closingTime(pharmacy.getClosingTime())
                .build();
    }

}
