import 'package:consultify/config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _TimePickerStep { hour, minute }

/// Selector de hora reutilizable. El usuario elige la hora y luego los minutos;
/// al tocar un minuto se confirma de inmediato, sin botón "Aceptar".
class AppTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final int startHour;
  final int endHour;
  final int minuteInterval;
  final ValueChanged<TimeOfDay> onTimeSelected;
  final VoidCallback? onCancel;
  final String title;

  const AppTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeSelected,
    this.onCancel,
    this.title = 'Seleccionar hora',
    this.startHour = 7,
    this.endHour = 20,
    this.minuteInterval = 15,
  }) : assert(startHour >= 0 && startHour <= 23),
       assert(endHour >= 0 && endHour <= 23),
       assert(endHour >= startHour),
       assert(minuteInterval > 0 && 60 % minuteInterval == 0);

  @override
  State<AppTimePicker> createState() => _AppTimePickerState();
}

class _AppTimePickerState extends State<AppTimePicker> {
  late int _selectedHour;
  late int _selectedMinute;
  late _TimePickerStep _step;

  @override
  void initState() {
    super.initState();
    _selectedHour = _clampHour(widget.initialTime.hour);
    _selectedMinute = _normalizeMinute(widget.initialTime.minute);
    _step = _TimePickerStep.hour;
  }

  int _clampHour(int hour) {
    if (hour < widget.startHour) return widget.startHour;
    if (hour > widget.endHour) return widget.endHour;
    return hour;
  }

  int _normalizeMinute(int minute) {
    final options = _minuteOptions;
    var closest = options.first;
    var smallestDiff = (minute - closest).abs();

    for (final option in options) {
      final diff = (minute - option).abs();
      if (diff < smallestDiff) {
        smallestDiff = diff;
        closest = option;
      }
    }

    return closest;
  }

  List<int> get _hourOptions {
    return List.generate(
      widget.endHour - widget.startHour + 1,
      (index) => widget.startHour + index,
    );
  }

  List<int> get _minuteOptions {
    return List.generate(
      60 ~/ widget.minuteInterval,
      (index) => index * widget.minuteInterval,
    );
  }

  String _formatHour(int hour) => hour.toString().padLeft(2, '0');

  String _formatMinute(int minute) => minute.toString().padLeft(2, '0');

  void _selectHour(int hour) {
    setState(() {
      _selectedHour = hour;
      _step = _TimePickerStep.minute;
    });
  }

  void _selectMinute(int minute) {
    setState(() => _selectedMinute = minute);
    widget.onTimeSelected(TimeOfDay(hour: _selectedHour, minute: minute));
  }

  void _goToHourStep() {
    setState(() => _step = _TimePickerStep.hour);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            SizedBox(height: size.height * 0.012),
            _TimeDisplay(
              hour: _selectedHour,
              minute: _selectedMinute,
              activeStep: _step,
              onHourTap: _goToHourStep,
              onMinuteTap: () {
                if (_step == _TimePickerStep.hour) {
                  setState(() => _step = _TimePickerStep.minute);
                }
              },
            ),
            SizedBox(height: size.height * 0.018),
            Row(
              children: [
                if (_step == _TimePickerStep.minute)
                  IconButton(
                    onPressed: _goToHourStep,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                if (_step == _TimePickerStep.minute)
                  SizedBox(width: size.width * 0.02),
                Expanded(
                  child: Text(
                    _step == _TimePickerStep.hour
                        ? 'Toque la hora'
                        : 'Toque los minutos',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.012),
            if (_step == _TimePickerStep.hour)
              _OptionGrid(
                options: _hourOptions,
                selected: _selectedHour,
                labelBuilder: _formatHour,
                onSelected: _selectHour,
              )
            else
              _OptionGrid(
                options: _minuteOptions,
                selected: _selectedMinute,
                labelBuilder: _formatMinute,
                onSelected: _selectMinute,
              ),
            if (widget.onCancel != null) ...[
              SizedBox(height: size.height * 0.008),
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

class _TimeDisplay extends StatelessWidget {
  final int hour;
  final int minute;
  final _TimePickerStep activeStep;
  final VoidCallback onHourTap;
  final VoidCallback onMinuteTap;

  const _TimeDisplay({
    required this.hour,
    required this.minute,
    required this.activeStep,
    required this.onHourTap,
    required this.onMinuteTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hourSelected = activeStep == _TimePickerStep.hour;
    final minuteSelected = activeStep == _TimePickerStep.minute;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TimeSegment(
          value: hour.toString().padLeft(2, '0'),
          isActive: hourSelected,
          onTap: onHourTap,
          fontSize: size.width * 0.11,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
          child: Text(
            ':',
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: size.width * 0.09,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _TimeSegment(
          value: minute.toString().padLeft(2, '0'),
          isActive: minuteSelected,
          onTap: onMinuteTap,
          fontSize: size.width * 0.11,
        ),
      ],
    );
  }
}

class _TimeSegment extends StatelessWidget {
  final String value;
  final bool isActive;
  final VoidCallback onTap;
  final double fontSize;

  const _TimeSegment({
    required this.value,
    required this.isActive,
    required this.onTap,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? AppColors.secondary : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            value,
            style: TextStyle(
              color: isActive
                  ? AppColors.secondaryBackground
                  : AppColors.secondary,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionGrid extends StatelessWidget {
  final List<int> options;
  final int selected;
  final String Function(int) labelBuilder;
  final ValueChanged<int> onSelected;

  const _OptionGrid({
    required this.options,
    required this.selected,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: options.length <= 4 ? options.length : 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        final value = options[index];
        final isSelected = value == selected;

        return Material(
          color: isSelected ? AppColors.secondary : AppColors.tertiaryBackground,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () => onSelected(value),
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Text(
                labelBuilder(value),
                style: TextStyle(
                  color: isSelected
                      ? AppColors.secondaryBackground
                      : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.042,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Muestra el selector de hora en un diálogo y devuelve la hora elegida.
Future<TimeOfDay?> showAppTimePicker(
  BuildContext context, {
  TimeOfDay? initialTime,
  int startHour = 7,
  int endHour = 20,
  int minuteInterval = 15,
  String title = 'Seleccionar hora',
}) {
  final resolvedInitialTime = initialTime ?? TimeOfDay.now();

  return showDialog<TimeOfDay>(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: AppTimePicker(
          title: title,
          initialTime: resolvedInitialTime,
          startHour: startHour,
          endHour: endHour,
          minuteInterval: minuteInterval,
          onCancel: () => Navigator.of(dialogContext).pop(),
          onTimeSelected: (time) => Navigator.of(dialogContext).pop(time),
        ),
      );
    },
  );
}

/// Convierte [TimeOfDay] al formato `HH:mm` esperado por la API.
String formatTimeOfDay(TimeOfDay time) {
  return DateFormat('HH:mm').format(
    DateTime(2000, 1, 1, time.hour, time.minute),
  );
}
