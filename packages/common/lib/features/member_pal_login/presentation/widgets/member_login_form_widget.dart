import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/member_pal_login/presentation/providers/member_signup_login_provider.dart';
import 'package:common/features/member_pal_login/presentation/widgets/member_login_form_otp_field.dart';
import 'package:common/features/member_pal_login/presentation/widgets/resend_otp_and_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemberLoginFormWidget extends HookConsumerWidget {
  final LoginFormEnum? commingFrom;
  final Function()? onResendPressed;
  final Function(String)? onComplete;
  const MemberLoginFormWidget({
    super.key,
    this.commingFrom,
    this.onResendPressed,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = useTextEditingController();
    final loginForm = ref.watch(memberSignUpLoginProvierProvider);
    final phoneController = useTextEditingController();
    final phoneFocus = useFocusNode();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        phoneFocus.requestFocus();
        ref
            .read(memberSignUpLoginProvierProvider.notifier)
            .setSource(commingFrom?.value);
      });
      return;
    }, const []);

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: phoneController,
            focusNode: phoneFocus,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            style: const TextStyle(
              color: ColorUtils.bluishblack,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: "Enter Mobile No.",
              hintStyle: TextStyle(
                  color: ColorUtilsV2.hex_9CA3AF,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              labelText: "Mobile No.",
              labelStyle: TextStyle(
                  color: ColorUtilsV2.hex_9CA3AF, fontWeight: FontWeight.w400),
              prefix: Padding(
                padding: EdgeInsets.only(right: 4),
                child: Text(
                  "+91",
                  style: TextStyle(
                    color: ColorUtils.bluishblack,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorUtils.ffC2C2C9),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorUtils.ffC2C2C9),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorUtils.ffC2C2C9),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
            ),
            onChanged: (value) {
              otpController.clear();
              final String? isValid = validateNumber(value);
              if (isValid == null) {
                // null means its valid
                ref
                    .read(memberSignUpLoginProvierProvider.notifier)
                    .setMobileNumber(value);
              } else {
                // not valid
                ref
                    .read(memberSignUpLoginProvierProvider.notifier)
                    .setMobileNumber("");
              }
            },
            validator: (value) {
              return validateNumber(value);
            },
          ),
          if (validateNumber(phoneController.text) == null &&
              loginForm.isSendOTPPressed == false) ...[
            10.height,
            const AppText(
              data: AppConstants.getAnOTP,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontColor: ColorUtils.orange,
            ),
          ],
          if (loginForm.isSendOTPPressed == true) ...[
            30.height,
            OTPInputField(
              otpController: otpController,
              onComplete: (v) {
                if (loginForm.isCtaChecked()) {
                  onComplete?.call(v);
                }
              },
            ),
            5.height,
            ResendOtpAndTimerWidget(otpController: otpController),
          ],
          30.height,
        ],
      ),
    );
  }

  String? validateNumber(String? value) {
    final RegExp phoneRegex = RegExp(r'^[6-9]\d{9}$');
    if (value!.length <= 9) {
      return "Please enter valid mobile number";
    } else if (!phoneRegex.hasMatch(value)) {
      return "Please enter valid mobile number";
    } else {
      return null;
    }
  }
}
