import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AppointmentDetailHelpers {
  static IconData get notesIcon => FontAwesomeIcons.noteSticky.data;
  static IconData get evolutionIcon => FontAwesomeIcons.fileMedical.data;

  static bool hasText(String? value) {
    if (value == null) return false;
    return value.trim().isNotEmpty;
  }

  static String formatSchedule(AppointmentShow appointment) {
    final day = appointment.date.day.toString().padLeft(2, '0');
    final month = appointment.date.month.toString().padLeft(2, '0');
    final year = appointment.date.year;

    final hasTime = appointment.time.trim().isNotEmpty;
    final hasEndTime = appointment.endTime.trim().isNotEmpty;

    if (hasTime && hasEndTime) {
      return '$day/$month/$year · ${appointment.time} - ${appointment.endTime}';
    }

    if (hasTime) {
      return '$day/$month/$year · ${appointment.time}';
    }

    return '$day/$month/$year';
  }

  static String statusLabel(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return 'Pendiente';
      case 'CONFIRMED':
        return 'Confirmada';
      case 'COMPLETED':
        return 'Completada';
      case 'ATTENDED':
        return 'Atendida';
      case 'NOT_ATTENDED':
        return 'No atendida';
      case 'CANCELLED':
        return 'Cancelada';
      default:
        return status;
    }
  }

  static Color statusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return AppColors.warningBackground;
      case 'CONFIRMED':
        return AppColors.infoBackground;
      case 'COMPLETED':
      case 'ATTENDED':
        return AppColors.successBackground;
      case 'NOT_ATTENDED':
      case 'CANCELLED':
        return AppColors.disabledBackground;
      default:
        return AppColors.textPrimary;
    }
  }

  static String paymentLabel(String paymentStatus) {
    switch (paymentStatus.toUpperCase()) {
      case 'PAID':
      case 'COMPLETED':
        return 'Pagado';
      case 'PENDING':
        return 'Pago pendiente';
      case 'NONE':
        return 'Sin pago';
      default:
        return paymentStatus;
    }
  }

  static String paymentMethodLabel(String paymentMethod) {
    switch (paymentMethod.toUpperCase()) {
      case 'CASH':
        return 'Efectivo';
      case 'CARD':
        return 'Tarjeta';
      case 'TRANSFER':
        return 'Transferencia';
      case 'NONE':
        return 'Sin método definido';
      default:
        return paymentMethod;
    }
  }

  static String formatAmount(int amount) {
    if (amount <= 0) return 'Sin monto registrado';
    return '\$ ${formatAmountInput(amount)}';
  }

  static String formatAmountInput(int amount) {
    return NumberFormat('#,###', 'es_CO').format(amount);
  }

  static int? parseAmountInput(String text) {
    final digits = text.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return null;
    return int.tryParse(digits);
  }
}
