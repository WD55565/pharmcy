import 'package:freezed_annotation/freezed_annotation.dart';

part 'pharmacy.freezed.dart';

/// Backend-agnostic pharmacy representation used throughout the app. Has no
/// knowledge of JSON or the network layer — see `data/models/pharmacy_model.dart`
/// for the wire format and its mapping onto this type.
@freezed
sealed class Pharmacy with _$Pharmacy {
  const Pharmacy._();

  const factory Pharmacy({
    required int id,
    required String name,
    required String phone,
    required String address,
    required String district,
    required double latitude,
    required double longitude,
    required bool isOnDuty,
    String? openingTime,
    String? closingTime,
  }) = _Pharmacy;

  /// `false` for the (0, 0) "Null Island" sentinel — a pharmacy record that
  /// technically has coordinates but not a meaningful location, e.g. one
  /// imported without geocoding.
  bool get hasCoordinates => latitude != 0 || longitude != 0;
}
