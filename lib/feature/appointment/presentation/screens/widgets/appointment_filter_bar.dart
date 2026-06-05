import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class AppointmentFilterBar extends StatelessWidget {
  final AppointmentFilter filter;
  final ValueChanged<AppointmentFilter> onFilterChanged;

  const AppointmentFilterBar({
    super.key,
    required this.filter,
    required this.onFilterChanged,
  });

  List<int> get _yearOptions {
    final currentYear = DateTime.now().year;
    return [currentYear - 1, currentYear, currentYear + 1];
  }

  @override
  Widget build(BuildContext context) {
    final hasDateSelected = filter.selectedDate != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filtrar citas',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Text(
              'Año',
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 10),
            Select<int>(
              onTap: (value) {
                if (value == null) return;

                DateTime? updatedDate;
                if (filter.selectedDate != null) {
                  updatedDate = DateTime(
                    value,
                    filter.selectedDate!.month,
                    filter.selectedDate!.day,
                  );
                }

                onFilterChanged(
                  filter.copyWith(
                    year: value,
                    selectedDate: updatedDate,
                  ),
                );
              },
              defaultValue: 'Seleccione año',
              items: _yearOptions,
              selected: filter.year,
              getTextBySelected: (year) => year.toString(),
              isActive: true,
              disabledMessage: '',
              width: 150,
              areTheSame: (a, b) => a == b,
            ),
            if (hasDateSelected) ...[
              const Spacer(),
              TextButton.icon(
                onPressed: () => onFilterChanged(
                  filter.copyWith(clearSelectedDate: true),
                ),
                icon: Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: AppColors.primaryButton,
                ),
                label: Text(
                  'Limpiar día',
                  style: TextStyle(
                    color: AppColors.primaryButton,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 20),
        AppCalendar(
          year: filter.year,
          selectedDay: filter.selectedDay,
          selectedMonth: filter.selectedMonth,
          onDateSelected: (day, month) {
            if (day == null || month == null) {
              onFilterChanged(filter.copyWith(clearSelectedDate: true));
              return;
            }

            onFilterChanged(
              filter.copyWith(
                selectedDate: DateTime(filter.year, month, day),
              ),
            );
          },
        ),
      ],
    );
  }
}
