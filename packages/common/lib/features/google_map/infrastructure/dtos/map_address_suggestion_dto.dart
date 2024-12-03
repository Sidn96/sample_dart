// To parse this JSON data, do
//
//     final mapAddressSuggestionDto = mapAddressSuggestionDtoFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_address_suggestion_dto.freezed.dart';
part 'map_address_suggestion_dto.g.dart';

MapAddressSuggestionDto mapAddressSuggestionDtoFromJson(String str) =>
    MapAddressSuggestionDto.fromJson(json.decode(str));

String mapAddressSuggestionDtoToJson(MapAddressSuggestionDto data) =>
    json.encode(data.toJson());

@freezed
class MapAddressSuggestionDto with _$MapAddressSuggestionDto {
  const factory MapAddressSuggestionDto({
    int? status,
    @JsonKey(name: "data") List<Prediction>? predictions,
    String? message,
    String? error,
  }) = _MapAddressSuggestionDto;

  factory MapAddressSuggestionDto.fromJson(Map<String, dynamic> json) =>
      _$MapAddressSuggestionDtoFromJson(json);
}

@freezed
class Prediction with _$Prediction {
  const factory Prediction({
    String? description,
    @JsonKey(name: "place_id") String? placeId,
    String? reference,
    @JsonKey(name: "structured_formatting")
    StructuredFormatting? structuredFormatting,
  }) = _Prediction;

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);
}

@freezed
class StructuredFormatting with _$StructuredFormatting {
  const factory StructuredFormatting({
    @JsonKey(name: "main_text") String? mainText,
    @JsonKey(name: "secondary_text") String? secondaryText,
  }) = _StructuredFormatting;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);
}
