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
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
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

    final createClinic = CreateClinic(
      name: _nameController.text.trim(),
      address: _addressController.text.trim(),
      phone: _phoneController.text.trim(),
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
    final fieldGap = AppDimens.heightPercentage(0.02, context);

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
              size: AppDimens.normalIcon(context)
            ),
            validator: (value) => _requiredValidator(value, 'El nombre')
          ),
          SizedBox(height: fieldGap),
          CustomTextFormField(
            controller: _addressController,
            label: 'Dirección',
            showLabel: false,
            textCapitalization: TextCapitalization.sentences,
            prefixIcon: Icon(
              FontAwesomeIcons.locationDot.data,
              color: AppColors.secondary,
              size: AppDimens.normalIcon(context)
            ),
            validator: (value) => _requiredValidator(value, 'La dirección')
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
              size: AppDimens.normalIcon(context)
            ),
            validator: (value) => _requiredValidator(value, 'El teléfono')
          ),
          SizedBox(height: AppDimens.heightPercentage(0.04, context)),
          CustomFilledButton(
            text: isLoading ? 'Guardando...' : 'Crear clínica',
            buttonColor: AppColors.primaryButton,
            width: AppDimens.widthPercentage(0.4, context),
            height: AppDimens.heightPercentage(0.05, context),
            textSize: AppDimens.littleText(context),
            onPressed: isLoading ? null : _onSubmit
          )
        ]
      )
    );
  }
}
