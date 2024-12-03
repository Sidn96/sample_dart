import 'package:common/core/presentation/components_v2/app_icon_button.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/molecule/textform_field/app_input_textfield_v2.dart';
import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/features/new_login_register/domain/enums.dart';
import 'package:common/features/new_login_register/presentation/notifiers/login_register_page_status_notifier.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MobileNumberInputField extends HookConsumerWidget {
  final String labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode fieldFocusNode;
  final Color? errorColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? hintHeight;
  final VoidCallback? onClearClick;
  final Color? editIconColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? cursorColor;
  final int? maxLength;

  const MobileNumberInputField({
    super.key,
    required this.labelText,
    required this.fieldFocusNode,
    this.controller,
    this.validator,
    this.errorColor,
    this.contentPadding,
    this.hintHeight,
    this.editIconColor,
    this.textColor,
    this.labelColor,
    this.cursorColor,
    this.onClearClick,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var borderWidth = (errorColor == null) ? 0.7 : 2.0;
    var showEditIcon = useState(false);
    var showCrossIcon = useState(false);
    ref.listen(loginRegisterPageNotifierProvider, (previous, next) {
      if (context.mounted) {
        showEditIcon.value =
            (next.value >= LoginRegisterStatesEnum.unableToSendOtp.value);
      }
    });
    return AppInputTextFieldV2(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 17, horizontal: 16.0),
      labelStyle: TextStyles.manropeStyle(16.0,
          color: labelColor ?? ColorUtilsV2.hex_717182),
      readOnly: showEditIcon.value,
      suffixIcon: showEditIcon.value
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: AppIconButton(
                iconColor: editIconColor ?? ColorUtilsV2.hex_4E52F8,
                iconButtonType: AppIconButtonTypeEnum.EDIT,
                onPressed: () {
                  ref
                      .read(loginRegisterPageNotifierProvider.notifier)
                      .updateState(
                          LoginRegisterStatesEnum.otpWillBeSendToMobileNumber);
                  Future.delayed(const Duration(milliseconds: 300), () {
                    if (!fieldFocusNode.hasFocus) {
                      fieldFocusNode.requestFocus();
                    }
                  });
                },
              ),
            )
          : showCrossIcon.value
              ? IconButton(
                  onPressed: () {
                    controller?.clear();
                    showCrossIcon.value = false;
                    onClearClick?.call();
                  },
                  icon:
                      SvgPicture.asset(AssetUtils.icCloseRounded, height: 18.0),
                )
              : null,
      focusNode: fieldFocusNode,
      labelText: labelText,
      hintText: '',
      inputType: TextInputType.number,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      textColor: textColor,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      controller: controller,
      onChanged: (String value) {
        if (value.trim().isNotEmpty) {
          showCrossIcon.value = true;
        } else {
          showCrossIcon.value = false;
        }
      },
      validator: validator,
      cursorColor: cursorColor ?? ColorUtilsV2.hex_35354D,
    );
  }
}
