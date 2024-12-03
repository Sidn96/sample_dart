// To parse this JSON data, do
//
//     final responseBodyDto = responseBodyDtoFromJson(jsonString);

import 'dart:convert';

SendOtpResponseBodyDto responseBodyDtoFromJson(String str) => SendOtpResponseBodyDto.fromJson(json.decode(str));

String responseBodyDtoToJson(SendOtpResponseBodyDto data) => json.encode(data.toJson());

class SendOtpResponseBodyDto {
  final int? status;
  final bool? success;
  final String? message;
  final Data? data;
  final String? error;

  SendOtpResponseBodyDto({
    this.status,
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory SendOtpResponseBodyDto.fromJson(Map<String, dynamic> json) => SendOtpResponseBodyDto(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "error": error,
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
