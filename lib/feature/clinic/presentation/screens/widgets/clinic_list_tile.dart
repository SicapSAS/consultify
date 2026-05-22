import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClinicListTile extends StatelessWidget {
  final ListClinic clinic;
  final VoidCallback? onTap;
  final ValueChanged<ClinicMenuAction>? onMenuAction;

  const ClinicListTile({
    super.key,
    required this.clinic,
    this.onTap,
    this.onMenuAction,
  });

  static const _menuItems = [
    ContextMenuItem<ClinicMenuAction>(
      value: ClinicMenuAction.disable,
      label: 'Inhabilitar clínica',
      icon: Icons.block_outlined,
      isDestructive: true,
    ),
    ContextMenuItem<ClinicMenuAction>(
      value: ClinicMenuAction.update,
      label: 'Actualizar clínica',
      icon: Icons.edit_outlined,
    ),
  ];

  bool _hasText(String? value) {
    if (value == null) return false;
    final trimmed = value.trim();
    return trimmed.isNotEmpty && trimmed != 'Sin teléfono';
  }

  /* String? get _displayAddress {
    if (_hasText(clinic.streetAddress)) return clinic.streetAddress!.trim();
    if (_hasText(clinic.address)) return clinic.address!.trim();
    return null;
  } */

  @override
  Widget build(BuildContext context) {
    final radius = AppDimens.smallBorderRadius(0.02, context);
    final rowGap = AppDimens.heightPercentage(0.006, context);

    final cardPadding = AppDimens.widthPercentage(0.04, context);
    final menuIconSize = AppDimens.normalIcon(context) * 0.85;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                cardPadding,
                cardPadding,
                cardPadding + menuIconSize + 4,
                cardPadding
              ),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(radius),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppDimens.widthPercentage(0.12, context),
                      height: AppDimens.widthPercentage(0.12, context),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryButton.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(
                          AppDimens.smallBorderRadius(0.07, context)
                        )
                      ),
                      child: Icon(
                        FontAwesomeIcons.hospital.data,
                        color: AppColors.secondary,
                        size: AppDimens.normalIcon(context)
                      )
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
                              fontWeight: FontWeight.w700
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis
                          ),
                          /* if (displayAddress != null) ...[
                            SizedBox(height: AppDimens.heightPercentage(0.008, context)),
                            _ClinicDetailRow(
                              icon: FontAwesomeIcons.locationDot.data,
                              text: displayAddress,
                            ),
                          ],
                          if (_hasText(clinic.city)) ...[
                            SizedBox(height: rowGap),
                            _ClinicDetailRow(
                              icon: FontAwesomeIcons.city.data,
                              text: clinic.city!.trim(),
                            ),
                          ],
                          if (_hasText(clinic.nit)) ...[
                            SizedBox(height: rowGap),
                            _ClinicDetailRow(
                              icon: FontAwesomeIcons.idCard.data,
                              text: clinic.nit!.trim(),
                            ),
                          ],
                          if (_hasText(clinic.phone)) ...[
                            SizedBox(height: rowGap),
                            _ClinicDetailRow(
                              icon: FontAwesomeIcons.phone.data,
                              text: clinic.phone.trim(),
                            ),
                          ], */
                          if (_hasText(clinic.email)) ...[
                            SizedBox(height: rowGap),
                            _ClinicDetailRow(
                              icon: FontAwesomeIcons.envelope.data,
                              text: clinic.email!.trim()
                            )
                          ]
                        ]
                      )
                    )
                  ]
                )
              )
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 6,
              child: Center(
                child: ContextMenuButton<ClinicMenuAction>(
                  items: _menuItems,
                  onSelected: onMenuAction,
                  iconColor: AppColors.iconDark,
                  iconSize: menuIconSize,
                  padding: EdgeInsets.all(AppDimens.widthPercentage(0.01, context)),
                )
              )
            )
          ]
        )
      )
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
          color: AppColors.textPrimary.withValues(alpha: 0.45)
        ),
        SizedBox(width: AppDimens.widthPercentage(0.02, context)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppDimens.littleText(context),
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis
          )
        )
      ]
    );
  }
}
