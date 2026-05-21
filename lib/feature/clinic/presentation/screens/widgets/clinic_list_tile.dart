import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClinicListTile extends StatelessWidget {
  final ListClinic clinic;
  final VoidCallback? onTap;

  const ClinicListTile({
    super.key,
    required this.clinic,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = AppDimens.smallBorderRadius(0.02, context);

    return Material(
      color: AppColors.secondaryBackground,
      elevation: 2,
      shadowColor: AppColors.textPrimary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Padding(
          padding: EdgeInsets.all(AppDimens.widthPercentage(0.04, context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppDimens.widthPercentage(0.12, context),
                height: AppDimens.widthPercentage(0.12, context),
                decoration: BoxDecoration(
                  color: AppColors.secondaryButton.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(
                    AppDimens.smallBorderRadius(0.07, context),
                  ),
                ),
                child: Icon(
                  FontAwesomeIcons.hospital.data,
                  color: AppColors.secondary,
                  size: AppDimens.normalIcon(context),
                ),
              ),
              SizedBox(width: AppDimens.widthPercentage(0.03, context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clinic.name,
                      style: TextStyle(
                        fontSize: AppDimens.subtitleText(context),
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (clinic.address.isNotEmpty) ...[
                      SizedBox(height: AppDimens.heightPercentage(0.008, context)),
                      _ClinicDetailRow(
                        icon: FontAwesomeIcons.locationDot.data,
                        text: clinic.address,
                      ),
                    ],
                    if (clinic.phone.isNotEmpty) ...[
                      SizedBox(height: AppDimens.heightPercentage(0.006, context)),
                      _ClinicDetailRow(
                        icon: FontAwesomeIcons.phone.data,
                        text: clinic.phone,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClinicDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ClinicDetailRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: AppDimens.tinyIcon(context),
          color: AppColors.textPrimary.withValues(alpha: 0.45),
        ),
        SizedBox(width: AppDimens.widthPercentage(0.02, context)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppDimens.littleText(context),
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
