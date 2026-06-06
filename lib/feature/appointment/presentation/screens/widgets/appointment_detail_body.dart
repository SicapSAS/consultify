import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class AppointmentDetailBody extends StatelessWidget {
  final AppointmentShow appointment;

  const AppointmentDetailBody({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        CustomBottomNavigationBar.scrollBottomPadding(context),
      ),
      children: [
        AppointmentDetailHeader(appointment: appointment),
        const SizedBox(height: 16),
        AppointmentDetailPatientSection(patient: appointment.patientId),
        const SizedBox(height: 16),
        AppointmentDetailProfessionalSection(
          professional: appointment.professionalId,
          durationMinutes: appointment.durationMinutes,
        ),
        const SizedBox(height: 16),
        AppointmentDetailPaymentSection(
          paymentStatus: appointment.paymentStatus,
          paymentMethod: appointment.paymentMethod,
          amount: appointment.amount,
        ),
        if (AppointmentDetailHelpers.hasText(appointment.notes)) ...[
          const SizedBox(height: 16),
          AppointmentDetailNotesSection(
            title: 'Notas',
            icon: AppointmentDetailHelpers.notesIcon,
            content: appointment.notes.trim(),
          ),
        ],
        if (AppointmentDetailHelpers.hasText(appointment.evolutionNotes)) ...[
          const SizedBox(height: 16),
          AppointmentDetailNotesSection(
            title: 'Notas de atención',
            icon: AppointmentDetailHelpers.evolutionIcon,
            content: appointment.evolutionNotes.trim(),
            highlighted: true,
          ),
        ],
      ],
    );
  }
}
