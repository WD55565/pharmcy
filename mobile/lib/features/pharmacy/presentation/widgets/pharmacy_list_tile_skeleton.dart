import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/shimmer_box.dart';

/// Placeholder shaped like [PharmacyListTile], shown while the pharmacy
/// list is loading so the layout doesn't jump once real data arrives.
class PharmacyListTileSkeleton extends StatelessWidget {
  const PharmacyListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerBox(width: 40, height: 40, borderRadius: 20),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerBox(width: 160, height: 16),
                  const SizedBox(height: AppSpacing.sm),
                  const ShimmerBox(height: 12),
                  const SizedBox(height: AppSpacing.xs),
                  const ShimmerBox(width: 220, height: 12),
                  const SizedBox(height: AppSpacing.sm),
                  const ShimmerBox(width: 90, height: 20, borderRadius: 10),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const ShimmerBox(width: 40, height: 40, borderRadius: 12),
          ],
        ),
      ),
    );
  }
}
