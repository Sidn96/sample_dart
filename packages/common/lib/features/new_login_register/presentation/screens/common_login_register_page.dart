import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:common/features/new_login_register/presentation/components/login_register_app_bar.dart';
import 'package:common/features/new_login_register/presentation/components/login_register_component.dart';
import 'package:common/features/new_login_register/presentation/components/login_register_header_row_widget.dart';
import 'package:common/features/new_login_register/presentation/components/truefin_welcome_header.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CommonLoginRegisterPage extends StatelessWidget {
  final LoginFormEnum source;
  final bool isLoginFlow;
  final VoidCallback successHandler;
  final Widget? customLoader;
  final String? title;
  final String? subTitle;
  final String? commonAssetImgName;
  final bool needAppbar;
  final bool needTruefinHeader;

  const CommonLoginRegisterPage(
      {super.key,
      required this.source,
      required this.isLoginFlow,
      required this.successHandler,
      this.title,
      this.subTitle,
      this.customLoader,
      this.commonAssetImgName,
      this.needAppbar = false,
      this.needTruefinHeader = false});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.grey.withOpacity(0.3),
      overlayWidgetBuilder: (_) => customLoader ?? const CommonTrueFinLoaderWithBlur(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        //resizeToAvoidBottomInset: false,
        appBar: needAppbar ? const LoginRegisterAppBar() : null,
        body: Stack(
          children: [
            if (needTruefinHeader)
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      AssetUtils.truefinWelcomeBg,
                    )),
              ),
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top),
                //Header with Right Text, subText and Left Image
                if (needTruefinHeader)
                  const TruefinWelcomeHeaderWidget()
                else
                  LoginRegisterHeaderRowWidget(
                    key: key,
                    title: title ??
                        (isLoginFlow
                            ? 'Happy To See\nYou Back'
                            : AppConstants.gettingStarted),
                    subTitle: subTitle ?? 'In one simple step',
                    commonAssetImgName:
                        commonAssetImgName ?? AssetUtils.shortLoginSignUpHeader,
                  ),
                Expanded(
                  child: LoginRegisterComponent(
                    enableAutoFetchMobileNumber: true,
                    changeCTAColor: ColorUtilsV2.specialBackground500,
                    source: source,
                    resendDisableColor: ColorUtilsV2.hex_C3C4FE,
                    resendEnableColor: ColorUtilsV2.hex_4E52F8,
                    successHandler: successHandler,
                    otpTimerColor: ColorUtilsV2.hex_35354D,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
