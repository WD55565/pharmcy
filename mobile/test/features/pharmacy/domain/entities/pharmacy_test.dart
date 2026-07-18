import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/pharmacy/domain/entities/pharmacy.dart';

Pharmacy _pharmacyWith({required double latitude, required double longitude}) {
  return Pharmacy(
    id: 1,
    name: 'Test Eczanesi',
    phone: '0212 000 00 00',
    address: 'Test Sokak No:1',
    district: 'Kadıköy',
    latitude: latitude,
    longitude: longitude,
    isOnDuty: true,
  );
}

void main() {
  group('Pharmacy.hasCoordinates', () {
    test('true for a normal, non-zero coordinate pair', () {
      expect(
        _pharmacyWith(latitude: 40.99, longitude: 29.03).hasCoordinates,
        isTrue,
      );
    });

    test('true when only one of latitude/longitude is non-zero', () {
      expect(
        _pharmacyWith(latitude: 0, longitude: 29.03).hasCoordinates,
        isTrue,
      );
      expect(
        _pharmacyWith(latitude: 40.99, longitude: 0).hasCoordinates,
        isTrue,
      );
    });

    test('false for the (0, 0) sentinel used to mean "no coordinates"', () {
      expect(_pharmacyWith(latitude: 0, longitude: 0).hasCoordinates, isFalse);
    });
  });
}
