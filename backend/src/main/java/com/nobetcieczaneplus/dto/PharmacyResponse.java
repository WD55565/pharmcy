package com.nobetcieczaneplus.dto;

import java.time.LocalTime;

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
public class PharmacyResponse {

    private Long id;
    private String name;
    private String phone;
    private String address;
    private String district;
    private Double latitude;
    private Double longitude;
    private Boolean isOnDuty;
    private LocalTime openingTime;
    private LocalTime closingTime;

}
