import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_mobile_otp_response_model_dto.freezed.dart';

part 'validate_mobile_otp_response_model_dto.g.dart';

@Freezed(toJson: true)
class ValidateMobileOTPFCResponseModelDto
    with _$ValidateMobileOTPFCResponseModelDto {
  const factory ValidateMobileOTPFCResponseModelDto(
      {required int status,
      required String error,
      required String message,
      required bool success,
      required DataFC data}) = _ValidateMobileOTPFCResponseModelDto;

  factory ValidateMobileOTPFCResponseModelDto.fromJson(
          Map<String, dynamic> json) =>
      _$ValidateMobileOTPFCResponseModelDtoFromJson(json);
}

@Freezed(toJson: true)
class DataFC with _$DataFC {
  const factory DataFC(
      {TokensFC? tokens, String? source, String? createLeadMessage}) = _DataFC;

  factory DataFC.fromJson(Map<String, dynamic> json) => _$DataFCFromJson(json);
}

@Freezed(toJson: true)
class TokensFC with _$TokensFC {
  const factory TokensFC({
    String? accessToken,
    String? refreshToken,
  }) = _TokensFC;

  factory TokensFC.fromJson(Map<String, dynamic> json) =>
      _$TokensFCFromJson(json);
}
