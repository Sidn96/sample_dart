// To parse this JSON data, do
//
//     final nearbysearchDto = nearbysearchDtoFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'nearbysearch_dto.freezed.dart';
part 'nearbysearch_dto.g.dart';

NearbysearchDto nearbysearchDtoFromJson(String str) =>
    NearbysearchDto.fromJson(json.decode(str));

String nearbysearchDtoToJson(NearbysearchDto data) =>
    json.encode(data.toJson());

@freezed
class Geometry with _$Geometry {
  const factory Geometry({
    Location? location,
    Viewport? viewport,
  }) = _Geometry;

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    double? lat,
    double? lng,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class NearbysearchDto with _$NearbysearchDto {
  const factory NearbysearchDto({
    String? message,
    String? error,
    @JsonKey(name: "data") List<Result>? results,
    int? status,
  }) = _NearbysearchDto;

  factory NearbysearchDto.fromJson(Map<String, dynamic> json) =>
      _$NearbysearchDtoFromJson(json);
}

@freezed
class Result with _$Result {
  const factory Result({
    Geometry? geometry,
    String? name,
    @JsonKey(name: "place_id") String? placeId,
    String? reference,
    String? vicinity,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@freezed
class Viewport with _$Viewport {
  const factory Viewport({
    Location? northeast,
    Location? southwest,
  }) = _Viewport;

  factory Viewport.fromJson(Map<String, dynamic> json) =>
      _$ViewportFromJson(json);
}
