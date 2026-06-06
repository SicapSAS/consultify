import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateAppointmentForm extends ConsumerStatefulWidget {
  const CreateAppointmentForm({super.key});

  @override
  ConsumerState<CreateAppointmentForm> createState() => _CreateAppointmentFormState();
}

class _CreateAppointmentFormState extends ConsumerState<CreateAppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  Patient? _selectedPatient;
  Doctor? _selectedDoctor;
  DateTime? _selectedDate;
  String? _selectedTime;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  List<Patient> get _activePatients {
    return ref
        .watch(patientProvider)
        .patients
        .where((patient) => patient.isActive)
        .toList();
  }

  List<Doctor> get _activeDoctors {
    return ref
        .watch(doctorsProvider)
        .doctors
        .where((doctor) => doctor.isActive)
        .toList();
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
    TimeOfDay? initialTime = TimeOfDay.now();
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

  String? _dateLabel() {
    if (_selectedDate == null) return null;
    return DateFormat('dd/MM/yyyy').format(_selectedDate!);
  }

  Future<void> _onSubmit() async {
    if (_selectedPatient == null) {
      AppSnackBar.error(context, 'Seleccione un paciente');
      return;
    }
    if (_selectedDoctor == null) {
      AppSnackBar.error(context, 'Seleccione un profesional');
      return;
    }
    if (_selectedDate == null) {
      AppSnackBar.error(context, 'Seleccione la fecha de la cita');
      return;
    }
    if (_selectedTime == null || _selectedTime!.isEmpty) {
      AppSnackBar.error(context, 'Seleccione la hora de la cita');
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final appointment = AppointmentCreate(
      patientId: _selectedPatient!.id,
      professionalId: _selectedDoctor!.id,
      date: _selectedDate!,
      time: _selectedTime!,
      notes: _notesController.text.trim(),
    );

    final success = await ref
        .read(appointmentProvider.notifier)
        .createAppointment(appointment);

    if (!mounted) return;

    if (success) {
      AppSnackBar.success(context, 'Cita agendada correctamente');
      context.pop();
      return;
    }

    final errorMessage = ref.read(appointmentProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    const fieldGap = 20.0;
    const selectWidth = 300.0;
    final isPosting = ref.watch(appointmentProvider).isPosting;
    final isLoadingCatalogs =
        ref.watch(patientProvider).isLoading ||
        ref.watch(doctorsProvider).isLoading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Select<Patient>(
            onTap: (patient) => setState(() => _selectedPatient = patient),
            defaultValue: 'Seleccione paciente',
            items: _activePatients,
            selected: _selectedPatient,
            getTextBySelected: (patient) => patient.name,
            isActive: !isLoadingCatalogs,
            disabledMessage: 'Cargando pacientes...',
            width: selectWidth,
            areTheSame: (a, b) => a.id == b?.id,
            addNew: () => context.push('/create-patient-screen'),
          ),
          SizedBox(height: fieldGap),
          Select<Doctor>(
            onTap: (doctor) => setState(() => _selectedDoctor = doctor),
            defaultValue: 'Seleccione profesional',
            items: _activeDoctors,
            selected: _selectedDoctor,
            getTextBySelected: (doctor) => doctor.name,
            isActive: !isLoadingCatalogs,
            disabledMessage: 'Cargando profesionales...',
            width: selectWidth,
            areTheSame: (a, b) => a.id == b?.id,
          ),
          SizedBox(height: fieldGap),
          Row(
            children: [
              Expanded(
                child: AppointmentPickerField(
                  label: _dateLabel() ?? 'Fecha',
                  icon: FontAwesomeIcons.calendarDays.data,
                  onTap: isPosting ? null : _pickDate,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: AppointmentPickerField(
                  label: _selectedTime ?? 'Hora',
                  icon: FontAwesomeIcons.clock.data,
                  onTap: isPosting ? null : _pickTime,
                ),
              ),
            ],
          ),
          SizedBox(height: fieldGap),
          CustomMultiLineFormField(
            controller: _notesController,
            hintText: 'Notas (opcional)',
          ),
          SizedBox(height: 40),
          CustomFilledButton(
            text: isPosting ? 'Agendando...' : 'Agendar cita',
            buttonColor: AppColors.primaryButton,
            width: 250,
            height: 50,
            textSize: 18,
            onPressed: isPosting || isLoadingCatalogs ? null : _onSubmit,
          ),
        ],
      ),
    );
  }
}
