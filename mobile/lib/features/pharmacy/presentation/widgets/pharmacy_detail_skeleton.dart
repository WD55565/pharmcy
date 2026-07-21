import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/shimmer_box.dart';

/// Placeholder shaped like the loaded details screen body, shown while the
/// pharmacy is being fetched.
class PharmacyDetailSkeleton extends StatelessWidget {
  const PharmacyDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerBox(width: 220, height: 28),
          const SizedBox(height: AppSpacing.xl),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: List.generate(4, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: index == 3 ? 0 : AppSpacing.lg),
                    child: Row(
                      children: [
                        const ShimmerBox(width: 24, height: 24, borderRadius: 6),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ShimmerBox(width: 80, height: 10),
                              const SizedBox(height: AppSpacing.xs),
                              const ShimmerBox(height: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(child: ShimmerBox(height: 44, borderRadius: 12)),
              SizedBox(width: AppSpacing.md),
              Expanded(child: ShimmerBox(height: 44, borderRadius: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
