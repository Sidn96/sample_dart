import 'dart:io';

import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/widgets/hdfc_life_footer_logo.dart';
import 'package:common/features/new_login_register/domain/enums.dart';
import 'package:common/features/new_login_register/presentation/components/checkbox_widget.dart';
import 'package:common/features/new_login_register/presentation/components/login_register_user_feedback_quotes_component.dart';
import 'package:common/features/new_login_register/presentation/notifiers/cta_button_state_notifier.dart';
import 'package:common/features/new_login_register/presentation/notifiers/login_register_page_status_notifier.dart';
import 'package:common/features/new_login_register/presentation/widgets/error_app_text.dart';
import 'package:common/features/new_login_register/presentation/widgets/mobile_number_input_field.dart';
import 'package:common/features/new_login_register/presentation/widgets/pincode_code_text_field_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class LoginRegisterComponent extends HookConsumerWidget {
  final LoginFormEnum source;
  final EdgeInsetsGeometry contentPadding;
  final bool isAgeCheckBoxNeeded;
  final VoidCallback successHandler;
  final VoidCallback? eventCaller;
  final Widget? customLoader;
  final Color? textColor;
  final Color? editIconColor;
  final Color? labelColor;
  final String? labelText;
  final Color? cursorColor;
  final Color? otpCursorColor;
  final Color? otpLabelColor;
  final Color? otpTextColor;
  final Color? resendEnableColor;
  final Color? resendDisableColor;
  final Color? otpTimerColor;
  final Color? mobileErrorMsgColor;
  final Color? enabledButtonColor;
  final Color? disabledButtonColor;
  final Color? enabledButtonTextColor;
  final Color? disabledButtonTextColor;
  final double? otpFieldWidthInPercent;
  final CheckBoxThemeModel? checkBoxThemeModel;
  final bool showSpaceFromTop;
  final bool makeConsentTextUnderLined;
  final Color normalConsentTextColor;
  final Color hyperLinkTextColor;
  final Color? decorationColor;
  final double? decorationThickness;
  final Color? changeCTAColor;
  final Color? otpSentMsgColor;
  final bool showMessageAboveField;
  final bool showDecorationOnCTAs;
  final bool? isFromBuy;
  final bool showFeedbackQuotes;
  final bool enableAutoFetchMobileNumber;
  final String? comingFrom;

  const LoginRegisterComponent(
      {super.key,
      required this.source,
      this.contentPadding = const EdgeInsets.only(
        left: 20.0,
        top: 0,
        right: 20.0,
        bottom: 0,
      ),
      this.comingFrom,
      this.isAgeCheckBoxNeeded = false,
      required this.successHandler,
      this.eventCaller,
      this.customLoader,
      this.textColor,
      this.editIconColor,
      this.cursorColor,
      this.labelColor,
      this.otpCursorColor,
      this.otpLabelColor,
      this.otpTextColor,
      this.resendEnableColor,
      this.resendDisableColor,
      this.otpTimerColor,
      this.otpFieldWidthInPercent = .20,
      this.mobileErrorMsgColor,
      this.enabledButtonColor,
      this.disabledButtonColor,
      this.enabledButtonTextColor,
      this.disabledButtonTextColor,
      this.checkBoxThemeModel,
      this.labelText,
      this.showSpaceFromTop = true,
      this.makeConsentTextUnderLined = false,
      this.normalConsentTextColor = ColorUtilsV2.hex_717182,
      this.hyperLinkTextColor = ColorUtilsV2.hex_4E52F8,
      this.decorationColor,
      this.decorationThickness,
      this.changeCTAColor = ColorUtilsV2.hex_4E52F8,
      this.otpSentMsgColor = ColorUtilsV2.hex_717182,
      this.showDecorationOnCTAs = false,
      this.showMessageAboveField = false,
      this.isFromBuy,
      this.showFeedbackQuotes = false,
      this.enableAutoFetchMobileNumber = false});

  void addListeners(
      BuildContext context, WidgetRef ref, FocusNode otpFocusNode) {
    ref.listen(loginRegisterPageNotifierProvider, (pre, next) {
      if (next == LoginRegisterStatesEnum.loginRegisterSuccess) {
        // Successfully login
        successHandler.call();
      } else if (next == LoginRegisterStatesEnum.resentOtp) {
        otpFocusNode.requestFocus();
      } else if (next == LoginRegisterStatesEnum.otpError) {}
    });

    ref.listen(loaderStateNotifierProvider, (prev, next) {
      if (next) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mobileNumberController = useTextEditingController();
    final otpController = useTextEditingController();
    var pageNotifier = ref.read(loginRegisterPageNotifierProvider.notifier);
    pageNotifier.setSource(source); //Mandatory call
    var errorAnimationController = useStreamController<ErrorAnimationType>();
    final slideAnimationController =
        useAnimationController(duration: const Duration(milliseconds: 500));

    var mobileNumberFocusNode = useFocusNode();
    var otpFocusNode = useFocusNode();
    var mobileHasFocus = useValueNotifier(false);
    var otpHasFocus = useValueNotifier(false);
    final dummycont = useState<int>(0);

    useEffect(() {
      if (eventCaller != null) {
        eventCaller?.call();
      }
      mobileNumberController.addListener(() {
        pageNotifier.validateMobileNumber(mobileNumberController.text);
      });
      slideAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //requesting focus
          otpFocusNode.requestFocus();
          dummycont.value = dummycont.value++;
          otpHasFocus.value = true;
        }
      });
      mobileNumberFocusNode.addListener(() {
        if (context.mounted) {
          mobileHasFocus.value = mobileNumberFocusNode.hasFocus;
        }
      });
      otpFocusNode.addListener(() {
        if (context.mounted) {
          otpHasFocus.value = otpFocusNode.hasFocus;
        }
      });
      if (enableAutoFetchMobileNumber) {
        getUserMobileNumber(mobileNumberController, context);
      }

      MoEngageService().trackEvent(
        eventName: MoEngageEventsConsts.eventsNames.memberloginscreenviewed,
        product: ProductEvent.truefin,
      );
      if (isFromBuy == true) {
        MoEngageService().trackEvent(
            eventName:
                MoEngageEventsConsts.eventsNames.truefinloginbuttonclicked,
            product: ProductEvent.nps,
            properties: {"source": "NPS aggregator page"});
      }

      return () {
        if (kIsWeb == false && Platform.isAndroid == true) {
          SmsVerification.stopListening();
        }
        if (Platform.isAndroid) {
          SmsAutoFill().unregisterListener();
        }
      };
    }, []);

    addListeners(context, ref, otpFocusNode);

    return Padding(
      padding: contentPadding,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: SizedBox(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showSpaceFromTop
                      ? const SizedBox(height: 32.0)
                      : const SizedBox.shrink(),
                  //Mobile Number
                  Consumer(
                    builder: (context, ref, child) {
                      ref.watch(loginRegisterPageNotifierProvider);
                      var tPageNotifier =
                          ref.read(loginRegisterPageNotifierProvider.notifier);
                      if (tPageNotifier.showPinField) return const SizedBox();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showMessageAboveField) ...[
                            const AppTextV2(
                              data:
                                  "Enter mobile no. associated with your savings account.",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: ColorUtilsV2.hex_5D5D70,
                            ),
                            30.height,
                          ],
                          MobileNumberInputField(
                            fieldFocusNode: mobileNumberFocusNode,
                            labelText: labelText ?? 'Mobile No.',
                            controller: mobileNumberController,
                            onClearClick: () {
                              pageNotifier
                                  .updateState(LoginRegisterStatesEnum.none);
                              pageNotifier.showPinField = false;
                              pageNotifier.mobileNumberError = null;
                              pageNotifier.updateCta(false, "Get OTP");
                            },
                            textColor: textColor,
                            editIconColor: editIconColor,
                            labelColor: labelColor,
                            cursorColor: cursorColor,
                          ),

                          //Mobile Number Error Filed
                          SizedBox(
                            height: 56,
                            child: Consumer(builder: (_, ref, __) {
                              ref.watch(loginRegisterPageNotifierProvider);
                              Color? errorColor =
                                  (pageNotifier.mobileNumberError ==
                                          AppConstants.getOtpOnNumMessage)
                                      ? mobileErrorMsgColor ??
                                          ColorUtilsV2.hex_717182
                                      : null;
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: ErrorAppText(
                                  errorText: pageNotifier.mobileNumberError,
                                  errorTextColor: errorColor,
                                ),
                              );
                            }),
                          ),
                        ],
                      );
                    },
                  ),

                  // const SizedBox(height: 40),

                  // Pin Code
                  //Error, Timmer and Resend OTP button
                  Consumer(
                    builder: (_, ref, Widget? child) {
                      var state = ref.watch(loginRegisterPageNotifierProvider);
                      var tPageNotifier =
                          ref.read(loginRegisterPageNotifierProvider.notifier);
                      if (!tPageNotifier.showPinField) {
                        if (otpController.text.isNotNullNorEmpty()) {
                          otpController.text = '';
                        }
                      } else if (state == LoginRegisterStatesEnum.otpError) {
                        errorAnimationController.add(ErrorAnimationType.shake);
                      }

                      /*   if (tPageNotifier.showPinField) {
                        if (!otpFocusNode.value.hasFocus &&
                            otpController.text.isNullOrEmpty()) {

                          Future.delayed(const Duration(milliseconds: 300),
                              () {
                            print("requesting focus");
                            otpFocusNode.value.requestFocus();
                          });
                        }
                      }*/
                      return Visibility(
                          visible: tPageNotifier.showPinField,
                          maintainState: true,
                          maintainAnimation: true,
                          maintainSize: true,
                          child: child!);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showMessageAboveField) ...[
                          const AppTextV2(
                            data: "Enter 4 digit OTP sent on your mobile no.",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: ColorUtilsV2.hex_5D5D70,
                          ),
                          30.height,
                        ],
                        PinCodeTextFieldWidget(
                          slideAnimationController: slideAnimationController,
                          focusNode: otpFocusNode,
                          otpController: otpController,
                          loginRegisterPageNotifier: pageNotifier,
                          errorAnimationController: errorAnimationController,
                          resendCallback: () {
                            otpController.clear();
                            //OTP Resend called
                            ref
                                .read(
                                    loginRegisterPageNotifierProvider.notifier)
                                .sendOtp(
                                    otpController: otpController,
                                    animationController:
                                        slideAnimationController);
                          },
                          otpCursorColor: otpTimerColor,
                          otpLabelColor: otpLabelColor,
                          otpTextColor: otpTextColor,
                          resendEnableColor: resendEnableColor,
                          resendDisableColor: resendDisableColor,
                          otpTimerColor: otpTimerColor,
                          otpFieldWidthInPercent: otpFieldWidthInPercent,
                          changeCTAColor: changeCTAColor,
                          otpSentMsgColor: otpSentMsgColor,
                          showDecorationOnCTAs: showDecorationOnCTAs,
                        ),
                      ],
                    ),
                  ),
                  // random LoginRegisterUserFeedbackQuotesComponent
                  if (showFeedbackQuotes)
                    Consumer(builder: (context, ref, child) {
                      var tPageNotifier =
                          ref.read(loginRegisterPageNotifierProvider.notifier);
                      return Column(
                        children: [
                          if (tPageNotifier.showPinField)
                            const SizedBox(height: 70),
                          ValueListenableBuilder(
                            valueListenable: ref
                                    .read(loginRegisterPageNotifierProvider
                                        .notifier)
                                    .showPinField
                                ? otpHasFocus
                                : mobileHasFocus,
                            builder: (context, hasFocus, child) {
                              if (hasFocus) return const SizedBox.shrink();
                              return LoginRegisterUserFeedbackQuotesComponent(
                                  source: source);
                            },
                          ),
                        ],
                      );
                    }),
                  //Checkbox widget
                  Expanded(
                    child: Consumer(builder: (context, ref, _) {
                      //var state = ref.watch(loginRegisterPageNotifierProvider);
                      var tPageNotifier =
                          ref.read(loginRegisterPageNotifierProvider.notifier);
                      var ctaNotifier =
                          ref.watch(ctaButtonStateNotifierProvider);
                      var isButtonEnable = ctaNotifier.isEnable;
                      // if (tPageNotifier.showPinField) return const SizedBox();
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextV2(
                              data: "By proceeding, l agree to TrueFin’s",
                              fontSize: 12.0,
                              height: 16.39 / 12.0,
                              fontColor: normalConsentTextColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                        CommonRouteString.termsAndConditions);
                                  },
                                  child: AppTextV2(
                                    data: "T&C,  ",
                                    fontSize: 12.0,
                                    height: 16.39 / 12.0,
                                    fontColor: hyperLinkTextColor,
                                    textDecoration: makeConsentTextUnderLined
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    fontWeight: FontWeight.w600,
                                    decorationColor: decorationColor,
                                    decorationThickness: decorationThickness,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                        CommonRouteString.privacyPolicy);
                                  },
                                  child: AppTextV2(
                                    data: "Privacy Policy",
                                    fontSize: 12.0,
                                    height: 16.39 / 12.0,
                                    fontColor: hyperLinkTextColor,
                                    textDecoration: makeConsentTextUnderLined
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    fontWeight: FontWeight.w600,
                                    decorationColor: decorationColor,
                                    decorationThickness: decorationThickness,
                                  ),
                                ),
                                AppTextV2(
                                    data: " and ",
                                    fontSize: 12.0,
                                    height: 16.39 / 12.0,
                                    fontColor: normalConsentTextColor,
                                    fontWeight: FontWeight.w500),
                                InkWell(
                                  onTap: () {
                                    context.pushNamed(
                                        CommonRouteString.legalDisclaimer);
                                  },
                                  child: AppTextV2(
                                    data: " Legal Disclaimer.",
                                    fontSize: 12.0,
                                    height: 16.39 / 12.0,
                                    fontColor: hyperLinkTextColor,
                                    textDecoration: makeConsentTextUnderLined
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    fontWeight: FontWeight.w600,
                                    decorationColor: decorationColor,
                                    decorationThickness: decorationThickness,
                                  ),
                                ),
                              ],
                            ),
                            // CheckboxesWidget(
                            //   checkBoxModels: DefaultCheckBoxModels()
                            //       .getListOfCheckBoxModels(context,
                            //           isAgeCheckNeeded:
                            //               isAgeCheckBoxNeeded),
                            //   allMandatoryChecked: (isAllMandatoryChecked) {
                            //     pageNotifier.autoSubmitEnable = false;
                            //     pageNotifier.updateMandatoryCheckboxState(
                            //         isAllMandatoryChecked);
                            //   },
                            //   onWhatsappCommCheckChanged: (val) {
                            //     pageNotifier.isWhatsappCommEnabled = val;
                            //     // otpFocusNode.unfocus();
                            //   },
                            //   checkBoxThemeModel: checkBoxThemeModel,
                            // ),
                            const SizedBox(height: 10.0),

                            /// Common Hdfc Life Logo
                            if (isFromBuy != null && isFromBuy!)
                              const HdfcLifeFooterLogo(),

                            //Submit Button
                            PrimaryAppButtonV2(
                              enableBtnColor: enabledButtonColor ??
                                  ColorUtilsV2.specialBackground500,
                              disableBtnColor: disabledButtonColor ??
                                  ColorUtilsV2.specialBackground300,
                              textColor: (isButtonEnable
                                      ? enabledButtonTextColor
                                      : disabledButtonTextColor) ??
                                  ColorUtilsV2.genericWhite,
                              label: ctaNotifier.name,
                              isEnable: isButtonEnable,
                              onTap: () {
                                ctaOnPressed(ref, otpController,
                                    animationController:
                                        slideAnimationController);
                              },
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 40.w,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void ctaOnPressed(WidgetRef ref, TextEditingController otpController,
      {AnimationController? animationController}) {
    var stateValue = ref.read(loginRegisterPageNotifierProvider).value;

    if (stateValue == LoginRegisterStatesEnum.otpFilled.value) {
      ref.read(loginRegisterPageNotifierProvider.notifier).callLoginRegister();
    } else if (stateValue > LoginRegisterStatesEnum.invalidMobNo.value) {
      ref.read(loginRegisterPageNotifierProvider.notifier).sendOtp(
          otpController: otpController,
          animationController: animationController);
    }
  }

  String getLast10Digits(String phoneNumber) {
    // Remove any non-digit characters
    String cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Ensure the cleaned phone number has at least 10 digits
    if (cleanedPhoneNumber.length >= 10) {
      return cleanedPhoneNumber.substring(cleanedPhoneNumber.length - 10);
    } else {
      // Handle cases where the phone number is shorter than 10 digits
      return cleanedPhoneNumber;
    }
  }

  getUserMobileNumber(
      TextEditingController mobController, BuildContext context) async {
    if (kIsWeb) return;
    // Note: this feature auto populate number will only work on android not in web and ios
    if (Platform.isAndroid) {
      await Future.delayed(const Duration(milliseconds: 300));
      try {
        final autoFill = SmsAutoFill();
        final phone = await autoFill.hint;
        if (phone == null) return "";

        mobController.text = getLast10Digits(phone);
        autoFill.unregisterListener();
      } catch (e) {
        // nothing to do
      }
    }
  }
}
