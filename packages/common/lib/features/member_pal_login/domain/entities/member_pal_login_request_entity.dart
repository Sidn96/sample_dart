import 'package:common/features/member_pal_login/domain/entities/member_signup_login_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_pal_login_request_entity.freezed.dart';
part 'member_pal_login_request_entity.g.dart';

@freezed
class MemberPalLoginRequestEntity with _$MemberPalLoginRequestEntity {
  const factory MemberPalLoginRequestEntity({
    String? contactNo,
    String? otp,
    String? source,
    String? countryCode,
  }) = _MemberPalLoginRequestEntity;

  factory MemberPalLoginRequestEntity.fromFormEntityToMemberPalLoginRequestEntity(
      MemberSignupLoginEntity? entity) {
    return MemberPalLoginRequestEntity(
      contactNo: entity?.mobileNumber,
      source: entity?.source,
      otp: entity?.otp,
      countryCode: "+91",
    );
  }

  factory MemberPalLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$MemberPalLoginRequestEntityFromJson(json);

  const MemberPalLoginRequestEntity._();
}
