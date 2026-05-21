import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: SizedBox(
            height: AppDimens.heightPercentage(1, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppDimens.heightPercentage(0.2, context)),
                
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.widthPercentage(0.05, context),
                  ),
                  child: Image.asset(
                    'assets/logo/consultify_transparente2.png',
                    width: AppDimens.widthPercentage(0.8, context),
                    fit: BoxFit.contain
                  )
                ),
                SizedBox(height: AppDimens.heightPercentage(0.1, context)),
                _LoginForm()
                
              ]
            )
          )
        )
      )
    );
  }
}

class _LoginForm extends ConsumerStatefulWidget {
  const _LoginForm();

  @override
  ConsumerState<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<_LoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if ( next.errorMessage.isEmpty) return;
      showSnackBar(context, next.errorMessage);
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.widthPercentage(0.06, context)),
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Correo electrónico',
            showLabel: false,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChanged,
            //validator: ref.read(loginFormProvider.notifier).onEmailChanged,
            errorMessage: loginForm.isFormPosted ? 
              loginForm.email.errorMessage 
              : null
          ),
          SizedBox(height: AppDimens.heightPercentage(0.02, context)),
          CustomTextFormField(
            label: 'Contraseña',
            showLabel: false,
            obscureText: _obscurePassword,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            //validator: (value) => ref.read(loginFormProvider.notifier).onEmailChanged(value),
            errorMessage: loginForm.isFormPosted ? 
              loginForm.password.errorMessage 
              : null,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? 
                FontAwesomeIcons.eyeLowVision.data : 
                FontAwesomeIcons.solidEye.data,
                color: AppColors.primaryButton,
                size: AppDimens.normalIcon(context) * 0.9
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              }
            )
          ),
          SizedBox(height: AppDimens.heightPercentage(0.02, context)),
          SizedBox(
            width: AppDimens.widthPercentage(0.5, context),
            child: CustomFilledButton(
              text: 'Iniciar sesión', 
              buttonColor: AppColors.primaryButton,
              onPressed: loginForm.isPosting ? null : 
                () => ref.read(loginFormProvider.notifier).onFormSubmit()
            )
          )
        ]
      )
    );
  }
  
  void showSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppDimens.widthPercentage(0.04, context),
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: AppColors.secondary,
      )
    );
  }
}
