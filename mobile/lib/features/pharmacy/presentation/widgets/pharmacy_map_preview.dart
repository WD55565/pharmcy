import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/pharmacy.dart';

/// Small, non-interactive map preview showing the pharmacy's location with
/// a single marker. Renders nothing at all when the pharmacy has no usable
/// coordinates, rather than showing a broken or misleading map.
///
/// Deliberately read-only (no zoom/scroll/rotate/tilt gestures, no "my
/// location" button) — it's a preview, not a navigation tool; full
/// interaction happens by tapping through to the device's own maps app via
/// the "Open in Maps" button. This also means no location permission is
/// ever requested by this widget.
class PharmacyMapPreview extends StatelessWidget {
  const PharmacyMapPreview({required this.pharmacy, this.onTap, super.key});

  final Pharmacy pharmacy;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (!pharmacy.hasCoordinates) return const SizedBox.shrink();

    final position = LatLng(pharmacy.latitude, pharmacy.longitude);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: double.infinity,
        height: 180,
        child: GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: position, zoom: 15),
              markers: {
                Marker(
                  markerId: MarkerId('pharmacy-${pharmacy.id}'),
                  position: position,
                ),
              },
              liteModeEnabled: true,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              scrollGesturesEnabled: false,
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              mapToolbarEnabled: false,
            ),
          ),
        ),
      ),
    );
  }
}
