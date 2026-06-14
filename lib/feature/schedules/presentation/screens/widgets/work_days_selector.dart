import 'package:consultify/config/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WorkDaysSelector extends StatelessWidget {
  final List<int> selectedDays;
  final ValueChanged<List<int>> onChanged;
  final bool enabled;

  const WorkDaysSelector({
    super.key,
    required this.selectedDays,
    required this.onChanged,
    this.enabled = true,
  });

  static const _weekdays = [
    (0, 'Dom'),
    (1, 'Lun'),
    (2, 'Mar'),
    (3, 'Mié'),
    (4, 'Jue'),
    (5, 'Vie'),
    (6, 'Sáb'),
  ];

  void _toggleDay(int day) {
    if (!enabled) return;

    final updated = List<int>.from(selectedDays);
    if (updated.contains(day)) {
      updated.remove(day);
    } else {
      updated.add(day);
      updated.sort();
    }
    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              FontAwesomeIcons.calendarCheck.data,
              size: 14,
              color: AppColors.secondary,
            ),
            const SizedBox(width: 8),
            Text(
              'Días laborales',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary.withValues(alpha: 0.75),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _weekdays.map((entry) {
            final (day, label) = entry;
            final isSelected = selectedDays.contains(day);

            return FilterChip(
              label: Text(label),
              selected: isSelected,
              onSelected: enabled ? (_) => _toggleDay(day) : null,
              selectedColor: AppColors.secondary.withValues(alpha: 0.25),
              checkmarkColor: AppColors.secondary,
              labelStyle: TextStyle(
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textPrimary.withValues(alpha: 0.65),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              side: BorderSide(
                color: isSelected
                    ? AppColors.secondary
                    : AppColors.textPrimary.withValues(alpha: 0.3),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
