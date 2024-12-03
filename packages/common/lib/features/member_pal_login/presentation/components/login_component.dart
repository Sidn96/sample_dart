import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/features/member_pal_login/presentation/widgets/member_login_form_widget.dart';
import 'package:common/features/member_pal_login/presentation/widgets/member_login_tc_whatsapp_box.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class MemberLoginComponent extends StatelessWidget {
  const MemberLoginComponent({
    super.key,
    required this.commingFrom,
    required this.onResendPressed,
    required this.onComplete,
  });

  final LoginFormEnum? commingFrom;
  final Function()? onResendPressed;
  final Function(String)? onComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    data: AppConstants.signupLogin,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.24,
                    fontColor: ColorUtils.blackNeutralColor,
                  ),
                ],
              ),
              24.height,
              MemberLoginFormWidget(
                commingFrom: commingFrom,
                onResendPressed: onResendPressed,
                onComplete: onComplete,
              ),
              // 35.height,
            ],
          ),
        ),
        const MemberLoginTCAndWhatsAppCheckBox(),
      ],
    );
  }
}
