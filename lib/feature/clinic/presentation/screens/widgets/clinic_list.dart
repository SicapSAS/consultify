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
        16,
        12,
        16,
        CustomBottomNavigationBar.scrollBottomPadding(
          context,
          withFloatingActionButton: true,
        ),
      ),
      itemCount: clinics.length,
      separatorBuilder: (context, _) => SizedBox(
        height: 12,
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
