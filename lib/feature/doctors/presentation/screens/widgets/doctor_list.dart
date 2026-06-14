import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatelessWidget {
  final List<Doctor> doctors;
  final void Function(Doctor doctor)? onDoctorTap;
  final void Function(Doctor doctor, DoctorMenuAction action)? onMenuAction;

  const DoctorList({
    super.key,
    required this.doctors,
    this.onDoctorTap,
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
      itemCount: doctors.length,
      separatorBuilder: (context, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return DoctorCard(
          doctor: doctor,
          onTap: onDoctorTap != null ? () => onDoctorTap!(doctor) : null,
          onMenuAction: onMenuAction != null
              ? (action) => onMenuAction!(doctor, action)
              : null,
        );
      },
    );
  }
}
