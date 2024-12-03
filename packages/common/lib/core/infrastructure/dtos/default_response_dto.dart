// To parse this JSON data, do
//
//     final defaultResponsedto = defaultResponsedtoFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'default_response_dto.freezed.dart';
part 'default_response_dto.g.dart';

DefaultResponsedto defaultResponsedtoFromJson(String str) =>
    DefaultResponsedto.fromJson(json.decode(str));

String defaultResponsedtoToJson(DefaultResponsedto data) =>
    json.encode(data.toJson());

@freezed
class Data with _$Data {
  const factory Data() = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class DefaultResponsedto with _$DefaultResponsedto {
  const factory DefaultResponsedto({
    int? status,
    bool? success,
    String? message,
    Data? data,
    String? error,
  }) = _DefaultResponsedto;

  factory DefaultResponsedto.fromJson(Map<String, dynamic> json) =>
      _$DefaultResponsedtoFromJson(json);
}
