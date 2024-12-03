import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class ApiErrorWidget extends StatelessWidget {
  final Function() onSuccessHandler;
  const ApiErrorWidget({super.key, required this.onSuccessHandler});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 50,
              color: ColorUtils.errorColor2,
            ),
            const SizedBox(height: 20),
            const AppText(
              data: "Something went wrong\nplease try again",
              height: 1.4,
              fontSize: 18,
            ),
            const SizedBox(height: 20),
            MemberAngelAppButton(
              buttonWidth: 100,
              buttonHeight: 36,
              bgColor: ColorUtilsV2.hex_4E52F8,
              textColor: ColorUtilsV2.hex_FFFFFF,
              label: "Retry",
              onSuccessHandler: onSuccessHandler,
            )
          ],
        ),
      ),
    );
  }
}
