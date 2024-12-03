import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_pal_login_response_dto.freezed.dart';
part 'member_pal_login_response_dto.g.dart';

@freezed
class Data with _$Data {
  const factory Data({
    Tokens? tokens,
    dynamic memberId,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class MemberPalLoginResponseDto with _$MemberPalLoginResponseDto {
  const factory MemberPalLoginResponseDto({
    int? status,
    bool? success,
    String? message,
    Data? data,
    String? error,
  }) = _MemberPalLoginResponseDto;

  factory MemberPalLoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MemberPalLoginResponseDtoFromJson(json);
}

@freezed
class Tokens with _$Tokens {
  const factory Tokens({
    String? accessToken,
    String? refreshToken,
  }) = _Tokens;

  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);
}
