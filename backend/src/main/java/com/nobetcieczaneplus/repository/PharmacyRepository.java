package com.nobetcieczaneplus.repository;

import java.util.Optional;

import com.nobetcieczaneplus.entity.Pharmacy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PharmacyRepository extends JpaRepository<Pharmacy, Long> {

    Optional<Pharmacy> findBySourceAndExternalId(String source, String externalId);

}
