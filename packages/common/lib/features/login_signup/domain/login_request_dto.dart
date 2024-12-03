import 'dart:convert';

import 'package:common/core/presentation/utils/login_enums.dart';

LoginRequestBodyDto loginRequestBodyDtoFromJson(String str) =>
    LoginRequestBodyDto.fromJson(json.decode(str));

String loginRequestBodyDtoToJson(LoginRequestBodyDto data) =>
    json.encode(data.toJson());

class LoginRequestBodyDto {
  final String? emailOrPhone;
  final String? otp;
  final LoginFormEnum? source;
  final String? countryCode;

  LoginRequestBodyDto({
    this.emailOrPhone,
    this.otp,
    this.source,
    this.countryCode,
  });

  factory LoginRequestBodyDto.fromJson(Map<String, dynamic> json) =>
      LoginRequestBodyDto(
        emailOrPhone: json["emailOrPhone"],
        otp: json["otp"],
        source: json["source"],
        countryCode: json["countryCode"],
      );

  Map<String, dynamic> toJson() => {
        "emailOrPhone": emailOrPhone,
        "otp": otp,
        "source": source?.value,
        "countryCode": countryCode,
      };
}
