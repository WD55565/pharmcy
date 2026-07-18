import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/features/pharmacy/domain/entities/pharmacy.dart';
import 'package:mobile/features/pharmacy/presentation/widgets/pharmacy_map_preview.dart';

const _withCoordinates = Pharmacy(
  id: 1,
  name: 'Merkez Eczanesi',
  phone: '0212 111 11 11',
  address: 'Bağdat Caddesi No:1',
  district: 'Kadıköy',
  latitude: 40.99,
  longitude: 29.03,
  isOnDuty: true,
);

const _withoutCoordinates = Pharmacy(
  id: 2,
  name: 'Sahil Eczanesi',
  phone: '0212 222 22 22',
  address: 'Barbaros Bulvarı No:5',
  district: 'Beşiktaş',
  latitude: 0,
  longitude: 0,
  isOnDuty: false,
);

void main() {
  testWidgets('renders nothing when the pharmacy has no coordinates', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PharmacyMapPreview(pharmacy: _withoutCoordinates),
      ),
    );

    expect(find.byType(GoogleMap), findsNothing);
    expect(find.byType(SizedBox), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'renders a GoogleMap centered on the pharmacy with a single marker',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PharmacyMapPreview(pharmacy: _withCoordinates)),
      );

      final map = tester.widget<GoogleMap>(find.byType(GoogleMap));
      expect(map.initialCameraPosition.target, const LatLng(40.99, 29.03));
      expect(map.markers, hasLength(1));
      expect(map.markers.single.markerId, const MarkerId('pharmacy-1'));
      expect(map.markers.single.position, const LatLng(40.99, 29.03));
    },
  );

  testWidgets('disables all interactive gestures and location features', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: PharmacyMapPreview(pharmacy: _withCoordinates)),
    );

    final map = tester.widget<GoogleMap>(find.byType(GoogleMap));
    expect(map.zoomGesturesEnabled, isFalse);
    expect(map.scrollGesturesEnabled, isFalse);
    expect(map.rotateGesturesEnabled, isFalse);
    expect(map.tiltGesturesEnabled, isFalse);
    expect(map.myLocationEnabled, isFalse);
    expect(map.myLocationButtonEnabled, isFalse);
  });

  testWidgets('tapping the preview invokes onTap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: PharmacyMapPreview(
          pharmacy: _withCoordinates,
          onTap: () => tapped = true,
        ),
      ),
    );

    await tester.tap(find.byType(PharmacyMapPreview));
    expect(tapped, isTrue);
  });
}
