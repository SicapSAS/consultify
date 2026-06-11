import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class RescheduleAppointmentData {
  final DateTime date;
  final String time;

  const RescheduleAppointmentData({
    required this.date,
    required this.time,
  });
}

/// Diálogo para reagendar una cita seleccionando nueva fecha y hora.
class RescheduleAppointmentDialog extends StatefulWidget {
  final AppointmentList appointment;

  const RescheduleAppointmentDialog({
    super.key,
    required this.appointment,
  });

  static Future<RescheduleAppointmentData?> show(
    BuildContext context,
    AppointmentList appointment,
  ) {
    return showDialog<RescheduleAppointmentData>(
      context: context,
      builder: (ctx) => RescheduleAppointmentDialog(appointment: appointment),
    );
  }

  @override
  State<RescheduleAppointmentDialog> createState() =>
      _RescheduleAppointmentDialogState();
}

class _RescheduleAppointmentDialogState extends State<RescheduleAppointmentDialog> {
  DateTime? _selectedDate;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.appointment.date;
    _selectedTime = widget.appointment.time.trim().isNotEmpty
        ? widget.appointment.time
        : null;
  }

  String _currentScheduleLabel() {
    final day = widget.appointment.date.day.toString().padLeft(2, '0');
    final month = widget.appointment.date.month.toString().padLeft(2, '0');
    final year = widget.appointment.date.year;
    final time = widget.appointment.time.trim();

    if (time.isNotEmpty) {
      return '$day/$month/$year · $time';
    }

    return '$day/$month/$year';
  }

  String? _dateLabel() {
    if (_selectedDate == null) return null;
    return DateFormat('dd/MM/yyyy').format(_selectedDate!);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showAppDatePicker(
      context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 1, now.month, now.day),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay initialTime = TimeOfDay.now();

    if (_selectedTime != null && _selectedTime!.isNotEmpty) {
      final parts = _selectedTime!.split(':');
      if (parts.length == 2) {
        final hour = int.tryParse(parts[0]);
        final minute = int.tryParse(parts[1]);
        if (hour != null && minute != null) {
          initialTime = TimeOfDay(hour: hour, minute: minute);
        }
      }
    }

    final picked = await showAppTimePicker(
      context,
      initialTime: initialTime,
    );

    if (picked != null) {
      setState(() => _selectedTime = formatTimeOfDay(picked));
    }
  }

  void _submit() {
    if (_selectedDate == null) {
      AppSnackBar.error(context, 'Seleccione la nueva fecha de la cita');
      return;
    }

    if (_selectedTime == null || _selectedTime!.trim().isEmpty) {
      AppSnackBar.error(context, 'Seleccione la nueva hora de la cita');
      return;
    }

    Navigator.of(context).pop(
      RescheduleAppointmentData(
        date: _selectedDate!,
        time: _selectedTime!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialogWidth = MediaQuery.sizeOf(context).width * 0.82;

    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Text(
        'Reagendar cita',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Paciente: ${widget.appointment.patientId.name}',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Cita actual: ${_currentScheduleLabel()}',
                style: TextStyle(
                  color: AppColors.textPrimary.withValues(alpha: 0.7),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Nueva fecha y hora',
                style: TextStyle(
                  color: AppColors.textPrimary.withValues(alpha: 0.7),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: AppointmentPickerField(
                      label: _dateLabel() ?? 'Fecha',
                      icon: FontAwesomeIcons.calendarDays.data,
                      onTap: _pickDate,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppointmentPickerField(
                      label: _selectedTime ?? 'Hora',
                      icon: FontAwesomeIcons.clock.data,
                      onTap: _pickTime,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomFilledButton(
              text: 'Volver',
              onPressed: () => Navigator.of(context).pop(),
              buttonColor: AppColors.disabledButton,
              textColor: AppColors.textSecondary,
            ),
            const SizedBox(width: 10),
            CustomFilledButton(
              text: 'Reagendar',
              onPressed: _submit,
              buttonColor: AppColors.secondaryButton,
              textColor: AppColors.secondaryBackground,
            ),
          ],
        ),
      ],
    );
  }
}
