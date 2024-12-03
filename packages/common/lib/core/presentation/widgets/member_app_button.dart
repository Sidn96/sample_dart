import 'package:common/core/domain/check_internet_connection.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/providers/member_app_button_provider.dart';
import 'package:common/core/presentation/utils/debouncer.dart';
import 'package:common/core/presentation/widgets/toast_custom_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class MemberAngelAppButton extends HookConsumerWidget {
  final bool bttnEnabled;
  final String label;
  final VoidCallback? onSuccessHandler;
  final double? buttonWidth;
  final double buttonHeight;
  final double? fontSize;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? buttonpadding;
  final Color? bgColor;
  final Color? bgDisableColor;
  final Color? textColor;
  final double? borderRadius;

  const MemberAngelAppButton({
    super.key,
    this.alignment,
    this.bttnEnabled = true,
    required this.label,
    this.buttonWidth,
    this.buttonHeight = 46,
    this.buttonpadding,
    this.fontSize,
    this.bgColor,
    this.textColor,
    this.borderRadius,
    this.bgDisableColor,
    this.onSuccessHandler,
  });

  @override
  Widget build(BuildContext context, ref) {
    final debouncer = Debouncer(milliseconds: 200);
    bool isButtonPressed = ref.watch(memberAppButtonPressedProvider);

    void onButtonPressed() async {
      if (isButtonPressed) return;
      ref.read(memberAppButtonPressedProvider.notifier).changeState(true);
      await debouncer.run(() async {
        if (await CheckInternetConnectivity.checkInternetStatus()) {
          onSuccessHandler?.call();
        } else {
          showToastBox(context,
              message: AppConstants.internetCheck, status: ToastStatus.error);
        }
        ref.read(memberAppButtonPressedProvider.notifier).changeState(false);
      });
    }

    return Align(
      alignment: alignment ?? Alignment.center,
      child: SizedBox(
        width: buttonWidth ?? Sizes.screenWidth() * 0.9,
        height: buttonHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.7,
            padding: buttonpadding,
            disabledBackgroundColor: bgDisableColor ?? ColorUtils.lightYellow,
            foregroundColor: bttnEnabled
                ? (bgColor ?? Theme.of(context).primaryColor)
                : (bgColor ?? Theme.of(context).primaryColor).withOpacity(0.4),
            backgroundColor: bttnEnabled
                ? (bgColor ?? Theme.of(context).primaryColor)
                : (bgColor ?? Theme.of(context).primaryColor).withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            ),
          ),
          onPressed: bttnEnabled
              ? () async {
                  debouncer.run(onButtonPressed);
                }
              : null,
          child: AppTextV2(
            data: label,
            fontSize: fontSize ?? 14,
            fontWeight: FontWeight.w600,
            fontColor: bttnEnabled
                ? textColor ?? ColorUtils.bluishblack
                : ColorUtils.kbuttondisableText,
          ),
        ),
        //  AppButton(
        //   label: label,
        //   buttonWidth: buttonWidth ?? Sizes.screenWidth() * 0.9,
        //   borderColor: Colors.transparent,
        // buttonBgColor: bttnEnabled
        //     ? Theme.of(context).primaryColor
        //     : Theme.of(context).primaryColor.withOpacity(0.4),
        // textColor: bttnEnabled
        //     ? ColorUtils.bluishblack
        //     : ColorUtils.kbuttondisableText,
        //   fontSize: 14,
        //   fontWeight: FontWeight.w600,
        //   buttonHeight: buttonHeight,
        //   borderRadius: 4,
        //   onPressed: () {
        // if (bttnEnabled) {
        //   if (debounce?.isActive ?? false) debounce?.cancel();
        //   debounce = Timer(const Duration(milliseconds: 300), () {
        //     onSuccessHandler();
        //   });
        // }
        //   },
        // ),
      ),
    );
  }
}
