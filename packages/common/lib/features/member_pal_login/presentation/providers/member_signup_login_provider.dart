import 'package:common/core/domain/validator.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/member_pal_login/data/dtos/member_pal_login_response_dto.dart';
import 'package:common/features/member_pal_login/domain/entities/member_pal_login_request_entity.dart';
import 'package:common/features/member_pal_login/domain/entities/member_pal_login_response_entity.dart';
import 'package:common/features/member_pal_login/domain/entities/member_signup_login_entity.dart';
import 'package:common/features/member_pal_login/domain/entities/send_otp_request_entity.dart';
import 'package:common/features/member_pal_login/domain/repos/member_pal_login_repo.dart';

part 'member_signup_login_provider.g.dart';

MemberSignupLoginStatus getLogStatus(int code) {
  switch (code) {
    case 200:
      return MemberSignupLoginStatus.sucess;
    case 403:
      return MemberSignupLoginStatus.wrongOtp;
    default:
      return MemberSignupLoginStatus.failed;
  }
}

@riverpod
Future<MemberPalLoginResponseEntity> memberPalLoginRegister(Ref ref) async {
  final memberPalDetail = ref.read(memberSignUpLoginProvierProvider);
  final result = await ref
      .read(memberPalLoginRepoProvider)
      .memberPalLoginRegister(
          requestEntity: MemberPalLoginRequestEntity
              .fromFormEntityToMemberPalLoginRequestEntity(memberPalDetail));
  await storeLogData(result);
  return MemberPalLoginResponseEntity(
      status: getLogStatus(result.status ?? 500),
      mobileNumber: memberPalDetail.mobileNumber,
      statusCode: result.status);
}

@riverpod
Future<bool> memberPalSendOtp(Ref ref) async {
  final memberPalDetail = ref.read(memberSignUpLoginProvierProvider);
  final result = await ref.read(memberPalLoginRepoProvider).memberPalSendOtp(
      sendOtpEntity:
          SendOtpRequestEntity.fromFormEntityToSendOtpEntity(memberPalDetail));
  return result;
}

Future<void> storeLogData(MemberPalLoginResponseDto result) async {
  await SecureStorage().setPref(
      key: SecureKeys.accessToken,
      value: result.data?.tokens?.accessToken ?? "");
  await SecureStorage().setPref(
      key: SecureKeys.refreshToken,
      value: result.data?.tokens?.refreshToken ?? "");
}

@riverpod
class MemberSignUpLoginProvier extends _$MemberSignUpLoginProvier {
  @override
  MemberSignupLoginEntity build() {
    return const MemberSignupLoginEntity();
  }

  void setUserName(String? value) {
    state = state.copyWith(userName: value);
  }

  void setAdult(bool value) {
    state = state.copyWith(acceptAdult: value);
  }

  void setMobileNumber(String? value) {
    state =
        state.copyWith(mobileNumber: value, isSendOTPPressed: false, otp: "");
  }

  void setOtp(String? value) {
    state = state.copyWith(otp: value);
  }

  void setOtpSendPressed(bool value) {
    state = state.copyWith(isSendOTPPressed: value);
  }

  void setSource(String? value) {
    state = state.copyWith(source: value);
  }

  void setTC(bool value) {
    state = state.copyWith(acceptTc: value);
  }

  void setWhatsApp(bool value) {
    state = state.copyWith(acceptWhatsApp: value);
  }
}

enum MemberSignupLoginStatus { wrongOtp, sucess, failed }

@riverpod
class ShowMemberPalOtpError extends _$ShowMemberPalOtpError {
  @override
  bool build() {
    return false;
  }

  void changeState(bool value) => state = value;
}
