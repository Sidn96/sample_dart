import 'package:common/features/member_pal_login/presentation/providers/member_signup_login_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_pal_login_response_entity.freezed.dart';
part 'member_pal_login_response_entity.g.dart';

@freezed
class MemberPalLoginResponseEntity with _$MemberPalLoginResponseEntity {
  const factory MemberPalLoginResponseEntity({
    int? statusCode,
    String? mobileNumber,
    MemberSignupLoginStatus? status,
  }) = _MemberPalLoginResponseEntity;

  factory MemberPalLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$MemberPalLoginResponseEntityFromJson(json);
}
