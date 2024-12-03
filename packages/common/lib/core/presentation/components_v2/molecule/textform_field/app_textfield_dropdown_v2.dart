import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_sizes.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom Dropdown widget for text field
class AppTextFieldDropdownV2 extends HookConsumerWidget {
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
  final String hintText;
  final Offset dropDownMenuOffSet;
  final double? dropDownWidth;

  const AppTextFieldDropdownV2(
      {super.key,
      required this.dropdownList,
      this.header,
      this.label,
      this.hintText = "",
      this.errorMessage,
      this.selectedOption,
      this.onChanged,
      this.dropDownWidth,
      this.dropDownIconColor = ColorUtils.kBlueColorDark,
      required this.dropDownMenuOffSet,
      this.showError = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDropDownExpanded = useState<bool>(false);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField2(
            isExpanded: true,
            onMenuStateChange: (isOpen) => isDropDownExpanded.value = isOpen,
            dropdownStyleData: DropdownStyleData(
                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0),
                width: dropDownWidth ?? Sizes.screenWidth() * 0.86,
                maxHeight: 130.w,
              //  isOverButton: false,
                elevation: 4,
                offset: Offset(5,-2,),
                ),
            isDense: false,
            selectedItemBuilder: (BuildContext context) {
              return dropdownList.map((String value) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: AppTextV2(
                    data: value.toString(),
                    fontSize: FontSizes.textSize14,
                    fontWeight: FontWeight.w500,
                    fontColor: ColorUtilsV2.neutral700,
                  ),
                );
              }).toList();
            },
            value: selectedOption,
            items: dropdownList.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorUtilsV2.hex_FFFFFF,
                    border: Border(
                      right: BorderSide(color: ColorUtilsV2.hex_E5E7EB),
                      left: BorderSide(color: ColorUtilsV2.hex_E5E7EB),
                      bottom: BorderSide(color: ColorUtilsV2.hex_E5E7EB),
                    ),
                  ),
                  child: AppTextV2(
                      data: value.toString(),
                      fontSize: FontSizes.textSize15,
                      fontWeight: FontWeight.w500,
                      fontColor: ColorUtilsV2.neutral700),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: hintText,
              contentPadding: EdgeInsets.fromLTRB(
                  20.0,
                  dropdownList.isNotEmpty ? 0 : 15,
                  20,
                  dropdownList.isNotEmpty ? 0 : 15),
              labelStyle: TextStyles.manropeStyle(
                FontSizes.textSize14,
                fontWeight: FontWeight.w500,
                color: ColorUtilsV2.neutral700,
              ),
              errorStyle: const TextStyle(height: 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: showError
                        ? ColorUtilsV2.specialDestructive400
                        : ColorUtils.kGreyBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: showError
                        ? ColorUtilsV2.specialDestructive400
                        : ColorUtils.kGreyBorderColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: showError
                        ? ColorUtilsV2.specialDestructive400
                        : ColorUtils.kGreyBorderColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: showError
                        ? ColorUtilsV2.specialDestructive400
                        : ColorUtils.kGreyBorderColor),
              ),
            ),
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(top: 10),
            ),
            iconStyleData: IconStyleData(
              icon: Align(
                alignment: Alignment.bottomCenter,
                child: isDropDownExpanded.value
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                        child: Transform.rotate(
                          angle: 3.14159,
                          child: Image.asset(
                            // alignment: Alignment.topCenter,
                            color: ColorUtilsV2.neutral700,
                            fit: BoxFit.contain,
                            AppImages.gamificationConstants.icDownArrow,
                            height: 14,
                            width: 14,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 8),
                        child: Image.asset(
                          alignment: Alignment.topCenter,
                          color: ColorUtilsV2.neutral700,
                          fit: BoxFit.contain,
                          AppImages.gamificationConstants.icDownArrow,
                          height: 14,
                          width: 14,
                        ),
                      ),
              ),
              // Icon(
              //   isDropDownExpanded.value
              //       ? Icons.keyboard_arrow_up
              //       : Icons.keyboard_arrow_down,
              //   color: ColorUtilsV2.neutral700,
              // ),
            ),
            onChanged: onChanged,
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.only(top: 0),
            ),
          ),
          if (showError)...[
           const SizedBox(height: 8),
            AppText(
                data: errorMessage ?? 'Please select an option',
                textAlign: TextAlign.start,
                fontColor: Colors.red,
                fontSize: 12,
                height: 1.4,
                fontWeight: FontWeight.w500),
        
          ]      
         
        ]);
  }
}
