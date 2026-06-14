import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateSpecialityForm extends ConsumerStatefulWidget {
  final Specialty? specialty;

  const CreateSpecialityForm({
    super.key,
    this.specialty,
  });

  @override
  ConsumerState<CreateSpecialityForm> createState() =>
      _CreateSpecialityFormState();
}

class _CreateSpecialityFormState extends ConsumerState<CreateSpecialityForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool get _isEditing => widget.specialty != null;

  @override
  void initState() {
    super.initState();
    final specialty = widget.specialty;
    if (specialty == null) return;

    _nameController.text = specialty.name;
    _descriptionController.text = specialty.description;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName es obligatorio';
    }
    return null;
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final description = _descriptionController.text.trim();
    final isPosting = ref.read(specialityProvider).isPosting;
    if (isPosting) return;

    final bool success;

    if (_isEditing) {
      success = await ref.read(specialityProvider.notifier).updateSpecialty(
            widget.specialty!.id,
            SpecialityUpdate(
              name: _nameController.text.trim(),
              description: description.isEmpty ? null : description,
            ),
          );
    } else {
      success = await ref.read(specialityProvider.notifier).createSpecialty(
            SpecialityCreate(
              name: _nameController.text.trim(),
              description: description.isEmpty ? null : description,
            ),
          );
    }

    if (!mounted) return;

    if (success) {
      AppSnackBar.success(
        context,
        _isEditing
            ? 'Especialidad actualizada correctamente'
            : 'Especialidad creada correctamente',
      );
      context.pop();
      return;
    }

    final errorMessage = ref.read(specialityProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPosting = ref.watch(specialityProvider).isPosting;
    const fieldGap = 12.0;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: _nameController,
            label: 'Nombre de la especialidad',
            showLabel: false,
            textCapitalization: TextCapitalization.words,
            enabled: !isPosting,
            prefixIcon: Icon(
              FontAwesomeIcons.stethoscope.data,
              color: AppColors.secondary,
              size: 14,
            ),
            validator: (value) => _requiredValidator(value, 'El nombre'),
          ),
          const SizedBox(height: fieldGap),
          CustomMultiLineFormField(
            controller: _descriptionController,
            hintText: 'Descripción (opcional)',
          ),
          const SizedBox(height: 16),
          CustomFilledButton(
            text: isPosting
                ? 'Guardando...'
                : _isEditing
                    ? 'Actualizar'
                    : 'Crear especialidad',
            buttonColor: AppColors.primaryButton,
            width: 200,
            height: 50,
            textSize: 16,
            onPressed: isPosting ? null : _onSubmit,
          ),
        ],
      ),
    );
  }
}
