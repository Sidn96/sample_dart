import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/presentation/extensions/widget_extension.dart';
import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:common/core/presentation/widgets/common_popup_menu_button.dart';
import 'package:common/core/presentation/widgets/image_util.dart';
import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:common/features/login_signup/presentation/screens/retire100_login.dart';
import 'package:common/features/login_signup/presentation/widgets/newlogin_bottomsheet.dart';
import 'package:common/features/new_login_register/presentation/screens/common_login_register_page.dart';
import 'package:common/features/new_login_register/presentation/widgets/login_register_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppHeaderLandingPage extends HookConsumerWidget
    implements PreferredSizeWidget {
  final bool showActionButtons;
  final Function(String)? actionAfterSuccessHandler;
  final LoginFormEnum source;
  final bool showTermsConditionsCTAonLogin;
  final String? subTitle;
  final bool useOldLoginSignUpForm;
  final Function()? onLogout;

  const AppHeaderLandingPage({
    Key? key,
    this.showActionButtons = true,
    this.actionAfterSuccessHandler,
    required this.source,
    this.showTermsConditionsCTAonLogin = true,
    this.subTitle,
    this.useOldLoginSignUpForm = true,
    this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final loginStatus = ref.watch(loginStatusProvider);

    ref.watch(activeFormProviderProvider);
    return PreferredSize(
      preferredSize: Size.fromHeight(Sizes.screenHeight * 0.08),
      child: AppBar(
          elevation: 0,
          backgroundColor: ColorUtils.transparent,
          shadowColor: ColorUtils.transparent,
          surfaceTintColor: ColorUtils.transparent,
          leadingWidth: 80,
          leading: const Padding(
            padding: EdgeInsets.only(left: 12.0, top: 8.0),
            // child: Text('logo here'),
            child: AppImage(
                imgPath: AssetUtils.retire100BlueLogo,
                package: "common",
                showColorFilter: false,
                height: 80),
          ),
          actions: loginStatus.when(
              data: (isAuthenticated) {
                if (!showActionButtons) return null;

                return isAuthenticated
                    ? _getAuthenticatedUserActionButtons(ref, context)
                    : _getUnauthenticatedUserActionButtons(context, ref);
              },
              error: (error, stackTrace) => null,
              loading: () => null)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  List<Widget> _getAuthenticatedUserActionButtons(
      WidgetRef ref, BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          context.pushNamed(CommonRouteString.myProfileRoute);
          //context.goNamed('my-profile');
        },
        icon: ImageUtil.load(AssetUtils.iconUseDummy, width: 36, height: 36),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 18),
        child: AppText(
          data: 'Hi ${ref.read(loginStatusProvider.notifier).getUserName()}',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: CommonPopUpMenuButton(
          initialValue: "",
          items: const ["Logout"],
          callback: (selectedVal) {
            ref.read(loginStatusProvider.notifier).logout();
            onLogout?.call();
          },
        ),
      ),
    ];
  }

  List<Widget> _getUnauthenticatedUserActionButtons(
      BuildContext context, WidgetRef ref) {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 12.0, right: 8.0, bottom: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: unfilledButtonStyle(),
                onPressed: () {
                  if (useOldLoginSignUpForm) {
                    newLoginSignUpBottomSheet(
                        context,
                        Retire100LoginPage(
                          title: "Happy To See\nYou Back",
                          froRegister: true,
                          showLoginHeader: true,
                          source: source,
                          actionAfterSuccessHandler: actionAfterSuccessHandler,
                          subTitle: "In one simple step",
                          showTermsConditionsCTA: showTermsConditionsCTAonLogin,
                        ));
                  } else {
                    loginRegisterBottomSheet(
                      context,
                      CommonLoginRegisterPage(
                        source: source,
                        isLoginFlow: true,
                        successHandler: () {
                          context.pop();
                          ref.invalidate(loginStatusProvider);
                          actionAfterSuccessHandler?.call('');
                        },
                      ),
                    );
                  }
                },
                child: const AppText(
                    data: AppConstants.loginText,
                    fontSize: Sizes.textSize12,
                    fontColor: ColorUtils.kBlueColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: filledButtonStyle(),
                onPressed: () {
                  SecureStorage().deleteAllPref();
                  if (useOldLoginSignUpForm) {
                    newLoginSignUpBottomSheet(
                        context,
                        Retire100LoginPage(
                          froRegister: true,
                          showLoginHeader: true,
                          source: source,
                          actionAfterSuccessHandler: actionAfterSuccessHandler,
                          subTitle: "In one simple step",
                          showTermsConditionsCTA: showTermsConditionsCTAonLogin,
                        ));
                    /*ref
                      .read(activeFormProviderProvider.notifier)
                      .changeActiveIndex(0);
                  newLoginSignUpBottomSheet(
                      context,
                      Retire100SignUpScreen(
                        source: source,
                        subTitle: subTitle,
                      ));*/
                  } else {
                    loginRegisterBottomSheet(
                      context,
                      CommonLoginRegisterPage(
                        source: source,
                        isLoginFlow: false,
                        successHandler: () {
                          context.pop();
                          ref.invalidate(loginStatusProvider);
                          actionAfterSuccessHandler?.call('');
                        },
                      ),
                    );
                  }
                },
                child: const AppText(
                    data: AppConstants.signupText,
                    fontSize: Sizes.textSize12,
                    fontColor: ColorUtils.white,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      )
    ];
  }
}
