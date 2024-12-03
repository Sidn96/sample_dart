import 'package:common/core/presentation/components/app_header.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/utils/snackbar_message.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/new_login_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpSuccessScreen extends HookConsumerWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () async {
        context.pop();
        ref.refresh(loginStatusProvider);
        ref.read(getSnackBarObjectProvider).showSuccessSnackBar(
            message: 'Registered user successfully', context: context);
      });
      return;
    }, []);
    final userName = ref.watch(userNameProvider);
    return Scaffold(
      backgroundColor: ColorUtils.midgray,
      appBar: const AppHeaderLandingPage(showActionButtons: false,source: LoginFormEnum.eldercare,),
      body: Stack(children: [
        Image.asset(
          AssetUtils.dottedPattern,
          package: "common",
          height: 63.39,
          width: 164,
        ),
        const Positioned(
          right: 0.0,
          bottom: 0.0,
          child: AppImage(
            imgPath: AssetUtils.circleImage,
            isSvg: false,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetUtils.welcome,
                package: "common",
                height: 115.17,
                width: 112,
              ),
              const SizedBox(
                height: 15,
              ),
              const AppText(
                data: AppConstants.welcome,
                fontSize: 18,
                fontColor: ColorUtils.kGreyDarkColor,
              ),
              const SizedBox(
                height: 10,
              ),
              AppText(
                data: userName,
                fontSize: 40,
                fontColor: ColorUtils.bluishblack,
              ),
              const SizedBox(
                height: 10,
              ),
              const AppText(
                data: AppConstants.successFull,
                fontSize: 16,
                fontColor: ColorUtils.kTabDisabledTextColor,
              ),
              const SizedBox(
                height: 20,
              ),
              const AppImage(
                imgPath: AssetUtils.logo,
                isSvg: true,
                height: 85,
              ),
              const SizedBox(
                height: 20,
              ),
              const AppText(
                data: AppConstants.trust,
                fontSize: 16,
                fontColor: ColorUtils.kBlackDark,
                fontWeight: FontWeight.w800,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
