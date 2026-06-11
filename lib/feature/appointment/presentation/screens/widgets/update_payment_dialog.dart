import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class PaymentMethodOption {
  final String value;
  final String label;

  const PaymentMethodOption({
    required this.value,
    required this.label,
  });
}

class UpdatePaymentData {
  final String paymentMethod;
  final int amount;

  const UpdatePaymentData({
    required this.paymentMethod,
    required this.amount,
  });

  static const paymentStatus = 'COMPLETED';
}

/// Diálogo para actualizar el pago de una cita.
class UpdatePaymentDialog extends StatefulWidget {
  final AppointmentList appointment;

  const UpdatePaymentDialog({
    super.key,
    required this.appointment,
  });

  static Future<UpdatePaymentData?> show(
    BuildContext context,
    AppointmentList appointment,
  ) {
    return showDialog<UpdatePaymentData>(
      context: context,
      builder: (ctx) => UpdatePaymentDialog(appointment: appointment),
    );
  }

  @override
  State<UpdatePaymentDialog> createState() => _UpdatePaymentDialogState();
}

class _UpdatePaymentDialogState extends State<UpdatePaymentDialog> {
  static const _paymentMethods = [
    PaymentMethodOption(value: 'CASH', label: 'Efectivo'),
    PaymentMethodOption(value: 'TRANSFER', label: 'Transferencia'),
  ];

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  PaymentMethodOption? _selectedMethod;

  @override
  void initState() {
    super.initState();
    if (widget.appointment.amount > 0) {
      _amountController.text =
          AppointmentDetailHelpers.formatAmountInput(widget.appointment.amount);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_selectedMethod == null) {
      AppSnackBar.error(context, 'Seleccione el método de pago');
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) return;

    final amount = AppointmentDetailHelpers.parseAmountInput(
      _amountController.text,
    );

    if (amount == null || amount <= 0) {
      AppSnackBar.error(context, 'Ingrese un valor válido');
      return;
    }

    Navigator.of(context).pop(
      UpdatePaymentData(
        paymentMethod: _selectedMethod!.value,
        amount: amount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialogWidth = MediaQuery.sizeOf(context).width * 0.82;
    final currentPaymentLabel = AppointmentDetailHelpers.paymentLabel(
      widget.appointment.paymentStatus,
    );

    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Text(
        'Actualizar pago',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: dialogWidth,
        child: Form(
          key: _formKey,
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
                const SizedBox(height: 16),
                Text(
                  'Estado de pago',
                  style: TextStyle(
                    color: AppColors.textPrimary.withValues(alpha: 0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warningBackground.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.warningBackground.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    currentPaymentLabel,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Al actualizar, el pago quedará como completado.',
                  style: TextStyle(
                    color: AppColors.textPrimary.withValues(alpha: 0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Método de pago',
                  style: TextStyle(
                    color: AppColors.textPrimary.withValues(alpha: 0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Select<PaymentMethodOption>(
                  onTap: (method) => setState(() => _selectedMethod = method),
                  defaultValue: 'Seleccione',
                  items: _paymentMethods,
                  selected: _selectedMethod,
                  getTextBySelected: (method) => method.label,
                  isActive: true,
                  disabledMessage: '',
                  width: dialogWidth,
                  areTheSame: (a, b) => a.value == b?.value,
                ),
                const SizedBox(height: 16),
                Text(
                  'Valor',
                  style: TextStyle(
                    color: AppColors.textPrimary.withValues(alpha: 0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: _amountController,
                  showLabel: false,
                  hint: 'Ingrese el valor',
                  keyboardType: TextInputType.number,
                  inputFormatters: [AmountInputFormatter()],
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: AppColors.secondary,
                    size: 18,
                  ),
                  validator: (value) {
                    final amount = AppointmentDetailHelpers.parseAmountInput(
                      value ?? '',
                    );
                    if (amount == null || amount <= 0) {
                      return 'Ingrese un valor válido';
                    }
                    return null;
                  },
                ),
              ],
            ),
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
              text: 'Actualizar',
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
