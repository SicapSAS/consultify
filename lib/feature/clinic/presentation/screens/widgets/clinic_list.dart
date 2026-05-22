import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class ClinicList extends StatelessWidget {
  final List<ListClinic> clinics;
  final void Function(ListClinic clinic)? onClinicTap;
  final void Function(ListClinic clinic, ClinicMenuAction action)? onMenuAction;

  const ClinicList({
    super.key,
    required this.clinics,
    this.onClinicTap,
    this.onMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        AppDimens.widthPercentage(0.04, context),
        AppDimens.heightPercentage(0.02, context),
        AppDimens.widthPercentage(0.04, context),
        AppDimens.heightPercentage(0.04, context)
      ),
      itemCount: clinics.length,
      separatorBuilder: (context, _) => SizedBox(
        height: AppDimens.heightPercentage(0.015, context),
      ),
      itemBuilder: (context, index) {
        final clinic = clinics[index];
        return ClinicListTile(
          clinic: clinic,
          onTap: onClinicTap != null ? () => onClinicTap!(clinic) : null,
          onMenuAction: onMenuAction != null
              ? (action) => onMenuAction!(clinic, action)
              : null,
        );
      }
    );
  }
}
