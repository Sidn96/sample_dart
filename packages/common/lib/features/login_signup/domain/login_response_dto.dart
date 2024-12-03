// To parse this JSON data, do
//
//     final loginResponseBodyDto = loginResponseBodyDtoFromJson(jsonString);

import 'dart:convert';

LoginResponseBodyDto loginResponseBodyDtoFromJson(String str) => LoginResponseBodyDto.fromJson(json.decode(str));

String loginResponseBodyDtoToJson(LoginResponseBodyDto data) => json.encode(data.toJson());

class LoginResponseBodyDto {
  final int? status;
  final bool? success;
  final String? message;
  final Data? data;
  final String? error;

  LoginResponseBodyDto({
    this.status,
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory LoginResponseBodyDto.fromJson(Map<String, dynamic> json) => LoginResponseBodyDto(
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
  final Tokens? tokens;

  Data({
    this.tokens,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
  );

  Map<String, dynamic> toJson() => {
    "tokens": tokens?.toJson(),
  };
}

class Tokens {
  final String? accessToken;
  final String? refreshToken;

  Tokens({
    this.accessToken,
    this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
