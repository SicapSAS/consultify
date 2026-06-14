import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateDoctorForm extends ConsumerStatefulWidget {
  final Doctor? doctor;

  const CreateDoctorForm({
    super.key,
    this.doctor,
  });

  @override
  ConsumerState<CreateDoctorForm> createState() => _CreateDoctorFormState();
}

class _CreateDoctorFormState extends ConsumerState<CreateDoctorForm> {
  static const _documentTypes = ['CC', 'TI', 'CE', 'PP', 'PAS'];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _documentIdController = TextEditingController();
  final _professionalCardController = TextEditingController();

  String? _documentType;
  String? _specialty;
  bool _obscurePassword = true;

  bool get _isEditing => widget.doctor != null;

  List<String> get _availableSpecialties {
    final activeNames = ref
        .watch(specialityProvider)
        .specialties
        .where((specialty) => specialty.isActive)
        .map((specialty) => specialty.name)
        .toList();

    if (_isEditing) {
      final currentSpecialty = widget.doctor!.specialty.trim();
      if (currentSpecialty.isNotEmpty &&
          !activeNames.contains(currentSpecialty)) {
        return [currentSpecialty, ...activeNames];
      }
    }

    return activeNames;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(specialityProvider.notifier).getSpecialties();
    });

    final doctor = widget.doctor;
    if (doctor == null) return;

    final type = doctor.documentType;
    if (type.isNotEmpty && _documentTypes.contains(type)) {
      _documentType = type;
    }

    final specialty = doctor.specialty.trim();
    if (specialty.isNotEmpty) {
      _specialty = specialty;
    }

    _nameController.text = doctor.name;
    _emailController.text = doctor.email;
    _documentIdController.text = doctor.documentId;
    _professionalCardController.text = doctor.professionalCardNumber;
  }

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
    if (_isEditing && (value == null || value.trim().isEmpty)) {
      return null;
    }

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

    final notifier = ref.read(doctorsProvider.notifier);
    final success = _isEditing
        ? await notifier.updateDoctor(
            widget.doctor!.id,
            DoctorUpdate(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              specialty: _specialty!,
              documentType: _documentType!,
              documentId: _documentIdController.text.trim(),
              professionalCardNumber: _professionalCardController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          )
        : await notifier.createDoctor(
            DoctorCreate(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
              specialty: _specialty!,
              documentType: _documentType!,
              documentId: _documentIdController.text.trim(),
              professionalCardNumber: _professionalCardController.text.trim(),
            ),
          );

    if (!mounted) return;

    if (success) {
      AppSnackBar.success(
        context,
        _isEditing
            ? 'Doctor actualizado correctamente'
            : 'Doctor creado correctamente',
      );
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
    final isLoadingSpecialties = ref.watch(specialityProvider).isLoading;
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
            enabled: !isPosting,
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
            items: _availableSpecialties,
            selected: _specialty,
            getTextBySelected: (specialty) => specialty,
            isActive: !isPosting && !isLoadingSpecialties,
            disabledMessage: isLoadingSpecialties
                ? 'Cargando especialidades...'
                : 'No hay especialidades activas',
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
            label: _isEditing ? 'Nueva contraseña (opcional)' : 'Contraseña',
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
            text: isPosting
                ? 'Guardando...'
                : (_isEditing ? 'Actualizar' : 'Registrar'),
            buttonColor: AppColors.primaryButton,
            width: 200,
            height: 50,
            textSize: 20,
            onPressed: isPosting || isLoadingSpecialties ? null : _onSubmit,
          ),
        ],
      ),
    );
  }
}
