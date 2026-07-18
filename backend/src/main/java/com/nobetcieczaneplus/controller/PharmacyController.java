package com.nobetcieczaneplus.controller;

import java.net.URI;
import java.util.List;

import jakarta.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nobetcieczaneplus.dto.PharmacyRequest;
import com.nobetcieczaneplus.dto.PharmacyResponse;
import com.nobetcieczaneplus.service.PharmacyService;

@RestController
@RequestMapping("/api/pharmacies")
public class PharmacyController {

    private final PharmacyService pharmacyService;

    public PharmacyController(PharmacyService pharmacyService) {
        this.pharmacyService = pharmacyService;
    }

    @GetMapping
    public ResponseEntity<List<PharmacyResponse>> getAllPharmacies() {
        return ResponseEntity.ok(pharmacyService.getAllPharmacies());
    }

    @GetMapping("/{id}")
    public ResponseEntity<PharmacyResponse> getPharmacyById(@PathVariable Long id) {
        return ResponseEntity.ok(pharmacyService.getPharmacyById(id));
    }

    @PostMapping
    public ResponseEntity<PharmacyResponse> createPharmacy(@Valid @RequestBody PharmacyRequest request) {
        PharmacyResponse created = pharmacyService.createPharmacy(request);
        return ResponseEntity.created(URI.create("/api/pharmacies/" + created.getId())).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<PharmacyResponse> updatePharmacy(@PathVariable Long id,
                                                             @Valid @RequestBody PharmacyRequest request) {
        return ResponseEntity.ok(pharmacyService.updatePharmacy(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePharmacy(@PathVariable Long id) {
        pharmacyService.deletePharmacy(id);
        return ResponseEntity.noContent().build();
    }

}
