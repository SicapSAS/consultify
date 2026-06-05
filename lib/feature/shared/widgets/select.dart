import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class Select<T> extends StatelessWidget {
  final Function(T?) onTap;
  final String defaultValue;
  final List<T> items;
  final T? selected;
  final String Function(T) getTextBySelected;
  final bool isActive;
  final String disabledMessage;
  final double width;
  final double? height;
  final bool Function(T, T?) areTheSame;
  final Function()? addNew;
  final Color? selectedItemColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? textColor;
  final EdgeInsets? itemPadding;
  final String? labelText;
  final Color? borderColor;
  const Select({
    super.key,
    required this.onTap,
    required this.defaultValue,
    required this.items,
    required this.selected,
    required this.getTextBySelected,
    required this.isActive,
    required this.disabledMessage,
    required this.width,
    this.height,
    required this.areTheSame,
    this.addNew,
    this.selectedItemColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.textColor,
    this.itemPadding,
    this.labelText,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final popMenuHeight = height ?? 56.0;
    const placeholderFontSize = 17.0;
    const selectedFontSize = 17.0;
    return GestureDetector(
      onTap: isActive? () async {
        // showMenu exige items.isNotEmpty; sin datos ni "Añadir" no hay menú.
        if (items.isEmpty && addNew == null) return;

        final RenderBox button = context.findRenderObject() as RenderBox;
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;

        // Calcula posición del menú
        final RelativeRect position = RelativeRect.fromRect(
          Rect.fromPoints(
            button.localToGlobal(Offset(0, popMenuHeight + 10), ancestor: overlay),
            button.localToGlobal(
              button.size.bottomRight(Offset(0, popMenuHeight + 10)),
              ancestor: overlay
            )
          ),
          Offset.zero & overlay.size,
        );
        await showMenu(
          context: context,
          position: position,
          menuPadding: EdgeInsets.zero,
          constraints: BoxConstraints(
            minWidth: width,
            maxWidth: width,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10
            ),
          ),
          color: AppColors.secondaryBackground,
          items: [
            ...items.map(
              (c) => PopupMenuItem(
                padding: EdgeInsets.zero,
                onTap: () => onTap(c),
                child: SizedBox(
                  width: width,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10
                      ),
                      color:  areTheSame(c, selected)?
                        (selectedItemColor ?? AppColors.infoBackground):
                        AppColors.secondaryBackground
                    ),
                    padding: itemPadding ?? EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        getTextBySelected(c),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: areTheSame(c, selected)?
                            (selectedTextColor ?? AppColors.secondaryBackground):
                            (unselectedTextColor ?? AppColors.textPrimary),
                          fontSize: 17,
                        )
                      )
                    )
                  ),
                )
              )
            ),
            if(addNew != null)
              PopupMenuItem(
                onTap: addNew,
                child: SizedBox(
                  width: width,
                  child: Center(
                    child: TextButton.icon(
                      icon: Icon(Icons.add, color: AppColors.iconSuccess),
                      label: Text('Añadir', style: TextStyle(
                        color: AppColors.iconSuccess,
                        fontSize: 17,
                      )),
                      onPressed: addNew,
                    )
                  )
                )
              )
          ]
        );
      } : null,
      child: Container(
        width: width,
        height: popMenuHeight,
        padding:  EdgeInsets.symmetric(
          horizontal: 20
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10
          ),
          color: AppColors.secondaryBackground,
          border: Border.all(
            color: borderColor ?? AppColors.textPrimary,
            width: 1,
          ),
          
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(isActive)
              ...[
                if(selected != null)
                  Expanded(
                    child: Text(
                      getTextBySelected(selected as T),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: textColor ?? AppColors.textPrimary,
                        fontSize: selectedFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  )
                else
                Expanded(
                  child: Text(
                    defaultValue,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: textColor ?? AppColors.textPrimary,
                      fontSize: placeholderFontSize,
                      fontWeight: FontWeight.w400,
                    )
                  )
                )
              ]
            else 
              Expanded(
                child: Text(
                  disabledMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                  ),
                )
              ),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_drop_down_outlined,
              color: isActive?
                AppColors.textPrimary:
                AppColors.textPrimary.withValues(alpha: 0.6),
              size: 30
            )
          ]
        )
      )
    );
  }
}