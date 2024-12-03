import 'dart:convert';

import 'package:common/core/presentation/utils/login_enums.dart';

SignUpRequestBody signUpRequestBodyFromJson(String str) => SignUpRequestBody.fromJson(json.decode(str));

String signUpRequestBodyToJson(SignUpRequestBody data) => json.encode(data.toJson());

class SignUpRequestBody {
  final String fullName;
  final String personalEmail;
  final String contactNo;
  final String countryCode;
  final String otp;
  final LoginFormEnum source;

  SignUpRequestBody({
    required this.fullName,
    required this.personalEmail,
    required this.contactNo,
    required this.countryCode,
    required this.otp,
    required this.source,
  });

  factory SignUpRequestBody.fromJson(Map<String, dynamic> json) => SignUpRequestBody(
    fullName: json["fullName"],
    personalEmail: json["personalEmail"],
    contactNo: json["contactNo"],
    countryCode: json["countryCode"],
    otp: json["otp"],
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "personalEmail": personalEmail,
    "contactNo": contactNo,
    "countryCode": countryCode,
    "otp": otp,
    "source": source.value,
  };
}
