// To parse this JSON data, do
//
//     final userOnboardEntity = userOnboardEntityFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_onboard_entity.freezed.dart';
part 'user_onboard_entity.g.dart';

UserOnboardEntity userOnboardEntityFromJson(String str) =>
    UserOnboardEntity.fromJson(json.decode(str));

String userOnboardEntityToJson(UserOnboardEntity data) =>
    json.encode(data.toJson());

@freezed
class Geolocator with _$Geolocator {
  const factory Geolocator({
    double? lat,
    double? lang,
  }) = _Geolocator;

  factory Geolocator.fromJson(Map<String, dynamic> json) =>
      _$GeolocatorFromJson(json);
}

@freezed
class UserOnboardEntity with _$UserOnboardEntity {
  const factory UserOnboardEntity({
    @Default(false) bool isServicable,
    String? pincode,
    String? address,
    String? city,
    String? state,
    String? placeId,
    Geolocator? geolocator,
  }) = _UserOnboardEntity;

  factory UserOnboardEntity.fromJson(Map<String, dynamic> json) =>
      _$UserOnboardEntityFromJson(json);
}
