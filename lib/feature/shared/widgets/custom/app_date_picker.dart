import 'package:consultify/config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Calendario modal reutilizable. Al tocar un día habilitado se confirma
/// la selección de inmediato, sin botón "Aceptar".
class AppDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback? onCancel;
  final String title;
  final bool Function(DateTime date)? selectableDayPredicate;

  const AppDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    this.onCancel,
    this.title = 'Seleccionar fecha',
    this.selectableDayPredicate,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  static const _weekdayLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  late DateTime _selectedDate;
  late DateTime _focusedMonth;
  late DateTime _firstDate;
  late DateTime _lastDate;

  @override
  void initState() {
    super.initState();
    _firstDate = _dateOnly(widget.firstDate);
    _lastDate = _dateOnly(widget.lastDate);
    _selectedDate = _clampDate(_dateOnly(widget.initialDate));
    _focusedMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  DateTime _clampDate(DateTime date) {
    if (date.isBefore(_firstDate)) return _firstDate;
    if (date.isAfter(_lastDate)) return _lastDate;
    return date;
  }

  bool _isDateSelectable(DateTime date) {
    final normalized = _dateOnly(date);
    if (normalized.isBefore(_firstDate) || normalized.isAfter(_lastDate)) {
      return false;
    }
    return widget.selectableDayPredicate?.call(normalized) ?? true;
  }

  bool get _canGoToPreviousMonth {
    final previousMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    final lastDayOfPreviousMonth = DateTime(
      previousMonth.year,
      previousMonth.month + 1,
      0,
    );
    return !lastDayOfPreviousMonth.isBefore(_firstDate);
  }

  bool get _canGoToNextMonth {
    final nextMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    return !nextMonth.isAfter(_lastDate);
  }

  void _goToPreviousMonth() {
    if (!_canGoToPreviousMonth) return;
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _goToNextMonth() {
    if (!_canGoToNextMonth) return;
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  void _onDayTap(int day) {
    final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
    if (!_isDateSelectable(date)) return;

    setState(() => _selectedDate = date);
    widget.onDateSelected(date);
  }

  String _formatSelectedDate() {
    return DateFormat('EEE, d MMM', 'es').format(_selectedDate);
  }

  String _formatMonthTitle() {
    final formatted = DateFormat('MMMM', 'es').format(_focusedMonth);
    return '${formatted[0].toUpperCase()}${formatted.substring(1)} de ${_focusedMonth.year}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final daysInMonth =
        DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final firstWeekday =
        DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday;
    final leadingEmptyCells = firstWeekday - 1;

    return Material(
      color: AppColors.secondaryBackground,
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.05,
          size.height * 0.025,
          size.width * 0.05,
          size.height * 0.02,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.65),
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height * 0.008),
            Text(
              _formatSelectedDate(),
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: size.width * 0.075,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _formatMonthTitle(),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.042,
                    ),
                  ),
                ),
                _MonthNavButton(
                  icon: Icons.chevron_left_rounded,
                  enabled: _canGoToPreviousMonth,
                  onTap: _goToPreviousMonth,
                ),
                SizedBox(width: size.width * 0.01),
                _MonthNavButton(
                  icon: Icons.chevron_right_rounded,
                  enabled: _canGoToNextMonth,
                  onTap: _goToNextMonth,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.015),
            _WeekdayRow(labels: _weekdayLabels),
            SizedBox(height: size.height * 0.01),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: leadingEmptyCells + daysInMonth,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                if (index < leadingEmptyCells) {
                  return const SizedBox.shrink();
                }

                final day = index - leadingEmptyCells + 1;
                final date =
                    DateTime(_focusedMonth.year, _focusedMonth.month, day);
                final isSelected = _dateOnly(date) == _selectedDate;
                final isSelectable = _isDateSelectable(date);
                final isToday = _dateOnly(date) == _dateOnly(DateTime.now());

                return _DatePickerDayCell(
                  day: day,
                  isSelected: isSelected,
                  isToday: isToday,
                  isSelectable: isSelectable,
                  onTap: () => _onDayTap(day),
                );
              },
            ),
            if (widget.onCancel != null) ...[
              SizedBox(height: size.height * 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: widget.onCancel,
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.038,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MonthNavButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _MonthNavButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            color: enabled
                ? AppColors.textPrimary
                : AppColors.textPrimary.withValues(alpha: 0.25),
            size: 28,
          ),
        ),
      ),
    );
  }
}

class _WeekdayRow extends StatelessWidget {
  final List<String> labels;

  const _WeekdayRow({required this.labels});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: labels.map((label) {
        return Expanded(
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.55),
                fontWeight: FontWeight.w600,
                fontSize: size.width * 0.032,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _DatePickerDayCell extends StatelessWidget {
  final int day;
  final bool isSelected;
  final bool isToday;
  final bool isSelectable;
  final VoidCallback onTap;

  const _DatePickerDayCell({
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.isSelectable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Color backgroundColor = Colors.transparent;
    Color textColor = AppColors.textPrimary;
    FontWeight fontWeight = FontWeight.w500;

    if (isSelected) {
      backgroundColor = AppColors.secondary;
      textColor = AppColors.secondaryBackground;
      fontWeight = FontWeight.w700;
    } else if (!isSelectable) {
      textColor = AppColors.textPrimary.withValues(alpha: 0.28);
    } else if (isToday) {
      backgroundColor = AppColors.tertiaryBackground;
      fontWeight = FontWeight.w700;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isSelectable ? onTap : null,
        customBorder: const CircleBorder(),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$day',
            style: TextStyle(
              color: textColor,
              fontWeight: fontWeight,
              fontSize: size.width * 0.038,
            ),
          ),
        ),
      ),
    );
  }
}

/// Muestra el calendario en un diálogo y devuelve la fecha elegida al tocar un día.
Future<DateTime?> showAppDatePicker(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  String title = 'Seleccionar fecha',
  bool Function(DateTime date)? selectableDayPredicate,
}) {
  final now = DateTime.now();
  final resolvedFirstDate = firstDate ?? DateTime(now.year, now.month, now.day);
  final resolvedLastDate =
      lastDate ?? DateTime(now.year + 1, now.month, now.day);
  final resolvedInitialDate = initialDate ?? resolvedFirstDate;

  return showDialog<DateTime>(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: AppDatePicker(
          title: title,
          initialDate: resolvedInitialDate,
          firstDate: resolvedFirstDate,
          lastDate: resolvedLastDate,
          selectableDayPredicate: selectableDayPredicate,
          onCancel: () => Navigator.of(dialogContext).pop(),
          onDateSelected: (date) => Navigator.of(dialogContext).pop(date),
        ),
      );
    },
  );
}
