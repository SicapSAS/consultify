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
    final size = MediaQuery.of(context).size;
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        size.width * 0.04,
        size.height * 0.02,
        size.width * 0.04,
        size.height * 0.04
      ),
      itemCount: clinics.length,
      separatorBuilder: (context, _) => SizedBox(
        height: size.height * 0.015,
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
