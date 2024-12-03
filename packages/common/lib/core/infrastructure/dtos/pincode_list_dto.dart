// To parse this JSON data, do
//
//     final pincodeListDto = pincodeListDtoFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'pincode_list_dto.freezed.dart';
part 'pincode_list_dto.g.dart';

PincodeListDto pincodeListDtoFromJson(String str) =>
    PincodeListDto.fromJson(json.decode(str));

String pincodeListDtoToJson(PincodeListDto data) => json.encode(data.toJson());

@freezed
class PincodeListDto with _$PincodeListDto {
  const factory PincodeListDto({
    int? status,
    bool? success,
    String? message,
    Data? data,
    String? error,
  }) = _PincodeListDto;

  factory PincodeListDto.fromJson(Map<String, dynamic> json) =>
      _$PincodeListDtoFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    List<EPincode>? basePincodes,
    List<EPincode>? serviceablePincodes,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class EPincode with _$EPincode {
  const factory EPincode({
    String? pincode,
    List<String>? location,
  }) = _EPincode;

  factory EPincode.fromJson(Map<String, dynamic> json) =>
      _$EPincodeFromJson(json);
}
