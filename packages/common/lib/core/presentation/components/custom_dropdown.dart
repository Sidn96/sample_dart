import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  /// this will store the list of dropdown items values
  final List<String> dropdownList;

  /// this will be used for the display label
  final String? header;

  /// this will be used for the display label
  final String? label;

  /// this will be used for the error message
  final String? errorMessage;

  /// this will be used to display selected option
  final String? selectedOption;

  final Function(String?)? onChanged;

  final bool showError;
  final Color dropDownIconColor;

  const CustomDropdown(
      {super.key,
      required this.dropdownList,
      this.header,
      this.label,
      this.errorMessage,
      this.selectedOption,
      this.onChanged,
      this.dropDownIconColor = ColorUtils.kBlueColorDark,
      this.showError = false});

  @override
  Widget build(BuildContext context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: AppText(
                    data: header ?? 'Reason for Change Request',
                    fontColor: const Color(0xFF9CA3AF),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.24)),
            DropdownButton(
                hint: selectedOption == null
                    ? AppText(
                        data: label ?? 'Select Reason',
                        fontSize: 16,
                        fontWeight: FontWeight.w700)
                    : AppText(
                        data: selectedOption!,
                        fontColor: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                padding: const EdgeInsets.all(0),
                isExpanded: true,
                iconSize: 30.0,
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: dropDownIconColor,
                ),
                style: const TextStyle(color: Colors.blue),
                items: dropdownList
                    .map((val) => DropdownMenuItem<String>(
                        value: val,
                        child: AppText(
                            data: val,
                            fontColor: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)))
                    .toList(),
                onChanged: onChanged),
            const SizedBox(height: 10),
            if (showError)
              AppText(
                  data: errorMessage ?? 'Please select a reason',
                  textAlign: TextAlign.start,
                  fontColor: Colors.red,
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w500),
          ]);
}
