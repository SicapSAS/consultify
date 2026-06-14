import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class DoctorDetailBody extends StatelessWidget {
  final DcotorShow doctorShow;

  const DoctorDetailBody({
    super.key,
    required this.doctorShow,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      children: [
        DoctorDetailHeader(doctor: doctorShow.doctor),
        const SizedBox(height: 16),
        DoctorScheduleSection(schedule: doctorShow.schedule),
      ],
    );
  }
}
