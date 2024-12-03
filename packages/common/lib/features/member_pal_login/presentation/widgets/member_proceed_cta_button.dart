import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/features/member_pal_login/presentation/providers/member_signup_login_provider.dart';
import 'package:flutter/material.dart';

class MemberProceedCtaButton extends ConsumerWidget {
  final Function() onProceed;
  const MemberProceedCtaButton({
    super.key,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginData = ref.watch(memberSignUpLoginProvierProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MemberAngelAppButton(
        label: "Proceed",
        bttnEnabled: loginData.hasValidName,
        buttonWidth: double.infinity,
        onSuccessHandler: onProceed,
      ),
    );
  }
}
