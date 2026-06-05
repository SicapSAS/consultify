import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateClinicView extends StatelessWidget {
  const CreateClinicView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.06,
        size.height * 0.03,
        size.width * 0.06,
        size.height * 0.04,
      ),
      child: CreateClinicForm()
    );
  }
}
