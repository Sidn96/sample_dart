import 'package:common/core/domain/validator.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_signup_login_entity.freezed.dart';
part 'member_signup_login_entity.g.dart';

@freezed
class MemberSignupLoginEntity with _$MemberSignupLoginEntity {
  const factory MemberSignupLoginEntity({
    String? mobileNumber,
    String? otp,
    String? source,
    String? userName,
    @Default(true) bool acceptAdult,
    @Default(true) bool acceptTc,
    @Default(true) bool acceptWhatsApp,
    @Default(false) bool isSendOTPPressed,
  }) = _MemberSignupLoginEntity;

  factory MemberSignupLoginEntity.fromJson(Map<String, dynamic> json) =>
      _$MemberSignupLoginEntityFromJson(json);

  const MemberSignupLoginEntity._();

  bool acceptAdultStatus() {
    if (source == LoginFormEnum.eldercare.value) {
      return true;
    } else {
      return acceptAdult == true;
    }
  }

  bool isCtaChecked() {
    return acceptAdultStatus() == true &&
        acceptTc == true &&
        acceptWhatsApp == true;
  }

  bool isMemberSignUpLoginFormValid() {
    return mobileNumber?.isNotEmpty == true &&
        mobileNumber?.length == 10 &&
        otp?.isNotEmpty == true &&
        otp?.length == 4 &&
        isCtaChecked() == true;
  }

  bool isMobileEntered() {
    return mobileNumber?.isNotEmpty == true && mobileNumber?.length == 10;
  }

  bool isOtpEntered() {
    return mobileNumber?.isNotEmpty == true &&
        mobileNumber?.length == 10 &&
        otp?.isNotEmpty == true &&
        otp?.length == 4;
  }

  bool get hasValidName {
    if (Validator.isNameValid(userName) == null) {
      return true;
    }

    return false;
  }
}
