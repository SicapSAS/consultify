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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32),
                
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Image.asset(
                    'assets/logo/consultify_transparente2.png',
                    width: 256,
                    fit: BoxFit.contain
                  )
                ),
                SizedBox(height: 32),
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
      padding: EdgeInsets.symmetric(horizontal: 16),
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
          SizedBox(height: 12),
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
                size: 20
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              }
            )
          ),
          SizedBox(height: 12),
          SizedBox(
            width: 128,
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
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: AppColors.secondary,
      )
    );
  }
}
