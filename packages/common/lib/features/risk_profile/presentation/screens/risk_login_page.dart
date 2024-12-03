import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/features/new_login_register/presentation/components/login_register_component.dart';
import 'package:flutter/material.dart';

class RiskLoginPage extends StatelessWidget {
  final VoidCallback onPostApiCalled;

  const RiskLoginPage({super.key, required this.onPostApiCalled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 28.0, left: 20, bottom: 8),
            child: AppTextV2(
              data: 'Provide the details below',
              fontSize: Sizes.textSize12,
              fontColor: ColorUtilsV2.neutral600,
            ),
          ),
          Expanded(
            child: LoginRegisterComponent(
              showSpaceFromTop: false,
              source: LoginFormEnum.nps,
              successHandler: () {
                onPostApiCalled.call();
              },
              labelText: AppConstants.mobileNumber,
            ),
          )
        ],
      ),
    );
  }
}
