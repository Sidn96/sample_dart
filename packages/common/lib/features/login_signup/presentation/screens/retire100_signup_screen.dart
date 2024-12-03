import 'package:common/core/presentation/components/app_header.dart';
import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/snackbar_message.dart';
import 'package:common/features/login_signup/domain/send_otp_request_dto.dart';
import 'package:common/features/login_signup/infrastructure/data_sources/login_remote_data_source.dart';
import 'package:common/features/login_signup/infrastructure/repo/login_repo.dart';
import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:common/features/login_signup/presentation/providers/signup_provider.dart';
import 'package:common/features/login_signup/presentation/screens/retire100_login.dart';
import 'package:common/features/login_signup/presentation/widgets/common_login_signup_header.dart';
import 'package:common/features/login_signup/presentation/widgets/login_signup_cta_button.dart';
import 'package:common/features/login_signup/presentation/widgets/login_signup_form_widget.dart';
import 'package:common/features/login_signup/presentation/widgets/newlogin_bottomsheet.dart';
import 'package:common/features/login_signup/presentation/widgets/term_condition_cta.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/presentation/components/otp_text_field.dart';
import '../providers/notifiers/new_login_notifiers.dart';

class Retire100SignUpScreen extends HookConsumerWidget {
  const Retire100SignUpScreen({
    super.key,
    this.onOTPSuccessHandler,
    this.onSubmitSuccessHandler,
    this.onResendOTPSuccessHandler,
    this.actionAfterSuccessHandler,
    this.showHeader = true,
    this.title,
    this.subTitle,
    this.imagePath,
    this.package,
    this.source,
    this.isIndiaOnly,
    this.showClose = true,
    this.isPage = false,
    this.mobileNum,
    this.isEmailId,
    this.customLoader,
  });

  final Function(String mobileNumber)? onOTPSuccessHandler;
  final Function(String mobileNumber)? onResendOTPSuccessHandler;
  final Function(String otp, String mobileNumber)? onSubmitSuccessHandler;
  final Function()? actionAfterSuccessHandler;
  final bool showHeader;
  final String? title;
  final String? subTitle;
  final String? imagePath;
  final String? package;
  final bool? isIndiaOnly;
  final bool? isEmailId;
  final bool showClose;
  final LoginFormEnum? source;
  final bool? isPage;
  final TextEditingController? mobileNum;
  final Widget? customLoader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print("Retire100 signup page loaded");
    final loader = ref.watch(startLoadingProvider);
    final mobileNumberController = useTextEditingController();
    final otpController = useTextEditingController();
    final iAcceptTC = useState<bool>(true);
    final isWhatApp = useState<bool>(true);
    final loginSignHandler = ref.watch(loginSignRepoProvider);
    final fullNameController = useTextEditingController();
    final dobController = useTextEditingController();
    final emailTextEditingController = useTextEditingController();
    final otpCC = OtpFieldController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: showHeader
          ? PreferredSize(
              preferredSize: Size.fromHeight(Sizes.screenHeight * 0.08),
              child: Stack(
                children: [
                  AppHeaderLandingPage(
                      showActionButtons: false,
                      source: source ?? LoginFormEnum.eldercare),
                  if (showClose)
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
      body: Stack(
        children: [
          const Positioned(
            right: 0.0,
            bottom: 0.0,
            child: AppImage(imgPath: AssetUtils.yellowCurve, isSvg: false),
          ),
          Column(
            children: [
              if (showHeader) ...[
                CommonLoginSignUpHeader(
                  subTitle: subTitle,
                  title: title,
                  imagePath: imagePath,
                  package: package,
                ),
              ],
              const SizedBox(height: 20),
              Expanded(
                child: LoginSignUpFormWidget(
                  otpCC: otpCC,
                  isEmailId: isEmailId,
                  emailTextEditingController: emailTextEditingController,
                  isIndiaOnly: isIndiaOnly,
                  mobileNumberController: mobileNumberController,
                  otpController: otpController,
                  onResendSuccessHandler: (otpController) async {
                    if (onResendOTPSuccessHandler != null) {
                      onResendOTPSuccessHandler!(mobileNumberController.text);
                    } else {
                      SendOtpRequestBodyDto requestBodyDto =
                          SendOtpRequestBodyDto(
                              reference: mobileNumberController.text,
                              countryCode: "+91",
                              referenceType: "contactno",
                              source: source);
                      await loginSignHandler.sendOtpRepo(requestBodyDto);
                    }
                  },
                  fullNameController: fullNameController,
                  dobController: dobController,
                ),
              ),
              Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0,
                  child: TermConditionCta(
                      iAcceptTC: iAcceptTC, isWhatApp: isWhatApp)),
              LoginSignupCtaButton(
                dobController: dobController,
                fullNameController: fullNameController,
                onGetOtpPressed: () async {
                  ref
                      .read(mobileNumberCheckerProvider.notifier)
                      .changeActiveState("");
                  if (onOTPSuccessHandler != null) {
                    onOTPSuccessHandler!(mobileNumberController.text);
                  } else {
                    context.loaderOverlay.show();
                    final result = await ref
                        .read(sendOTPNotifierProvider.notifier)
                        .sendSignUpOTP(source ?? LoginFormEnum.eldercare,
                            mobileNumberController.text,
                            userAlreadyExist: (userDetails) {
                      if (userDetails == "User already exists") {
                        ref
                            .read(alreadyUserNotifierProvider.notifier)
                            .alreadyUserMessage("User Already exists");
                        ref.read(getSnackBarObjectProvider).showSuccessSnackBar(
                            message:
                                'Your Already A TrueFin User Please Login',
                            context: context);
                        context.pop();
                        newLoginSignUpBottomSheet(
                            context,
                            Retire100LoginPage(
                              showLoginHeader: true,
                              source: source ?? LoginFormEnum.eldercare,
                            ));
                      }
                    });
                    if (result.status == 200) {
                      context.loaderOverlay.hide();
                      ref
                          .read(showSendOtpProvider.notifier)
                          .changeActiveState(true);
                    }
                  }
                },
                onSubmitSuccessHandler: () async {
                  if (onSubmitSuccessHandler != null) {
                    onSubmitSuccessHandler!(
                        otpController.text, mobileNumberController.text);
                  } else {
                    context.loaderOverlay.show();
                    final result = await ref
                        .read(signUpNotifierProvider.notifier)
                        .signupProcess(
                            source ?? LoginFormEnum.eldercare,
                            otpController.text,
                            fullNameController.text,
                            mobileNumberController.text,
                            emailTextEditingController.text,
                            otpInvalid: (signupError) {
                      if (signupError ==
                          "The OTP entered is incorrect. Please enter the correct OTP") {
                        context.loaderOverlay.hide();
                        ref
                            .read(sendOtpErrorNotifierProvider.notifier)
                            .sendOtpErrorMessage(
                                "Make sure you entered correct OTP");
                        ref
                            .read(enableCtaButtonProvider.notifier)
                            .changeActiveState(false);
                      } else if (signupError == "User already exists") {
                        if (isPage == true) {
                          context.pop();
                          mobileNum?.clear();
                          ref
                              .read(loginEnableCtaButtonProvider.notifier)
                              .changeActiveState(false);
                          ref
                              .read(loginEnableCtaButtonTextProvider.notifier)
                              .changeActiveState(AppConstants.next);
                          ref.read(getSnackBarObjectProvider).showSuccessSnackBar(
                              message:
                                  'Your Already A Retire 100 User Please Login',
                              context: context);
                        } else {
                          context.pop();
                          ref.read(getSnackBarObjectProvider).showSuccessSnackBar(
                              message:
                                  'Your Already A Retire 100 User Please Login',
                              context: context);
                          newLoginSignUpBottomSheet(
                              context,
                              Retire100LoginPage(
                                showLoginHeader: true,
                                source: source ?? LoginFormEnum.eldercare,
                              ));
                        }
                      }
                    });
                    if (result) {
                      if (context.mounted) {
                        context.loaderOverlay.hide();
                        context.pop();
                      }

                      //ref.refresh(loginStatusProvider);
                      await ref
                          .read(loginSignUpDataSourceProvider)
                          .getMemberInfo();
                      if (actionAfterSuccessHandler != null) {
                        actionAfterSuccessHandler!();
                      } else {
                        if (context.mounted) {
                          context.pushNamed(CommonRouteString
                              .successSignupRoute);
                        }
                      }
                    }
                  }
                },
                iAcceptTC: iAcceptTC,
              ),
              const SizedBox(height: 10),
            ],
          ),
          if (loader)
            Container(
              color: Colors.black12,
              width: Sizes.screenWidth(),
              height: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
