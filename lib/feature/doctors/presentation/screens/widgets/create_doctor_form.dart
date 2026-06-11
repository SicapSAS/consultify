import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateDoctorForm extends ConsumerStatefulWidget {
  const CreateDoctorForm({super.key});

  @override
  ConsumerState<CreateDoctorForm> createState() => _CreateDoctorFormState();
}

class _CreateDoctorFormState extends ConsumerState<CreateDoctorForm> {
  static const _documentTypes = ['CC', 'TI', 'CE', 'PP', 'PAS'];
  static const _specialties = [
    'Odontología General',
    'Ortodoncia',
    'Endodoncia',
    'Periodoncia',
    'Odontopediatría',
    'Cirugía Oral',
    'Implantología',
    'Estética Dental',
    'Prostodoncia',
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _documentIdController = TextEditingController();
  final _professionalCardController = TextEditingController();

  String? _documentType;
  String? _specialty;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _documentIdController.dispose();
    _professionalCardController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName es obligatorio';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El correo es obligatorio';
    }

    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La contraseña es obligatoria';
    }
    if (value.trim().length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  Future<void> _onSubmit() async {
    if (_documentType == null || _documentType!.isEmpty) {
      AppSnackBar.error(context, 'Seleccione el tipo de documento');
      return;
    }
    if (_specialty == null || _specialty!.isEmpty) {
      AppSnackBar.error(context, 'Seleccione la especialidad');
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final data = DoctorCreate(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      specialty: _specialty!,
      documentType: _documentType!,
      documentId: _documentIdController.text.trim(),
      professionalCardNumber: _professionalCardController.text.trim(),
    );

    final success = await ref.read(doctorsProvider.notifier).createDoctor(data);

    if (!mounted) return;

    if (success) {
      AppSnackBar.success(context, 'Doctor creado correctamente');
      context.pop();
      return;
    }

    final errorMessage = ref.read(doctorsProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPosting = ref.watch(doctorsProvider).isPosting;
    const fieldGap = 10.0;
    const rowGap = 10.0;
    const documentTypeWidth = 150.0;
    final selectWidth = MediaQuery.sizeOf(context).width - 32;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: _nameController,
            label: 'Nombre completo',
            showLabel: false,
            textCapitalization: TextCapitalization.words,
            prefixIcon: Icon(
              FontAwesomeIcons.user.data,
              color: AppColors.secondary,
              size: 20,
            ),
            validator: (value) => _requiredValidator(value, 'El nombre'),
          ),
          const SizedBox(height: fieldGap),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Select<String>(
                onTap: (value) => setState(() => _documentType = value),
                defaultValue: 'Seleccione',
                items: _documentTypes,
                selected: _documentType,
                getTextBySelected: (type) => type,
                isActive: !isPosting,
                disabledMessage: '',
                width: documentTypeWidth,
                areTheSame: (a, b) => a == b,
              ),
              const SizedBox(width: rowGap),
              Expanded(
                child: CustomTextFormField(
                  controller: _documentIdController,
                  label: 'N° documento',
                  showLabel: false,
                  keyboardType: TextInputType.number,
                  enabled: !isPosting,
                  prefixIcon: Icon(
                    FontAwesomeIcons.idCard.data,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                  validator: (value) => _requiredValidator(value, 'El documento'),
                ),
              ),
            ],
          ),
          const SizedBox(height: fieldGap),
          CustomTextFormField(
            controller: _professionalCardController,
            label: 'Tarjeta profesional',
            showLabel: false,
            enabled: !isPosting,
            prefixIcon: Icon(
              FontAwesomeIcons.idBadge.data,
              color: AppColors.secondary,
              size: 20,
            ),
            validator: (value) =>
                _requiredValidator(value, 'La tarjeta profesional'),
          ),
          const SizedBox(height: fieldGap),
          Select<String>(
            onTap: (value) => setState(() => _specialty = value),
            defaultValue: 'Seleccione especialidad',
            items: _specialties,
            selected: _specialty,
            getTextBySelected: (specialty) => specialty,
            isActive: !isPosting,
            disabledMessage: '',
            width: selectWidth,
            areTheSame: (a, b) => a == b,
          ),
          const SizedBox(height: fieldGap),
          CustomTextFormField(
            controller: _emailController,
            label: 'Correo electrónico',
            showLabel: false,
            keyboardType: TextInputType.emailAddress,
            enabled: !isPosting,
            prefixIcon: Icon(
              FontAwesomeIcons.envelope.data,
              color: AppColors.secondary,
              size: 20,
            ),
            validator: _emailValidator,
          ),
          const SizedBox(height: fieldGap),
          CustomTextFormField(
            controller: _passwordController,
            label: 'Contraseña',
            showLabel: false,
            obscureText: _obscurePassword,
            enabled: !isPosting,
            prefixIcon: Icon(
              FontAwesomeIcons.lock.data,
              color: AppColors.secondary,
              size: 20,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? FontAwesomeIcons.eyeLowVision.data
                    : FontAwesomeIcons.solidEye.data,
                color: AppColors.primaryButton,
                size: 20,
              ),
              onPressed: isPosting
                  ? null
                  : () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            validator: _passwordValidator,
          ),
          const SizedBox(height: 16),
          CustomFilledButton(
            text: isPosting ? 'Guardando...' : 'Registrar',
            buttonColor: AppColors.primaryButton,
            width: 200,
            height: 50,
            textSize: 20,
            onPressed: isPosting ? null : _onSubmit,
          ),
        ],
      ),
    );
  }
}
