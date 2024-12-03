import 'package:common/features/member_pal_login/domain/entities/member_signup_login_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_otp_request_entity.freezed.dart';
part 'send_otp_request_entity.g.dart';

@freezed
class SendOtpRequestEntity with _$SendOtpRequestEntity {
  const factory SendOtpRequestEntity({
    String? source,
    String? reference,
    String? referenceType,
    String? countryCode,
  }) = _SendOtpRequestEntity;

  factory SendOtpRequestEntity.fromFormEntityToSendOtpEntity(
      MemberSignupLoginEntity? entity) {
    return SendOtpRequestEntity(
        source: entity?.source,
        reference: entity?.mobileNumber,
        referenceType: "contactno",
        countryCode: "+91");
  }

  factory SendOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestEntityFromJson(json);

  const SendOtpRequestEntity._();
}
