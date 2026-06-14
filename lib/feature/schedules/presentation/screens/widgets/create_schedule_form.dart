import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CreateScheduleForm extends ConsumerStatefulWidget {
  final Doctor? doctor;

  const CreateScheduleForm({
    super.key,
    this.doctor,
  });

  @override
  ConsumerState<CreateScheduleForm> createState() => _CreateScheduleFormState();
}

class _CreateScheduleFormState extends ConsumerState<CreateScheduleForm> {
  final _formKey = GlobalKey<FormState>();

  Doctor? _selectedDoctor;
  int? _selectedDuration;
  List<int> _selectedWorkDays = [1, 2, 3, 4, 5];

  String? _morningStart;
  String? _morningEnd;
  String? _afternoonStart;
  String? _afternoonEnd;

  static const _durationOptions = [15, 20, 30, 45, 60];

  @override
  void initState() {
    super.initState();
    _selectedDoctor = widget.doctor;
    _selectedDuration = 30;
    _morningStart = '08:00';
    _morningEnd = '12:00';
    _afternoonStart = '14:00';
    _afternoonEnd = '18:00';
  }

  List<Doctor> get _activeDoctors {
    return ref
        .watch(doctorsProvider)
        .doctors
        .where((doctor) => doctor.isActive)
        .toList();
  }

  Future<void> _pickTime({
    required String? currentValue,
    required ValueChanged<String> onSelected,
  }) async {
    TimeOfDay initialTime = TimeOfDay.now();
    if (currentValue != null && currentValue.isNotEmpty) {
      final parts = currentValue.split(':');
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
      setState(() => onSelected(formatTimeOfDay(picked)));
    }
  }

  bool _isValidTimeRange(String? start, String? end) {
    if (start == null || end == null) return false;
    return _minutesFromTime(start) < _minutesFromTime(end);
  }

  int _minutesFromTime(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return 0;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return hour * 60 + minute;
  }

  Future<void> _onSubmit() async {
    if (_selectedDoctor == null) {
      AppSnackBar.error(context, 'Seleccione un profesional');
      return;
    }
    if (_selectedDuration == null) {
      AppSnackBar.error(context, 'Seleccione la duración de la cita');
      return;
    }
    if (_selectedWorkDays.isEmpty) {
      AppSnackBar.error(context, 'Seleccione al menos un día laboral');
      return;
    }
    if (_morningStart == null || _morningEnd == null) {
      AppSnackBar.error(context, 'Configure el horario de la mañana');
      return;
    }
    if (_afternoonStart == null || _afternoonEnd == null) {
      AppSnackBar.error(context, 'Configure el horario de la tarde');
      return;
    }
    if (!_isValidTimeRange(_morningStart, _morningEnd)) {
      AppSnackBar.error(
        context,
        'La hora de fin de la mañana debe ser posterior al inicio',
      );
      return;
    }
    if (!_isValidTimeRange(_afternoonStart, _afternoonEnd)) {
      AppSnackBar.error(
        context,
        'La hora de fin de la tarde debe ser posterior al inicio',
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final isLoading = ref.read(schedulesProvider).isLoading;
    if (isLoading) return;

    final schedule = ScheduleCreate(
      professionalId: _selectedDoctor!.id,
      appointmentDurationMinutes: _selectedDuration!,
      workingHours: WorkingHours(
        morning: Afternoon(start: _morningStart!, end: _morningEnd!),
        afternoon: Afternoon(start: _afternoonStart!, end: _afternoonEnd!),
      ),
      workDays: _selectedWorkDays,
    );

    final success = await ref
        .read(schedulesProvider.notifier)
        .createDoctorSchedule(schedule);

    if (!mounted) return;

    if (success) {
      AppSnackBar.success(context, 'Horario configurado correctamente');
      context.pop();
      return;
    }

    final errorMessage = ref.read(schedulesProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    const fieldGap = 20.0;
    const selectWidth = 300.0;
    final isLoading = ref.watch(schedulesProvider).isLoading;
    final isLoadingDoctors = ref.watch(doctorsProvider).isLoading;
    final isDisabled = isLoading || isLoadingDoctors;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Select<Doctor>(
            onTap: (doctor) => setState(() => _selectedDoctor = doctor),
            defaultValue: 'Seleccione profesional',
            items: _activeDoctors,
            selected: _selectedDoctor,
            getTextBySelected: (doctor) => doctor.name,
            isActive: !isDisabled,
            disabledMessage: 'Cargando profesionales...',
            width: selectWidth,
            areTheSame: (a, b) => a.id == b?.id,
          ),
          const SizedBox(height: fieldGap),
          Select<int>(
            onTap: (duration) => setState(() => _selectedDuration = duration),
            defaultValue: 'Duración de cita',
            items: _durationOptions,
            selected: _selectedDuration,
            getTextBySelected: (duration) => '$duration minutos',
            isActive: !isDisabled,
            disabledMessage: 'Cargando...',
            width: selectWidth,
            areTheSame: (a, b) => a == b,
            labelText: 'Duración de cita',
          ),
          const SizedBox(height: fieldGap),
          WorkDaysSelector(
            selectedDays: _selectedWorkDays,
            enabled: !isDisabled,
            onChanged: (days) => setState(() => _selectedWorkDays = days),
          ),
          const SizedBox(height: fieldGap),
          ScheduleTimeBlock(
            title: 'Jornada mañana',
            icon: FontAwesomeIcons.sun.data,
            startTime: _morningStart,
            endTime: _morningEnd,
            onPickStart: isDisabled
                ? null
                : () => _pickTime(
                      currentValue: _morningStart,
                      onSelected: (value) => setState(() => _morningStart = value),
                    ),
            onPickEnd: isDisabled
                ? null
                : () => _pickTime(
                      currentValue: _morningEnd,
                      onSelected: (value) => setState(() => _morningEnd = value),
                    ),
          ),
          const SizedBox(height: fieldGap),
          ScheduleTimeBlock(
            title: 'Jornada tarde',
            icon: FontAwesomeIcons.moon.data,
            startTime: _afternoonStart,
            endTime: _afternoonEnd,
            onPickStart: isDisabled
                ? null
                : () => _pickTime(
                      currentValue: _afternoonStart,
                      onSelected: (value) =>
                          setState(() => _afternoonStart = value),
                    ),
            onPickEnd: isDisabled
                ? null
                : () => _pickTime(
                      currentValue: _afternoonEnd,
                      onSelected: (value) =>
                          setState(() => _afternoonEnd = value),
                    ),
          ),
          const SizedBox(height: 32),
          CustomFilledButton(
            text: isLoading ? 'Guardando...' : 'Guardar horario',
            buttonColor: AppColors.primaryButton,
            width: 250,
            height: 50,
            textSize: 18,
            onPressed: isDisabled ? null : _onSubmit,
          ),
        ],
      ),
    );
  }
}
