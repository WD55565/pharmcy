package com.nobetcieczaneplus.dataimport.mapper;

import java.util.Objects;
import java.util.function.Consumer;
import java.util.function.Supplier;

import org.springframework.stereotype.Component;

import com.nobetcieczaneplus.dataimport.dto.ImportedPharmacyDto;
import com.nobetcieczaneplus.entity.Pharmacy;

@Component
public class PharmacyImportMapperImpl implements PharmacyImportMapper {

    @Override
    public Pharmacy toNewEntity(ImportedPharmacyDto dto) {
        return Pharmacy.builder()
                .source(dto.getSource())
                .externalId(dto.getExternalId())
                .name(dto.getName())
                .phone(dto.getPhone())
                .address(dto.getAddress())
                .district(dto.getDistrict())
                .latitude(dto.getLatitude())
                .longitude(dto.getLongitude())
                .isOnDuty(dto.getOnDuty())
                .openingTime(dto.getOpeningTime())
                .closingTime(dto.getClosingTime())
                .build();
    }

    @Override
    public boolean applyChanges(Pharmacy existing, ImportedPharmacyDto dto) {
        boolean changed = false;
        changed |= updateIfDifferent(existing::getName, existing::setName, dto.getName());
        changed |= updateIfDifferent(existing::getPhone, existing::setPhone, dto.getPhone());
        changed |= updateIfDifferent(existing::getAddress, existing::setAddress, dto.getAddress());
        changed |= updateIfDifferent(existing::getDistrict, existing::setDistrict, dto.getDistrict());
        changed |= updateIfDifferent(existing::getLatitude, existing::setLatitude, dto.getLatitude());
        changed |= updateIfDifferent(existing::getLongitude, existing::setLongitude, dto.getLongitude());
        changed |= updateIfDifferent(existing::getIsOnDuty, existing::setIsOnDuty, dto.getOnDuty());
        changed |= updateIfDifferent(existing::getOpeningTime, existing::setOpeningTime, dto.getOpeningTime());
        changed |= updateIfDifferent(existing::getClosingTime, existing::setClosingTime, dto.getClosingTime());
        return changed;
    }

    private <T> boolean updateIfDifferent(Supplier<T> getter, Consumer<T> setter, T newValue) {
        if (!Objects.equals(getter.get(), newValue)) {
            setter.accept(newValue);
            return true;
        }
        return false;
    }

}
