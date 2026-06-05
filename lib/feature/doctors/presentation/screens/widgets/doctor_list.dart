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
    final size = MediaQuery.of(context).size;

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        size.width * 0.04,
        size.height * 0.02,
        size.width * 0.04,
        size.height * 0.04,
      ),
      itemCount: doctors.length,
      separatorBuilder: (context, _) => SizedBox(
        height: size.height * 0.015,
      ),
      itemBuilder: (context, index) {
        return DoctorCard(
          doctor: doctors[index],
        );
      },
    );
  }
}
