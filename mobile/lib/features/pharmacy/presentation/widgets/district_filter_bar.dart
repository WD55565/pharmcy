import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';

/// Horizontal, scrollable row of district choice chips, with a leading
/// "all districts" chip. Stateless — the caller owns the selection.
class DistrictFilterBar extends StatelessWidget {
  const DistrictFilterBar({
    required this.districts,
    required this.selectedDistrict,
    required this.onSelected,
    super.key,
  });

  final List<String> districts;
  final String? selectedDistrict;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: districts.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            final isAllSelected = selectedDistrict == null;
            return AnimatedScale(
              scale: isAllSelected ? 1.06 : 1.0,
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              child: ChoiceChip(
                label: Text(l10n.districtAll),
                selected: isAllSelected,
                onSelected: (_) => onSelected(null),
              ),
            );
          }

          final district = districts[index - 1];
          final isSelected = district == selectedDistrict;
          return AnimatedScale(
            scale: isSelected ? 1.06 : 1.0,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            child: ChoiceChip(
              label: Text(district),
              selected: isSelected,
              onSelected: (_) => onSelected(isSelected ? null : district),
            ),
          );
        },
      ),
    );
  }
}
