import 'dart:io';

import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/features/login_signup/domain/send_otp_request_dto.dart';
import 'package:common/features/login_signup/infrastructure/data_sources/login_remote_data_source.dart';
import 'package:common/features/login_signup/infrastructure/repo/login_repo.dart';
import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/new_login_notifiers.dart';
import 'package:common/features/login_signup/presentation/providers/signup_provider.dart';
import 'package:common/features/login_signup/presentation/widgets/loginform_btn.dart';
import 'package:common/features/login_signup/presentation/widgets/term_condition_cta.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/presentation/components/new_phoneNo_textfield.dart';

const checkScreenHeight = 714;

class Retire100LoginPage extends HookConsumerWidget {
  final Function(String mobileNumber)? onResendOTPSuccessHandler;

  final Function(String otp, String mobileNumber)? onSubmitSuccessHandler;
  final Function(String mobileNumber)? onOTPSuccessHandler;
  final Function(String mobileNumber)? actionAfterSuccessHandler;
  final bool showClose;
  final bool showTruePalClose;
  final bool showClosSignUp;
  final LoginFormEnum? source;
  final bool isLoginPop;
  final bool isPage;
  final bool froRegister;
  final Widget? customLoader;
  final bool showLoginHeader;
  final bool showAppHeader;
  final bool isAdultPalCheckbox;
  final Color? darkColor;
  final Color? lightColor;
  final Color? borderedColor;
  final Color? getOTPMessage;
  final Color? textColor;
  final Color? textLightColor;
  final Color? textDarkColor;
  final Color? checkBoxColor;
  final Color? checkBoxBorderColor;
  final FontWeight? buttonFontWeight;
  final double? buttonHeight;
  final bool showTermsConditionsCTA;
  final String? subTitle;
  final String? title;
  final double? countryFlagHeight;
  final double? countryIndianCodeFontSize;
  final EdgeInsetsGeometry? countryIndianCodePadding;
  final Color? resendEnableColor;
  final Color? resendDisableColor;
  final bool isSignLoginText;
  final bool enableInteractiveSelection;
  final String? termAndConditionsContent;
  final String? legalDisclaimerContent;
  final String? privacyPolicyContent;
  final String? termAndConditionsContentHeader;
  final String? privacyPolicyContentHeader;
  final String? legalDisclaimerContentHeader;
  final String appName;
  final Function()? onResendEventFunction;
  final Function()? onsendOtpEventFunction;
  const Retire100LoginPage({
    super.key,
    this.showTruePalClose = false,
    this.privacyPolicyContentHeader,
    this.legalDisclaimerContentHeader,
    this.termAndConditionsContentHeader,
    this.termAndConditionsContent,
    this.legalDisclaimerContent,
    this.privacyPolicyContent,
    this.countryIndianCodeFontSize,
    this.countryFlagHeight,
    this.checkBoxColor,
    this.checkBoxBorderColor,
    this.buttonHeight,
    this.buttonFontWeight,
    this.getOTPMessage,
    this.darkColor,
    this.borderedColor,
    this.lightColor,
    this.textColor,
    this.textDarkColor,
    this.textLightColor,
    this.onResendOTPSuccessHandler,
    this.countryIndianCodePadding,
    this.isAdultPalCheckbox = false,
    this.onSubmitSuccessHandler,
    this.onOTPSuccessHandler,
    this.actionAfterSuccessHandler,
    this.showClose = true,
    this.showClosSignUp = true,
    this.source,
    this.isLoginPop = true,
    this.isPage = false,
    this.froRegister = false,
    this.showAppHeader = true,
    this.customLoader,
    this.showLoginHeader = false,
    this.showTermsConditionsCTA = true,
    this.subTitle,
    this.title = AppConstants.gettingStarted,
    this.resendEnableColor,
    this.resendDisableColor,
    this.appName = "retire100",
    this.enableInteractiveSelection = false,
    this.isSignLoginText = false,
    this.onResendEventFunction,
    this.onsendOtpEventFunction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iAcceptTC = useState<bool>(true);
    final isWhatApp = useState<bool>(true);
    final isAdult = useState<bool>(true);
    final mobileNumberController = useTextEditingController();
    final otpController = useTextEditingController();
    final loginSignHandler = ref.watch(loginSignRepoProvider);
    final errorController = useStreamController<ErrorAnimationType>();
    final showOtp = ref.watch(loginShowSendOtpProvider);
    final mobileNumChecker = ref.watch(mobileNumberCheckerProvider);
    final buttonText = ref.watch(loginEnableCtaButtonTextProvider);

    final invalidOTPMessagae = ref.watch(sendOtpErrorNotifierProvider);
    final enableResend = useState<bool>(false);
    final counterTime = useState<int>(30);
    bool isSmallDevice = Sizes.screenHeight < checkScreenHeight;
    print('MediaQuery ${Sizes.screenHeight}');
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black.withOpacity(0.75),
      overlayWidgetBuilder: (_) => customLoader ??
          const Center(
            child: CircularProgressIndicator(),
          ),
      child: Scaffold(
        bottomNavigationBar: (!isSmallDevice || !showOtp)
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  // height: isAdultPalCheckbox ? 170 : 140,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                          visible: showTermsConditionsCTA &&
                              MediaQuery.of(context).viewInsets.bottom == 0,
                          child: TermConditionCta(
                              termAndConditionsContentHeader:
                                  termAndConditionsContentHeader,
                              legalDisclaimerContentHeader:
                                  legalDisclaimerContentHeader,
                              privacyPolicyContentHeader:
                                  privacyPolicyContentHeader,
                              termAndConditionsContent:
                                  termAndConditionsContent,
                              legalDisclaimerContent: legalDisclaimerContent,
                              privacyPolicyContent: privacyPolicyContent,
                              errorMessage: !iAcceptTC.value
                                  ? AppConstants.mandatoryCheckBoxSelection
                                  : "",
                              adultErrorMessage: !isAdult.value
                                  ? AppConstants.mandatoryCheckBoxSelection
                                  : "",
                              whatsAppErrorMessage: !isWhatApp.value
                                  ? AppConstants.mandatoryCheckBoxSelection
                                  : "",
                              otpController: otpController,
                              checkBoxBorderColor: checkBoxBorderColor,
                              checkBoxColor: checkBoxColor,
                              isAdultPalCheckbox: isAdultPalCheckbox,
                              isAdult: isAdult,
                              iAcceptTC: iAcceptTC,
                              isWhatApp: isWhatApp)),
                      LoginFormBTN(
                          buttonHeight: buttonHeight,
                          buttonFontWeight: buttonFontWeight,
                          textDarkColor: textDarkColor,
                          textLightColor: textLightColor,
                          textColor: textColor,
                          borderColor: borderedColor,
                          darkColor: darkColor,
                          lightColor: lightColor,
                          isAdultCheckbox: isAdultPalCheckbox,
                          onSubmitSuccessHandler: () async {
                            context.loaderOverlay.show();
                            if (onSubmitSuccessHandler != null) {
                              onSubmitSuccessHandler!(otpController.text,
                                  mobileNumberController.text);
                            } else {
                              final result = await ref
                                  .read(commonSignInProvider.notifier)
                                  .sigIn(
                                      source ?? LoginFormEnum.eldercare,
                                      otpController.text,
                                      mobileNumberController.text,
                                      froRegister,
                                      appName, noRecordFound: (noRecordFound) {
                                if (noRecordFound ==
                                    AppConstants.noRecordFound) {
                                  if (isLoginPop && context.canPop()) {
                                    context.pop();
                                  }
                                } else if (noRecordFound.isNotNullNorEmpty()) {
                                  //Show Error Message that comes from API
                                  // context.loaderOverlay.hide();
                                  errorController.add(ErrorAnimationType.shake);
                                  ref
                                      .read(
                                          sendOtpErrorNotifierProvider.notifier)
                                      .sendOtpErrorMessage(noRecordFound!);
                                }
                              });
                              if (result) {
                                if (context.mounted) {
                                  // context.loaderOverlay.hide();

                                  if (actionAfterSuccessHandler != null) {
                                    actionAfterSuccessHandler!(
                                        mobileNumberController.text);
                                  } else {
                                    if (context.canPop()) context.pop();
                                  }
                                  if (isLoginPop && context.canPop()) {
                                    context.pop();
                                  }
                                  ref.refresh(loginStatusProvider);
                                  await ref
                                      .read(loginSignUpDataSourceProvider)
                                      .getMemberInfo();
                                }
                              } else {
                                if (context.mounted) {
                                  // context.loaderOverlay.hide();
                                  ref
                                      .read(
                                          loginEnableCtaButtonProvider.notifier)
                                      .changeActiveState(false);
                                }
                              }
                            }
                            if (context.mounted) {
                              context.loaderOverlay.hide();
                            }
                          },
                          onGetOtpPressed: () async {
                            if (onOTPSuccessHandler != null) {
                              onOTPSuccessHandler!(mobileNumberController.text);
                            } else {
                              context.loaderOverlay.show();
                              SendOtpRequestBodyDto requestBodyDto =
                                  SendOtpRequestBodyDto(
                                      reference: mobileNumberController.text,
                                      countryCode: AppConstants.mobileNoPrefix,
                                      referenceType: AppConstants.contactNo,
                                      source: source);
                              final result = await loginSignHandler
                                  .sendOtpRepo(requestBodyDto);
                              ref
                                  .read(loginShowSendOtpProvider.notifier)
                                  .changeActiveState(true);
                              if (result.status != 200) {
                                if (actionAfterSuccessHandler == null) {
                                  if (context.mounted) context.pop();
                                }
                              }
                              if (context.mounted) {
                                context.loaderOverlay.hide();
                              }
                            }
                          },
                          // otpController: otpController,
                          iAcceptTC: iAcceptTC,
                          isAdult: isAdult,
                          isWhatApp: isWhatApp,
                          mobileNumberController: mobileNumberController),
                      // const SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!kIsWeb && showTruePalClose && Platform.isAndroid)
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        context.pop();
                      },
                      child: const SizedBox(
                        height: 48,
                        width: 48,
                        child: Center(
                          child: AppImage(
                            imgPath: AssetUtils.truePAlCloseIcon,
                            height: 16,
                            width: 16,
                            iconColor: ColorUtils.kGreyBorderColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: showTruePalClose
                      ? const EdgeInsets.only(left: 22, right: 22)
                      : const EdgeInsets.only(top: 16, left: 22, right: 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: isSignLoginText,
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: AppText(
                              data: AppConstants.loginSignText,
                              fontSize: 22,
                              fontColor: ColorUtils.bluishblack,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      NewPhoneNoTextField(
                        countryIndianCodePadding: countryIndianCodePadding,
                        countryIndianCodeFontSize: countryIndianCodeFontSize,
                        countryFlagHeight: countryFlagHeight,
                        headerValue: AppConstants.mobileNoHeader,
                        enableBottomSpacing: false,
                        phoneNoController: mobileNumberController,
                        enableInteractiveSelection: enableInteractiveSelection,
                        contentPadding:
                            const EdgeInsets.only(right: 2, bottom: 8),
                        onChanged: (value) {
                          if (value.length == 10) {
                            final result = ref
                                .read(mobileNumberCheckerProvider.notifier)
                                .mobileRegex(mobileNumberController.text);

                            if (result) {
                              ref
                                  .read(loginEnableCtaButtonProvider.notifier)
                                  .changeActiveState(true);
                              ref
                                  .read(
                                      loginEnableCtaButtonTextProvider.notifier)
                                  .changeActiveState(AppConstants.sendOTP);
                            }
                          } else {
                            if (otpController.text.isNotEmpty) {
                              otpController.clear();
                            }

                            ref
                                .read(mobileNumberCheckerProvider.notifier)
                                .mobileRegex(mobileNumberController.text);

                            ref
                                .read(loginEnableCtaButtonProvider.notifier)
                                .changeActiveState(false);
                            ref
                                .read(loginEnableCtaButtonTextProvider.notifier)
                                .changeActiveState(AppConstants.next);
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: AppText(
                          data: (buttonText == AppConstants.submit)
                              ? ""
                              : mobileNumChecker,
                          fontSize: 12,
                          fontColor: mobileNumChecker ==
                                  AppConstants.getOtpOnNumMessage
                              ? getOTPMessage ?? ColorUtils.kYellowColor
                              : ColorUtils.errorColor,
                        ),
                      ),
                      if (showOtp && buttonText == AppConstants.submit) ...[
                        const SizedBox(height: 20),
                        const AppText(
                          data: AppConstants.enterOtpMessage,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontColor: ColorUtils.greyLight,
                        ),
                        PinCodeTextField(
                          autoDisposeControllers: false,
                          appContext: context,
                          length: 4,
                          cursorColor: Colors.black,
                          animationDuration: Duration.zero,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                          cursorHeight: 18,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: !kIsWeb && Platform.isIOS
                              ? const TextInputType.numberWithOptions(
                                  signed: true, decimal: true)
                              : TextInputType.number,
                          textInputAction: TextInputAction.done,
                          pinTheme: PinTheme(
                              fieldWidth: Sizes.screenWidth() * 0.18,
                              //fieldWidth: MediaQuery.sizeOf(context).width * 0.20,
                              // fieldOuterPadding: const EdgeInsets.only(left:12,right: 12),
                              inactiveColor: ColorUtils.kGreyLightColor,
                              selectedColor: ColorUtils.kGreyLightColor,
                              activeBorderWidth: 0.5,
                              inactiveBorderWidth: 0.5,
                              selectedBorderWidth: 0.5,
                              shape: PinCodeFieldShape.underline,
                              activeColor: ColorUtils.kGreyLightColor,
                              errorBorderColor: ColorUtils.errorColor,
                              errorBorderWidth: 1),
                          errorAnimationController: errorController,
                          controller: otpController,
                          onCompleted: (pin) async {
                            onsendOtpEventFunction?.call();
                            otpController.text = pin;
                            if (isAdultPalCheckbox) {
                              if (iAcceptTC.value &&
                                  isAdult.value &&
                                  isWhatApp.value) {
                                context.loaderOverlay.show();
                                ref
                                    .read(loginEnableCtaButtonProvider.notifier)
                                    .changeActiveState(true);
                                final result = await ref
                                    .read(commonSignInProvider.notifier)
                                    .sigIn(
                                        source ?? LoginFormEnum.eldercare,
                                        otpController.text,
                                        mobileNumberController.text,
                                        froRegister,
                                        appName,
                                        noRecordFound: (noRecordFound) {
                                  if (noRecordFound ==
                                      AppConstants.noRecordFound) {
                                    if (isLoginPop && context.canPop()) {
                                      context.pop();
                                    }
                                  } else if (noRecordFound
                                      .isNotNullNorEmpty()) {
                                    //Show Error Message that comes from API
                                    // context.loaderOverlay.hide();
                                    errorController
                                        .add(ErrorAnimationType.shake);
                                    ref
                                        .read(sendOtpErrorNotifierProvider
                                            .notifier)
                                        .sendOtpErrorMessage(noRecordFound!);
                                    ref
                                        .read(loginEnableCtaButtonProvider
                                            .notifier)
                                        .changeActiveState(false);
                                  }
                                });
                                if (result) {
                                  if (context.mounted) {
                                    // context.loaderOverlay.hide();

                                    if (actionAfterSuccessHandler != null) {
                                      actionAfterSuccessHandler!(
                                          mobileNumberController.text);
                                    } else {
                                      if (context.canPop()) {
                                        context.pop();
                                      }
                                    }
                                    if (isLoginPop && context.canPop()) {
                                      context.pop();
                                    }

                                    ref.refresh(loginStatusProvider);
                                    await ref
                                        .read(loginSignUpDataSourceProvider)
                                        .getMemberInfo();
                                  }
                                }
                                if (context.mounted) {
                                  context.loaderOverlay.hide();
                                }
                              }
                            } else {
                              if (iAcceptTC.value) {
                                context.loaderOverlay.show();
                                ref
                                    .read(loginEnableCtaButtonProvider.notifier)
                                    .changeActiveState(true);
                                final result = await ref
                                    .read(commonSignInProvider.notifier)
                                    .sigIn(
                                        source ?? LoginFormEnum.eldercare,
                                        otpController.text,
                                        mobileNumberController.text,
                                        froRegister,
                                        appName,
                                        noRecordFound: (noRecordFound) {
                                  if (noRecordFound ==
                                      AppConstants.noRecordFound) {
                                    if (isLoginPop && context.canPop()) {
                                      context.pop();
                                    }
                                  } else if (noRecordFound
                                      .isNotNullNorEmpty()) {
                                    //Show Error Message that comes from API
                                    // context.loaderOverlay.hide();
                                    errorController
                                        .add(ErrorAnimationType.shake);
                                    ref
                                        .read(sendOtpErrorNotifierProvider
                                            .notifier)
                                        .sendOtpErrorMessage(noRecordFound!);
                                    ref
                                        .read(loginEnableCtaButtonProvider
                                            .notifier)
                                        .changeActiveState(false);
                                  }
                                });
                                if (result) {
                                  if (context.mounted) {
                                    // context.loaderOverlay.hide();

                                    if (actionAfterSuccessHandler != null) {
                                      actionAfterSuccessHandler!(
                                          mobileNumberController.text);
                                    } else {
                                      if (context.canPop()) {
                                        context.pop();
                                      }
                                    }
                                    if (isLoginPop && context.canPop()) {
                                      context.pop();
                                    }

                                    ref.refresh(loginStatusProvider);
                                    await ref
                                        .read(loginSignUpDataSourceProvider)
                                        .getMemberInfo();
                                  }
                                }
                                if (context.mounted) {
                                  context.loaderOverlay.hide();
                                }
                              }
                            }
                          },
                          onChanged: (value) {
                            if (value.length < 4) {
                              ref
                                  .read(loginEnableCtaButtonProvider.notifier)
                                  .changeActiveState(false);
                              final showOtpErrorMsg = ref
                                  .read(sendOtpErrorNotifierProvider.notifier);
                              showOtpErrorMsg.sendOtpErrorMessage("");
                            }
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7.5),
                                child: AppText(
                                  data: invalidOTPMessagae ?? "",
                                  fontSize: 12,
                                  fontColor: ColorUtils.errorColor,
                                  textAlign: TextAlign.left,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            TweenAnimationBuilder<Duration>(
                              key: ValueKey(counterTime.value),
                              duration: const Duration(seconds: 30),
                              tween: Tween(
                                  begin: const Duration(seconds: 31),
                                  end: Duration.zero),
                              onEnd: () {
                                enableResend.value = true;
                              },
                              builder: (BuildContext context, Duration value,
                                  Widget? child) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7.4),
                                  child: AppText(
                                    data: value.inSeconds == 0
                                        ? ""
                                        : "${formatedTime(time: value.inSeconds)}",
                                    fontSize: 14,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 28,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(50, 30),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft),
                                onPressed: () async {
                                  if (enableResend.value) {
                                    counterTime.value = counterTime.value + 1;
                                    enableResend.value = false;
                                    otpController.clear();
                                    final showOtpErrorMsg = ref.read(
                                        sendOtpErrorNotifierProvider.notifier);
                                    showOtpErrorMsg.sendOtpErrorMessage("");
                                    ref
                                        .read(loginEnableCtaButtonProvider
                                            .notifier)
                                        .changeActiveState(false);
                                    onResendEventFunction?.call();
                                    SendOtpRequestBodyDto requestBodyDto =
                                        SendOtpRequestBodyDto(
                                            reference:
                                                mobileNumberController.text,
                                            countryCode:
                                                AppConstants.mobileNoPrefix,
                                            referenceType:
                                                AppConstants.contactNo,
                                            source: source);
                                    final result = await loginSignHandler
                                        .sendOtpRepo(requestBodyDto);
                                    if (result.status == 200) {
                                    } else {
                                      if (context.mounted) {
                                        context.pushNamed(
                                            CommonRouteString.loginSignupRoute);
                                      }
                                    }
                                  }
                                },
                                child: AppText(
                                  data: AppConstants.resendOTP,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontColor: enableResend.value
                                      ? resendEnableColor ??
                                          ColorUtils.kBlueColor
                                      : resendDisableColor ??
                                          ColorUtils.disabledColor,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            )
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
                // if (Sizes.screenHeight < checkScreenHeight) ...[
                if (isSmallDevice && showOtp) ...[
                  SizedBox(height: Sizes.screenHeight * 0.08),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: isAdultPalCheckbox ? 170 : 140,
                      child: Column(
                        children: [
                          Visibility(
                              visible: showTermsConditionsCTA &&
                                  MediaQuery.of(context).viewInsets.bottom == 0,
                              child: TermConditionCta(
                                  termAndConditionsContentHeader:
                                      termAndConditionsContentHeader,
                                  legalDisclaimerContentHeader:
                                      legalDisclaimerContentHeader,
                                  privacyPolicyContentHeader:
                                      privacyPolicyContentHeader,
                                  termAndConditionsContent:
                                      termAndConditionsContent,
                                  legalDisclaimerContent:
                                      legalDisclaimerContent,
                                  privacyPolicyContent: privacyPolicyContent,
                                  errorMessage: !iAcceptTC.value
                                      ? AppConstants.mandatoryCheckBoxSelection
                                      : "",
                                  adultErrorMessage: !isAdult.value
                                      ? AppConstants.mandatoryCheckBoxSelection
                                      : "",
                                  whatsAppErrorMessage: !isWhatApp.value
                                      ? AppConstants.mandatoryCheckBoxSelection
                                      : "",
                                  otpController: otpController,
                                  checkBoxBorderColor: checkBoxBorderColor,
                                  checkBoxColor: checkBoxColor,
                                  isAdultPalCheckbox: isAdultPalCheckbox,
                                  isAdult: isAdult,
                                  iAcceptTC: iAcceptTC,
                                  isWhatApp: isWhatApp)),
                          LoginFormBTN(
                              buttonHeight: buttonHeight,
                              buttonFontWeight: buttonFontWeight,
                              textDarkColor: textDarkColor,
                              textLightColor: textLightColor,
                              textColor: textColor,
                              borderColor: borderedColor,
                              darkColor: darkColor,
                              lightColor: lightColor,
                              isAdultCheckbox: isAdultPalCheckbox,
                              onSubmitSuccessHandler: () async {
                                context.loaderOverlay.show();
                                if (onSubmitSuccessHandler != null) {
                                  onSubmitSuccessHandler!(otpController.text,
                                      mobileNumberController.text);
                                } else {
                                  final result = await ref
                                      .read(commonSignInProvider.notifier)
                                      .sigIn(
                                          source ?? LoginFormEnum.eldercare,
                                          otpController.text,
                                          mobileNumberController.text,
                                          froRegister,
                                          appName,
                                          noRecordFound: (noRecordFound) {
                                    if (noRecordFound ==
                                        AppConstants.noRecordFound) {
                                      if (isLoginPop && context.canPop()) {
                                        context.pop();
                                      }
                                    } else if (noRecordFound
                                        .isNotNullNorEmpty()) {
                                      //Show Error Message that comes from API
                                      // context.loaderOverlay.hide();
                                      errorController
                                          .add(ErrorAnimationType.shake);
                                      ref
                                          .read(sendOtpErrorNotifierProvider
                                              .notifier)
                                          .sendOtpErrorMessage(noRecordFound!);
                                    }
                                  });
                                  if (result) {
                                    if (context.mounted) {
                                      // context.loaderOverlay.hide();

                                      if (actionAfterSuccessHandler != null) {
                                        actionAfterSuccessHandler!(
                                            mobileNumberController.text);
                                      } else {
                                        if (context.canPop()) context.pop();
                                      }
                                      if (isLoginPop && context.canPop()) {
                                        context.pop();
                                      }
                                      ref.refresh(loginStatusProvider);
                                      await ref
                                          .read(loginSignUpDataSourceProvider)
                                          .getMemberInfo();
                                    }
                                  } else {
                                    if (context.mounted) {
                                      // context.loaderOverlay.hide();
                                      ref
                                          .read(loginEnableCtaButtonProvider
                                              .notifier)
                                          .changeActiveState(false);
                                    }
                                  }
                                }
                                if (context.mounted) {
                                  context.loaderOverlay.hide();
                                }
                              },
                              onGetOtpPressed: () async {
                                if (onOTPSuccessHandler != null) {
                                  onOTPSuccessHandler!(
                                      mobileNumberController.text);
                                } else {
                                  context.loaderOverlay.show();
                                  SendOtpRequestBodyDto requestBodyDto =
                                      SendOtpRequestBodyDto(
                                          reference:
                                              mobileNumberController.text,
                                          countryCode:
                                              AppConstants.mobileNoPrefix,
                                          referenceType: AppConstants.contactNo,
                                          source: source);
                                  final result = await loginSignHandler
                                      .sendOtpRepo(requestBodyDto);
                                  ref
                                      .read(loginShowSendOtpProvider.notifier)
                                      .changeActiveState(true);
                                  if (result.status != 200) {
                                    if (actionAfterSuccessHandler == null) {
                                      if (context.mounted) context.pop();
                                    }
                                  }
                                  if (context.mounted) {
                                    context.loaderOverlay.hide();
                                  }
                                  onsendOtpEventFunction?.call();
                                }
                              },
                              // otpController: otpController,
                              iAcceptTC: iAcceptTC,
                              isAdult: isAdult,
                              isWhatApp: isWhatApp,
                              mobileNumberController: mobileNumberController),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  formatedTime({required int time}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
