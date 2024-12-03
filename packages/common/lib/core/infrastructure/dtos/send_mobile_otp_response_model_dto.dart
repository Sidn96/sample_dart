import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_mobile_otp_response_model_dto.freezed.dart';

part 'send_mobile_otp_response_model_dto.g.dart';

@Freezed(toJson: true)
class SendMobileOTPResponseModelDto with _$SendMobileOTPResponseModelDto {
  const factory SendMobileOTPResponseModelDto(
      {required int status,
      required String error,
      required String message,
      required bool success}) = _SendMobileOTPResponseModelDto;

  factory SendMobileOTPResponseModelDto.fromJson(Map<String, dynamic> json) =>
      _$SendMobileOTPResponseModelDtoFromJson(json);
}
