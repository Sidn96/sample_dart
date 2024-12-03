import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownCustomWidget extends StatelessWidget {
  final String hintText;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final List<DropdownMenuItem<String>>? items;
  final String? value;
  final Function(String?)? onChanged;
  final EdgeInsetsGeometry? dropListpadding;
  final TextStyle? hintstyle;
  const DropDownCustomWidget({
    super.key,
    required this.hintText,
    required this.selectedItemBuilder,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintstyle,
    this.dropListpadding,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(

      child: DropdownButton2<String>(

        isExpanded: true,
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: ColorUtils.bluishblack),
        ),
        hint: Text(
          hintText,
          style: hintstyle ??
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorUtils.greyLight,
              ),
        ),
        selectedItemBuilder: selectedItemBuilder,
        items: items,
        value: value,
        onChanged: onChanged,
        buttonStyleData: const ButtonStyleData(padding: EdgeInsets.zero),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 223,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
          offset: const Offset(0, -05),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          
            height: 40, padding: dropListpadding ?? EdgeInsets.zero),
      ),
    );
  }
}
