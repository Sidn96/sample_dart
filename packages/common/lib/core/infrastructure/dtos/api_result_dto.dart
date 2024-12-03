// To parse this JSON data, do
//
//     final apiResultDto = apiResultDtoFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result_dto.freezed.dart';
part 'api_result_dto.g.dart';

ApiResultDto apiResultDtoFromJson(String str) =>
    ApiResultDto.fromJson(json.decode(str));

String apiResultDtoToJson(ApiResultDto data) => json.encode(data.toJson());

@freezed
class ApiResultDto with _$ApiResultDto {
  const factory ApiResultDto({
    dynamic status,
    bool? success,
    String? message,
    Data? data,
    String? error,
  }) = _ApiResultDto;

  factory ApiResultDto.fromJson(Map<String, dynamic> json) =>
      _$ApiResultDtoFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data() = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
