
import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_mobile_otp_request_body.freezed.dart';
part 'validate_mobile_otp_request_body.g.dart';

@Freezed(toJson: true)
class ValidateMobileOTPRequestBodyDto with _$ValidateMobileOTPRequestBodyDto {

  const factory ValidateMobileOTPRequestBodyDto({
    required String source,
    required String contactNo,
    required String otp,
    required String  countryCode,
  String?  fullName,
    required bool isWhatsappCommEnabled,
  }) = _ValidateMobileOTPRequestBodyDto;

  factory ValidateMobileOTPRequestBodyDto.fromJson(Map<String, dynamic> json) =>
      _$ValidateMobileOTPRequestBodyDtoFromJson(json);
}
