import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/login_signup/presentation/widgets/form1_widget.dart';
import 'package:common/features/login_signup/presentation/widgets/form2_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/components/otp_text_field.dart';

class LoginSignUpFormWidget extends HookConsumerWidget {
  const LoginSignUpFormWidget({
    super.key,
    required this.mobileNumberController,
    required this.otpController,
    this.onResendSuccessHandler,
    this.isIndiaOnly,
    required this.dobController,
    required this.fullNameController,
    required this.emailTextEditingController,this.isEmailId,required this.otpCC
  });

  final TextEditingController fullNameController;
  final TextEditingController dobController;
  final TextEditingController mobileNumberController;
  final TextEditingController otpController;
  final Function(String)? onResendSuccessHandler;
  final bool? isIndiaOnly;
  final TextEditingController emailTextEditingController;
  final bool? isEmailId;
  final OtpFieldController otpCC;
  @override
  Widget build(BuildContext context, ref) {
    final activeIndex = ref.watch(activeFormProviderProvider);
    final formList = [
      // signup form
      Form1Widget(
        fullNameController: fullNameController,
        dobController: dobController,
      ),
      // login form
      Form2Widget(
        otpCC: otpCC,
        isEmailId: isEmailId ?? true,
        emailTextEditingController: emailTextEditingController,
        isIndiaOnly: isIndiaOnly,
        mobileNumberController: mobileNumberController,
        otpController: otpController,
        onResendSuccessHandler: onResendSuccessHandler,
      )
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: formList[activeIndex],
    );
  }
}
