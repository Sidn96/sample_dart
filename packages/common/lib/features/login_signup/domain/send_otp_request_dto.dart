import 'dart:convert';

import 'package:common/core/presentation/utils/login_enums.dart';

SendOtpRequestBodyDto requestBodyDtoFromJson(String str) => SendOtpRequestBodyDto.fromJson(json.decode(str));

String requestBodyDtoToJson(SendOtpRequestBodyDto data) => json.encode(data.toJson());

class SendOtpRequestBodyDto {
  final LoginFormEnum? source;
  final String? reference;
  final String? referenceType;
  final String? countryCode;

  SendOtpRequestBodyDto({
    this.source,
    this.reference,
    this.referenceType,
    this.countryCode,
  });

  factory SendOtpRequestBodyDto.fromJson(Map<String, dynamic> json) => SendOtpRequestBodyDto(
    source: json["source"],
    reference: json["reference"],
    referenceType: json["referenceType"],
    countryCode: json["countryCode"],
  );

  Map<String, dynamic> toJson() => {
    "source": source?.value,
    "reference": reference,
    "referenceType": referenceType,
    "countryCode": countryCode,
  };
}
