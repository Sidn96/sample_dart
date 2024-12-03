// To parse this JSON data, do
//
//     final googleMapPlaceIdDto = googleMapPlaceIdDtoFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_map_place_id_dto.freezed.dart';
part 'google_map_place_id_dto.g.dart';

GoogleMapPlaceIdDto googleMapPlaceIdDtoFromJson(String str) =>
    GoogleMapPlaceIdDto.fromJson(json.decode(str));

String googleMapPlaceIdDtoToJson(GoogleMapPlaceIdDto data) =>
    json.encode(data.toJson());

@freezed
class Candidate with _$Candidate {
  const factory Candidate({
    @JsonKey(name: "place_id") String? placeId,
  }) = _Candidate;

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);
}

@freezed
class GoogleMapPlaceIdDto with _$GoogleMapPlaceIdDto {
  const factory GoogleMapPlaceIdDto({
    List<Candidate>? candidates,
    String? status,
  }) = _GoogleMapPlaceIdDto;

  factory GoogleMapPlaceIdDto.fromJson(Map<String, dynamic> json) =>
      _$GoogleMapPlaceIdDtoFromJson(json);
}
