import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Calendario reutilizable alineado con la paleta de Consultify.
class AppCalendar extends StatefulWidget {
  final int year;
  final int? selectedDay;
  final int? selectedMonth;
  final void Function(int? day, int? month)? onDateSelected;

  const AppCalendar({
    super.key,
    required this.year,
    this.selectedDay,
    this.selectedMonth,
    this.onDateSelected,
  });

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  static const _weekdayLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  static const _nonWorkingBackground = Color(0xFFFDECEC);
  static const _nonWorkingText = Color(0xFFB71C1C);
  static const _nonWorkingHeaderText = Color(0xFFD32F2F);
  static const _monthNames = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];

  late int _displayedMonth;

  @override
  void initState() {
    super.initState();
    _displayedMonth = _initialMonth();
  }

  @override
  void didUpdateWidget(covariant AppCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.year != widget.year) {
      _displayedMonth = _initialMonth();
    } else if (widget.selectedMonth != null &&
        widget.selectedMonth != _displayedMonth) {
      _displayedMonth = widget.selectedMonth!;
    }
  }

  int _initialMonth() {
    if (widget.selectedMonth != null) return widget.selectedMonth!;
    final now = DateTime.now();
    if (widget.year == now.year) return now.month;
    return 1;
  }

  void _changeMonth(int delta) {
    setState(() {
      _displayedMonth += delta;
      if (_displayedMonth > 12) {
        _displayedMonth = 1;
      } else if (_displayedMonth < 1) {
        _displayedMonth = 12;
      }
    });
  }

  bool _isSameDay(int day) {
    return widget.selectedDay == day && widget.selectedMonth == _displayedMonth;
  }

  bool _isToday(int day) {
    final now = DateTime.now();
    return widget.year == now.year &&
        _displayedMonth == now.month &&
        day == now.day;
  }

  bool _isNonWorkingDay(int day) {
    final date = DateTime(widget.year, _displayedMonth, day);
    return ColombiaHolidays.isNonWorkingDay(date);
  }

  @override
  Widget build(BuildContext context) {
    final radius = 12.0;
    final daysInMonth = DateUtils.getDaysInMonth(widget.year, _displayedMonth);
    final firstWeekday = DateTime(widget.year, _displayedMonth, 1).weekday;
    final leadingEmptyCells = firstWeekday - 1;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: AppColors.textPrimary.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CalendarHeader(
            title: '${_monthNames[_displayedMonth - 1]} ${widget.year}',
            onPrevious: () => _changeMonth(-1),
            onNext: () => _changeMonth(1),
          ),
          SizedBox(height: 12),
          _WeekdayRow(
            labels: _weekdayLabels,
            sundayHeaderColor: _nonWorkingHeaderText,
          ),
          SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leadingEmptyCells + daysInMonth,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              if (index < leadingEmptyCells) {
                return const SizedBox.shrink();
              }

              final day = index - leadingEmptyCells + 1;
              final isSelected = _isSameDay(day);
              final isToday = _isToday(day);
              final isNonWorkingDay = _isNonWorkingDay(day);

              return _DayCell(
                day: day,
                isSelected: isSelected,
                isToday: isToday,
                isNonWorkingDay: isNonWorkingDay,
                nonWorkingBackground: _nonWorkingBackground,
                nonWorkingText: _nonWorkingText,
                onTap: () {
                  if (_isSameDay(day)) {
                    widget.onDateSelected?.call(null, null);
                    return;
                  }
                  widget.onDateSelected?.call(day, _displayedMonth);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _CalendarHeader({
    required this.title,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        _CalendarNavButton(
          icon: Icons.chevron_left_rounded,
          onTap: onPrevious,
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        _CalendarNavButton(
          icon: Icons.chevron_right_rounded,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _CalendarNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CalendarNavButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.tertiaryBackground,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            icon,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _WeekdayRow extends StatelessWidget {
  final List<String> labels;
  final Color sundayHeaderColor;

  const _WeekdayRow({
    required this.labels,
    required this.sundayHeaderColor,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: List.generate(labels.length, (index) {
        final isSundayColumn = index == labels.length - 1;

        return Expanded(
          child: Center(
            child: Text(
              labels[index],
              style: TextStyle(
                color: isSundayColumn
                    ? sundayHeaderColor
                    : AppColors.textPrimary.withValues(alpha: 0.55),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final bool isSelected;
  final bool isToday;
  final bool isNonWorkingDay;
  final Color nonWorkingBackground;
  final Color nonWorkingText;
  final VoidCallback onTap;

  const _DayCell({
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.isNonWorkingDay,
    required this.nonWorkingBackground,
    required this.nonWorkingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.transparent;
    Color textColor = AppColors.textPrimary;
    Border? border;

    if (isSelected) {
      backgroundColor = AppColors.secondaryButton;
      textColor = AppColors.secondaryBackground;
    } else if (isToday) {
      border = Border.all(
        color: AppColors.infoBackground,
        width: 1.5,
      );
      backgroundColor = isNonWorkingDay
          ? nonWorkingBackground
          : AppColors.tertiaryBackground;
      textColor = isNonWorkingDay ? nonWorkingText : AppColors.textPrimary;
    } else if (isNonWorkingDay) {
      backgroundColor = nonWorkingBackground;
      textColor = nonWorkingText;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: border,
          ),
          child: Text(
            '$day',
            style: TextStyle(
              color: textColor,
              fontWeight: isSelected || isToday ? FontWeight.w700 : FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
