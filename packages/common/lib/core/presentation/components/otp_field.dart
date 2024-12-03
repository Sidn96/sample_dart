import 'package:common/core/domain/field_style_enum.dart';
import 'package:common/core/presentation/components/otp_text_field.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPField extends StatelessWidget {
  final OtpFieldController? otpFieldController;
  final TextEditingController? oTPFieldController;
  final Function(String value)? onChanged;
  final Function(String value)? onCompleted;
  final Function()? onResendClick;
  final String? errorText;
  final int? timerCount;
  final bool? resendColorChange;
  final EdgeInsetsGeometry padding;
  final String lable;
  final ValueNotifier<String?>? invalidOtp;
  final bool isOTP;
  final Color? resendEnableColor;
  final Color? resendDisableColor;
  final int? otpLength;
  final Color? otpLabelColor;

  const OTPField(
      {Key? key,
      required this.otpFieldController,
      this.oTPFieldController,
      this.invalidOtp,
      this.onChanged,
      this.onCompleted,
      this.errorText,
      this.onResendClick,
      this.timerCount,
      this.resendColorChange,
      this.lable = AppConstants.enterOtp,
      this.isOTP = false,
      this.padding = const EdgeInsets.only(top: 36.0, left: 19.0),
      this.resendEnableColor,
      this.resendDisableColor,
      this.otpLength, this.otpLabelColor = ColorUtils.kGreyLightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: padding,
              child: AppText(
                data: lable,
                fontSize: Sizes.textSize12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                fontColor: otpLabelColor,
              ),
            ),
            (isOTP)
                ? PinCodeTextField(
                    autoDisposeControllers: false,
                    controller: oTPFieldController,
                    appContext: context,
                    length: otpLength ?? 4,
                    cursorColor: Colors.black,
                    animationDuration: Duration.zero,
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    cursorHeight: 18,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.phone,
                    pinTheme: PinTheme(
                        //fieldWidth: Sizes.screenWidth()* 0.16,
                        fieldWidth: MediaQuery.sizeOf(context).width * 0.20,
                        // fieldOuterPadding: const EdgeInsets.only(left:12,right: 12),
                        inactiveColor: ColorUtils.kGreyLightColor,
                        selectedColor: ColorUtils.kGreyLightColor,
                        activeBorderWidth: 0.5,
                        inactiveBorderWidth: 0.5,
                        selectedBorderWidth: 0.5,
                        shape: PinCodeFieldShape.box,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        activeColor: ColorUtils.kGreyLightColor),
                    onCompleted: onCompleted,
                    onChanged: onChanged,
                  )
                : OTPTextField(
                    onChanged: onChanged,
                    controller: otpFieldController,
                    length: otpLength ?? 4,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      // LengthLimitingTextInputFormatter(10),
                    ],
                    width: Sizes.screenWidth(),
                    fieldWidth:
                        Sizes.screenWidth() / ((otpLength ?? 4) > 4 ? 8 : 6),
                    style: StyleManager.interStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: Sizes.textSize16,
                        textColor: Colors.black),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: onCompleted,
                  ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (invalidOtp?.value != null)
                AppText(
                  data: invalidOtp!.value ?? "",
                  fontSize: Sizes.textSize12,
                  fontColor: ColorUtils.errorColor2,
                  fontWeight: FontWeight.w500,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 3,left: 12),
                  child: AppText(
                    data: errorText ?? "",
                    fontSize: Sizes.textSize12,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    fontColor: ColorUtils.errorColor2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: resendColorChange == false,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 3),
                        child: AppText(
                          data: "00:${timerCount.toString().padLeft(2, '0')}",
                          fontSize: Sizes.textSize12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onResendClick,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 3),
                        child: Text(
                          AppConstants.resendOTP,
                          style: StyleManager.interStyle(
                            textColor: (resendColorChange ?? false)
                                ? resendEnableColor ?? ColorUtils.kBlueColor
                                : resendDisableColor ??
                                    ColorUtils.kBlueLightColor,
                            fontSize: 14,
                            fontWeight: (resendColorChange ?? false)
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
