import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/features/new_login_register/presentation/screens/common_login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonLoginWrapperScreen extends StatelessWidget {
  const CommonLoginWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CommonLoginRegisterPage(
        source: LoginFormEnum.truefin,
        isLoginFlow: true,
        needTruefinHeader: true,
        successHandler: () {
          // print("success handler called");
          context.go("/");
        },
        needAppbar: false,
      ),
    );
  }
}
