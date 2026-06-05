import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateClinicForm extends ConsumerStatefulWidget {
  const CreateClinicForm({super.key});

  @override
  ConsumerState<CreateClinicForm> createState() => _CreateClinicFormState();
}

class _CreateClinicFormState extends ConsumerState<CreateClinicForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nitController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nitController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName es obligatorio';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final createClinic = CreateClinic(
      name: _nameController.text.trim(),
      nit: _nitController.text.trim(),
      streetAddress: _streetAddressController.text.trim(),
      city: _cityController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
    );

    final success = await ref.read(clinicProvider.notifier).createClinic(createClinic);

    if (!mounted) return;

    if (success) {
      AppSnackBar.success(context, 'Clínica creada correctamente');
      context.pop();
      return;
    }

    final errorMessage = ref.read(clinicProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(clinicProvider).isLoading;
    final size = MediaQuery.of(context).size;
    final fieldGap = size.height * 0.02;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: _nameController,
            label: 'Nombre de la clínica',
            showLabel: false,
            textCapitalization: TextCapitalization.words,
            prefixIcon: Icon(
              FontAwesomeIcons.hospital.data,
              color: AppColors.secondary,
              size: size.width * 0.09,
            ),
            validator: (value) => _requiredValidator(value, 'El nombre'),
          ),
          SizedBox(height: fieldGap),
          CustomTextFormField(
            controller: _nitController,
            label: 'NIT',
            showLabel: false,
            keyboardType: TextInputType.number,
            prefixIcon: Icon(
              FontAwesomeIcons.idCard.data,
              color: AppColors.secondary,
              size: size.width * 0.09,
            ),
            validator: (value) => _requiredValidator(value, 'El NIT'),
          ),
          SizedBox(height: fieldGap),
          CustomTextFormField(
            controller: _streetAddressController,
            label: 'Dirección',
            showLabel: false,
            textCapitalization: TextCapitalization.sentences,
            prefixIcon: Icon(
              FontAwesomeIcons.locationDot.data,
              color: AppColors.secondary,
              size: size.width * 0.09,
            ),
            validator: (value) => _requiredValidator(value, 'La dirección'),
          ),
          SizedBox(height: fieldGap),
          CustomTextFormField(
            controller: _cityController,
            label: 'Ciudad',
            showLabel: false,
            textCapitalization: TextCapitalization.words,
            prefixIcon: Icon(
              FontAwesomeIcons.city.data,
              color: AppColors.secondary,
              size: size.width * 0.09,
            ),
            validator: (value) => _requiredValidator(value, 'La ciudad'),
          ),
          SizedBox(height: fieldGap),
          CustomTextFormField(
            controller: _phoneController,
            label: 'Teléfono',
            showLabel: false,
            keyboardType: TextInputType.phone,
            prefixIcon: Icon(
              FontAwesomeIcons.phone.data,
              color: AppColors.secondary,
              size: size.width * 0.09,
            ),
          ),
          SizedBox(height: fieldGap),
          CustomTextFormField(
            controller: _emailController,
            label: 'Correo electrónico',
            showLabel: false,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(
              FontAwesomeIcons.envelope.data,
              color: AppColors.secondary,
              size: size.width * 0.09,
            ),
            validator: _emailValidator,
          ),
          SizedBox(height: size.height * 0.04),
          CustomFilledButton(
            text: isLoading ? 'Guardando...' : 'Crear clínica',
            buttonColor: AppColors.primaryButton,
            width: size.width * 0.4,
            height: size.height * 0.05,
            textSize: size.width * 0.03,
            onPressed: isLoading ? null : _onSubmit,
          ),
        ],
      ),
    );
  }
}
