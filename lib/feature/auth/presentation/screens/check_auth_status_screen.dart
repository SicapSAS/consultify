import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class CheckAuthStatusScreen extends StatelessWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo de la aplicación
              Image.asset(
                'assets/logo/white_label.png',
                width: AppDimens.widthPercentage(0.7, context),
                fit: BoxFit.contain,
              ),
              /* CustomLoadingWidget(
                message: 'SICAP SAS'
              ) */
            ]
          )
        )
      )
    );
  }
}