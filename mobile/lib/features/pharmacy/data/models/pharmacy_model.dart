import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pharmacy.dart';

part 'pharmacy_model.freezed.dart';
part 'pharmacy_model.g.dart';

/// Mirrors the backend's `PharmacyResponse`
/// (`backend/src/main/java/com/nobetcieczaneplus/dto/PharmacyResponse.java`)
/// field-for-field. Never used directly by the presentation layer — always
/// converted to a [Pharmacy] entity first via [toEntity].
@freezed
sealed class PharmacyModel with _$PharmacyModel {
  const PharmacyModel._();

  const factory PharmacyModel({
    required int id,
    required String name,
    required String phone,
    required String address,
    required String district,
    required double latitude,
    required double longitude,
    required bool isOnDuty,
    // Backend serializes java.time.LocalTime as an "HH:mm:ss" string; kept
    // as a raw string here and formatted for display in the presentation
    // layer rather than parsed into a Dart time type this app doesn't
    // otherwise need.
    String? openingTime,
    String? closingTime,
  }) = _PharmacyModel;

  factory PharmacyModel.fromJson(Map<String, dynamic> json) =>
      _$PharmacyModelFromJson(json);

  Pharmacy toEntity() => Pharmacy(
    id: id,
    name: name,
    phone: phone,
    address: address,
    district: district,
    latitude: latitude,
    longitude: longitude,
    isOnDuty: isOnDuty,
    openingTime: openingTime,
    closingTime: closingTime,
  );
}
