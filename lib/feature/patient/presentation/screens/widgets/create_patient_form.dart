import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreatePatientForm extends ConsumerStatefulWidget {
  final Patient? patient;

  const CreatePatientForm({
    super.key,
    this.patient,
  });

  @override
  ConsumerState<CreatePatientForm> createState() => _CreatePatientFormState();
}

class _CreatePatientFormState extends ConsumerState<CreatePatientForm> {
  static const _documentTypes = ['CC', 'TI', 'CE', 'PP', 'PAS'];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _documentIdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  String? _documentType;

  bool get _isEditing => widget.patient != null;

  @override
  void initState() {
    super.initState();
    final patient = widget.patient;
    final type = patient?.documentType;
    if (type != null &&
        type.isNotEmpty &&
        _documentTypes.contains(type)) {
      _documentType = type;
    }
    if (patient != null) {
      _nameController.text = patient.name;
      _documentIdController.text = patient.documentId;
      _phoneController.text = patient.phone;
      _emailController.text = patient.email;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _documentIdController.dispose();
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
    if (_documentType == null || _documentType!.isEmpty) {
      AppSnackBar.error(context, 'Seleccione el tipo de documento');
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final data = CreatePatient(
      name: _nameController.text.trim(),
      documentType: _documentType!,
      documentId: _documentIdController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    final notifier = ref.read(patientProvider.notifier);
    final success = _isEditing
        ? await notifier.updatePatient(widget.patient!.id, data)
        : await notifier.createPatient(data);

    if (!mounted) return;

    if (success) {
      AppSnackBar.success(
        context,
        _isEditing
            ? 'Paciente actualizado correctamente'
            : 'Paciente creado correctamente',
      );
      context.pop();
      return;
    }

    final errorMessage = ref.read(patientProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLoading = ref.watch(patientProvider).isLoading;
    final fieldGap = 10.0;
    final rowGap = 10.0;
    final documentTypeWidth = 150.0;

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
          SizedBox(height: fieldGap),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Select<String>(
                onTap: (value) => setState(() => _documentType = value),
                defaultValue: 'Seleccione',
                items: _documentTypes,
                selected: _documentType,
                getTextBySelected: (type) => type,
                isActive: true,
                disabledMessage: '',
                width: documentTypeWidth,
                areTheSame: (a, b) => a == b,
              ),
              SizedBox(width: rowGap),
              Expanded(
                child: CustomTextFormField(
                  controller: _documentIdController,
                  label: 'N° documento',
                  showLabel: false,
                  keyboardType: TextInputType.number,
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
          SizedBox(height: fieldGap),
          CustomTextFormField(
            controller: _phoneController,
            label: 'Teléfono',
            showLabel: false,
            keyboardType: TextInputType.number,
            prefixIcon: Icon(
              FontAwesomeIcons.phone.data,
              color: AppColors.secondary,
              size: 20,
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
              size: 20,
            ),
            validator: _emailValidator,
          ),
          SizedBox(height: size.height * 0.04),
          CustomFilledButton(
            text: isLoading
                ? 'Guardando...'
                : (_isEditing ? 'Actualizar' : 'Registrar'),
            
            buttonColor: AppColors.primaryButton,
            width: 200,
            height: 50,
            textSize: 20,
            onPressed: isLoading ? null : _onSubmit,
          ),
        ],
      ),
    );
  }
}
