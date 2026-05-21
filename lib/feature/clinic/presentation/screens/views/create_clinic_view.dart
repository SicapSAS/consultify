import 'package:consultify/config/config.dart';
import 'package:consultify/feature/clinic/presentation/screens/widgets/create_clinic_form.dart';
import 'package:flutter/material.dart';

class CreateClinicView extends StatelessWidget {
  const CreateClinicView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppDimens.widthPercentage(0.06, context),
        AppDimens.heightPercentage(0.03, context),
        AppDimens.widthPercentage(0.06, context),
        AppDimens.heightPercentage(0.04, context),
      ),
      child: CreateClinicForm()
    );
  }
}
