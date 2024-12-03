// To parse this JSON data, do
//
//     final refreshTokenResponseDto = refreshTokenResponseDtoFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_response_dto.freezed.dart';
part 'refresh_token_response_dto.g.dart';

@freezed
class RefreshTokenResponseDto with _$RefreshTokenResponseDto {
  const factory RefreshTokenResponseDto({
    required int status,
    required bool success,
    required String message,
    required RefreshTokenData data,
    required String error,
  }) = _RefreshTokenResponseDto;

  factory RefreshTokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseDtoFromJson(json);
}

@freezed
class RefreshTokenData with _$RefreshTokenData {
  const factory RefreshTokenData({
    required String accessToken,
    required String refreshToken,
  }) = _RefreshTokenData;

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDataFromJson(json);
}
