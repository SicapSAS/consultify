import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatelessWidget {
  final List<Doctor> doctors;

  const DoctorList({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        16,
      ),
      itemCount: doctors.length,
      separatorBuilder: (context, _) => SizedBox(
        height: 12,
      ),
      itemBuilder: (context, index) {
        return DoctorCard(
          doctor: doctors[index],
        );
      },
    );
  }
}
