import 'package:common/core/presentation/components/app_header.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:common/features/login_signup/presentation/widgets/common_login_signup_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShortLogin extends StatelessWidget {
  final bool showAppHeader;
  final LoginFormEnum? source;
  final bool showCloseButton;
  final bool showSignUpLoginHeader;
 // final String
  const ShortLogin(
      {super.key,
        this.showSignUpLoginHeader = true,
      this.showAppHeader = true,
      this.source,
      this.showCloseButton = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppHeader
          ? PreferredSize(
              preferredSize: Size.fromHeight(Sizes.screenHeight * 0.08),
              child: Stack(
                children: [
                  AppHeaderLandingPage(
                      showActionButtons: false,
                      source: source ?? LoginFormEnum.eldercare),
                  if (showCloseButton)
                    Positioned(
                      top: 20,
                      right: 0,
                      child: InkWell(
                        onTap: () => context.pop(),
                        child: const AppImage(
                          imgPath: AssetUtils.closeIcon,
                          height: 16,
                          width: 16,
                          iconColor: ColorUtils.black,
                        ),
                      ),
                    ),
                ],
              ))
          : null,
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      ],),
    );
  }
}
