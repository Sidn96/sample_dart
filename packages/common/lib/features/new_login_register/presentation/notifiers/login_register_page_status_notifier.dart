import 'dart:io';

import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/cookie_check_notifier.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:common/features/new_login_register/domain/enums.dart';
import 'package:common/features/new_login_register/infrastructure/login_signup_datasource.dart';
import 'package:common/features/new_login_register/presentation/notifiers/cta_button_state_notifier.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
part 'login_register_page_status_notifier.g.dart';

@riverpod
class LoginRegisterPageNotifier extends _$LoginRegisterPageNotifier {
  bool autoSubmitEnable = true;
  bool showPinField = false;
  bool isWhatsappCommEnabled = true;
  bool _isAllMandatoryChecked = true;
  String? mobileNumberError;
  String? loginRegisterApiError;
  String? _mobileNumber;
  String? _memberId;
  String? _otp;
  late LoginFormEnum source;
  late CtaButtonStateNotifier ctaNotifier;
  late LoaderStateNotifier loaderNotifier;

  @override
  LoginRegisterStatesEnum build() {
    autoSubmitEnable = true;
    ctaNotifier = ref.read(ctaButtonStateNotifierProvider.notifier);
    loaderNotifier = ref.read(loaderStateNotifierProvider.notifier);
    return LoginRegisterStatesEnum.none;
  }

  void setSource(LoginFormEnum source) {
    this.source = source;
  }

  String getMobileNumber() {
    return _mobileNumber ??"";
  }

  String getMemberId() {
    return _memberId ??"";
  }

  void updateState(LoginRegisterStatesEnum newState) {
    switch (newState) {
      case LoginRegisterStatesEnum.invalidMobNo:
        showPinField = false;
        mobileNumberError = AppConstants.enterValidMobileNumber;
        updateCta(false, 'Get OTP');
        break;

      case LoginRegisterStatesEnum.otpWillBeSendToMobileNumber:
        updateCta(true, 'Get OTP');
        mobileNumberError = AppConstants.getOtpOnNumMessage;
        showPinField = false;
        autoSubmitEnable = true;
        break;

      case LoginRegisterStatesEnum.unableToSendOtp:
        updateCta(true, 'Get OTP');
        showPinField = false;
       // mobileNumberError = null;
        break;

      case LoginRegisterStatesEnum.otpSent:
      case LoginRegisterStatesEnum.resentOtp:
        updateCta(false, 'Submit');
        showPinField = true;
        loginRegisterApiError = '';
        mobileNumberError = null;
        break;
      case LoginRegisterStatesEnum.otpError:
        updateCta(false, 'Submit');
        showPinField = true;
        break;

      case LoginRegisterStatesEnum.otpFilled:
        updateCta(true, 'Submit');
        if (autoSubmitEnable) {
          state = newState;
          callLoginRegister();
          return;
        }
        break;
      default:
        break;
    }
    state = newState;
  }

  void updateCta(bool shouldEnable, String btnName) {
    ctaNotifier.updateState(
      CtaButtonState(
        isEnable: _isAllMandatoryChecked && shouldEnable,
        name: btnName,
      ),
    );
  }

  void updateMandatoryCheckboxState(bool isAllMandatoryChecked) {
    _isAllMandatoryChecked = isAllMandatoryChecked;
    updateState(state);
  }

  void updateOtp(String otp) {
    if (_otp == otp) {
      return;
    }
    _otp = otp;
    //Validate OTP
    if (otp.isNullOrEmpty()) {
      if (state.value > LoginRegisterStatesEnum.invalidMobNo.value) {
        updateState(LoginRegisterStatesEnum.otpSent);
      }
      return;
    }
    if (otp.length == 4) {
      updateState(LoginRegisterStatesEnum.otpFilled);
    } else {
      updateState(LoginRegisterStatesEnum.otpSent);
      //updateCta(false, 'Submit');
    }
  }

  void validateMobileNumber(String? mobileNumber) {
    print("validateMobileNumber");
    if (mobileNumber.isNullOrEmpty() || _mobileNumber == mobileNumber) {
      return;
    }
    //Check for first digit of mobile number
    if (_mobileNumber.isNullOrEmpty() && mobileNumber?.length == 1) {
      return; //don't show error till the first digit of mobile number is entered
    }
    _mobileNumber = mobileNumber;
    if (mobileNumber!.length < 10) {
      if (state != LoginRegisterStatesEnum.invalidMobNo) {
        updateState(LoginRegisterStatesEnum.invalidMobNo);
      }
      return;
    }

    // Pattern pattern = r'^(?!(\d)\1{4,})([6789]\d{9})$';
    Pattern pattern = r'^([6789]\d{9})$';
    RegExp regex = RegExp(pattern.toString());
    var isMobileNumberValid = regex.hasMatch(mobileNumber.trim());
    if (isMobileNumberValid) {
      updateState(LoginRegisterStatesEnum.otpWillBeSendToMobileNumber);
    } else {
      updateState(LoginRegisterStatesEnum.invalidMobNo);
    }
  }

  final intRegex = RegExp(r'\d+', multiLine: true);

  Future<void> sendOtp(
      {String? mobileNumber = '',
      required TextEditingController otpController,AnimationController? animationController}) async {
    loaderNotifier.showLoader();

    var request = SendOtpRequest(
      countryCode: '+91',
      reference: _mobileNumber ?? mobileNumber!,
      referenceType: 'contactno',
      source: source.value,
    );

    var dataSource = ref.read(loginRegisterDataSourceProvider);
    var response = await dataSource.sendOtpApi(request);

    loaderNotifier.hideLoader();

    if (response.isRight()) {
      if(kIsWeb == false && Platform.isAndroid ==true){
        //starts listeneing for otp on android
        SmsVerification.startListeningSms().then((message) {
          String otpCode = SmsVerification.getCode(message, intRegex);
          otpController.text = otpCode;
          SmsVerification.stopListening();
        });
      }
      
      if (state == LoginRegisterStatesEnum.otpSent) {
        updateState(LoginRegisterStatesEnum.resentOtp);
      } else {
        updateState(LoginRegisterStatesEnum.otpSent);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          animationController?.reset();
          animationController?.forward();
        });
      }
    } else {
      String errorString = response.fold((l) => l ?? "", (r) => "");
      mobileNumberError = errorString;
      /*final snackBar = SnackBar(
        duration: const Duration(seconds: 3),
          content: AppTextV2(
              data: errorString,
              fontSize: 12.0,
              fontColor: Colors.white,
              textAlign: TextAlign.left),
          backgroundColor: Colors.red);*/


      // ScaffoldMessenger.of(
      //         GlobalNavigationUtils.rootAppNavigatorKey.currentContext!)
      //     .showSnackBar(snackBar);
       updateState(LoginRegisterStatesEnum.unableToSendOtp);
    }
  }

  Future<void> callLoginRegister() async {
    loaderNotifier.showLoader();

    var request = LoginRegisterRequest(
      contactNo: _mobileNumber!,
      countryCode: '+91',
      isWhatsappCommEnabled: isWhatsappCommEnabled,
      otp: _otp!,
      source: source.value,
      policyText: "I accept the Terms & Conditions, Privacy policy & Legal Disclaimer.",
      dndOverrideText: "I accept the DND Disclaimer.",
      whatsappCommText: "I agree to be communicated via What'sApp"
    );

    var dataSource = ref.read(loginRegisterDataSourceProvider);
    var response = await dataSource.callLoginRegisterApi(request);


    if (response.status == 200) {
      _memberId = response.data?.memberId;
      ref.read(cookieCheckNotifierProvider.notifier).setCookieInBrowser();
      await dataSource.getMemberInfoApi();
      updateState(LoginRegisterStatesEnum.loginRegisterSuccess);
      MoEngageService().setUID(getMemberId(), getMobileNumber());
      if (response.data?.registration == true) {
        MoEngageService().trackEvent(
            eventName: MoEngageEventsConsts
                .eventsNames.memberContactVerificationSuccess,
            product: ProductEvent.truefin,
            properties: {
              'registration': response.data?.createdAt == null ? 0 : 1,
              'registration_mode':
                  MoEngageEventsConsts.eventAttributesValue.contactNum,
              'registration_type': 'manual',
            });
      }else{
         MoEngageService().trackEvent(
            eventName: MoEngageEventsConsts
                .eventsNames.membersigninsuccessful,
            product: ProductEvent.truefin,
            properties: {
              'signin_mode':
                  MoEngageEventsConsts.eventAttributesValue.contactNum,
              'signin_type': 'manual',
            });
      }
      ref.refresh(loginStatusProvider);
    } else {
      loginRegisterApiError = response.error;
      updateState(LoginRegisterStatesEnum.otpError);
      if (response.data?.registration == true) {
        MoEngageService().trackEvent(
          eventName:
              MoEngageEventsConsts.eventsNames.memberContactVerificationFail,
          product: ProductEvent.truefin,
          properties: {
            'registration_mode':
                MoEngageEventsConsts.eventAttributesValue.contactNum,
          });
      }else{
         MoEngageService().trackEvent(
          eventName:
              MoEngageEventsConsts.eventsNames.membersigninfailed,
          product: ProductEvent.truefin,
          properties: {
            'signin_mode':
                MoEngageEventsConsts.eventAttributesValue.contactNum,
          });
      }
     
    }
    loaderNotifier.hideLoader();
  }
}

@riverpod
class LoaderStateNotifier extends _$LoaderStateNotifier {
  @override
  bool build() {
    return false;
  }

  void showLoader() {
    state = true;
  }

  void hideLoader() {
    state = false;
  }
}
