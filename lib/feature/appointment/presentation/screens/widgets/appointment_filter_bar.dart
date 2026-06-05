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
    final size = MediaQuery.of(context).size;
    final hasDateSelected = filter.selectedDate != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filtrar citas',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: size.width * 0.042,
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Row(
          children: [
            Text(
              'Año',
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
                fontSize: size.width * 0.035,
              ),
            ),
            SizedBox(width: size.width * 0.03),
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
              width: size.width * 0.32,
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
                  size: 18,
                  color: AppColors.secondaryButton,
                ),
                label: Text(
                  'Limpiar día',
                  style: TextStyle(
                    color: AppColors.secondaryButton,
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.032,
                  ),
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: size.height * 0.02),
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
