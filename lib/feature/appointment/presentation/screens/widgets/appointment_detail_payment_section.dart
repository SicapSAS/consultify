import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentDetailPaymentSection extends StatelessWidget {
  final String paymentStatus;
  final String paymentMethod;
  final int amount;

  const AppointmentDetailPaymentSection({
    super.key,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _PaymentInlineItem(
                  icon: FontAwesomeIcons.moneyBill.data,
                  text: 'Pago',
                  isTitle: true,
                ),
              ),
              Expanded(
                child: _PaymentInlineItem(
                  icon: FontAwesomeIcons.circleCheck.data,
                  text: AppointmentDetailHelpers.paymentLabel(paymentStatus),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _PaymentInlineItem(
                  icon: FontAwesomeIcons.wallet.data,
                  text: AppointmentDetailHelpers.paymentMethodLabel(paymentMethod),
                ),
              ),
              Expanded(
                child: _PaymentInlineItem(
                  icon: FontAwesomeIcons.coins.data,
                  text: AppointmentDetailHelpers.formatAmount(amount),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentInlineItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isTitle;

  const _PaymentInlineItem({
    required this.icon,
    required this.text,
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: isTitle ? 20 : 18,
          color: isTitle ? AppColors.secondary : AppColors.textPrimary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: isTitle ? 18 : 16,
              color: isTitle
                  ? AppColors.textPrimary
                  : AppColors.textPrimary.withValues(alpha: 0.75),
              fontWeight: isTitle ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
