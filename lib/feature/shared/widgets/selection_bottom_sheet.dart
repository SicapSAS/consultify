import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

/// Opción del bottom sheet de selección: ícono, texto y acción opcional.
///
/// Si [onTap] es null, al tocar la fila solo se cierra el sheet (útil como placeholder).
class SelectionSheetOption {
  const SelectionSheetOption({
    required this.label,
    required this.icon,
    this.onTap,
    this.iconColor,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
}

/// Bottom sheet modal reutilizable: título centrado y lista vertical de opciones.
///
/// Sirve para adjuntos (cámara, galería, PDF, archivos, etc.); la cantidad de
/// opciones es la que pases en [options].
///
/// Se cierra al deslizar, al tocar fuera o al elegir una fila.
Future<T?> showSelectionBottomSheet<T>({
  required BuildContext context,
  required String title,
  required List<SelectionSheetOption> options,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (context) => _SelectionBottomSheetContent(
      title: title,
      options: options
    )
  );
}

class _SelectionBottomSheetContent extends StatelessWidget {
  const _SelectionBottomSheetContent({
    required this.title,
    required this.options,
  });

  final String title;
  final List<SelectionSheetOption> options;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimens.widthPercentage(0.06, context))
        )
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indicador de arrastre
            Padding(
              padding: EdgeInsets.only(top: AppDimens.heightPercentage(0.015, context)),
              child: Container(
                width: AppDimens.widthPercentage(0.1, context),
                height: AppDimens.heightPercentage(0.005, context),
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(
                    AppDimens.widthPercentage(0.01, context)
                  )
                )
              )
            ),
            SizedBox(height: AppDimens.heightPercentage(0.02, context)),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.widthPercentage(0.06, context),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppDimens.titleText(context),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDimens.heightPercentage(0.025, context)),
            ...options.map((option) => _OptionTile(option: option)),
            SizedBox(height: AppDimens.heightPercentage(0.02, context))
          ]
        )
      )
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({required this.option});

  final SelectionSheetOption option;

  @override
  Widget build(BuildContext context) {
    final iconColor = option.iconColor ?? AppColors.secondaryButton;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          if (option.onTap != null) {
            Future.microtask(option.onTap!);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.widthPercentage(0.06, context),
            vertical: AppDimens.heightPercentage(0.018, context),
          ),
          child: Row(
            children: [
              Icon(
                option.icon,
                color: iconColor,
                size: AppDimens.bigIcon(context)
              ),
              SizedBox(width: AppDimens.widthPercentage(0.04, context)),
              Expanded(
                child: Text(
                  option.label,
                  style: TextStyle(
                    fontSize: AppDimens.normalText(context),
                    color: AppColors.textPrimary
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}
