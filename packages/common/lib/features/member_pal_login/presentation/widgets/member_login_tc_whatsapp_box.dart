// import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/member_pal_login/presentation/providers/member_signup_login_provider.dart';
import 'package:common/features/member_pal_login/presentation/widgets/member_login_check_box_with_title.dart';
import 'package:common/features/member_pal_login/presentation/widgets/member_pal_adult_tc_body.dart';
import 'package:common/features/member_pal_login/presentation/widgets/member_pal_term_condition_body.dart';
import 'package:common/features/member_pal_login/presentation/widgets/member_pal_whatsapp_tc_body.dart';
import 'package:flutter/material.dart';

class MemberLoginTCAndWhatsAppCheckBox extends ConsumerWidget {
  const MemberLoginTCAndWhatsAppCheckBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(memberSignUpLoginProvierProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (loginForm.source == LoginFormEnum.angel.value)
            LoginCheckBoxWithTitle(
              value: loginForm.acceptAdult,
              onChanged: (value) {
                ref
                    .read(memberSignUpLoginProvierProvider.notifier)
                    .setAdult(value!);
              },
              showError: !loginForm.acceptAdult,
              body: const MemberPalAdultTcBody(),
            ),
          LoginCheckBoxWithTitle(
            value: loginForm.acceptTc,
            onChanged: (value) {
              ref.read(memberSignUpLoginProvierProvider.notifier).setTC(value!);
            },
            showError: !loginForm.acceptTc,
            body: const MemberPalTermConditonBody(),
          ),
          LoginCheckBoxWithTitle(
            value: loginForm.acceptWhatsApp,
            onChanged: (value) {
              ref
                  .read(memberSignUpLoginProvierProvider.notifier)
                  .setWhatsApp(value!);
            },
            showError: !loginForm.acceptWhatsApp,
            body: const MemberPalWhatsAppTCBody(),
          ),
        ],
      ),
    );
  }
}
