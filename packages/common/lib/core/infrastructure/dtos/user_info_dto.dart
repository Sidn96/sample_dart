// To parse this JSON data, do
//
//     final userInfoDto = userInfoDtoFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_dto.freezed.dart';
part 'user_info_dto.g.dart';

UserInfoDto userInfoDtoFromJson(String str) =>
    UserInfoDto.fromJson(json.decode(str));

String userInfoDtoToJson(UserInfoDto data) => json.encode(data.toJson());

@freezed
class ProductDetail with _$ProductDetail {
  const factory ProductDetail({
    bool? interestedFirstConsult,
    bool? completedFirstConsult,
    bool? isSubscribed,
  }) = _ProductDetail;

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);
}

@freezed
class UserData with _$UserData {
  const factory UserData({
    String? countryCode,
    String? contactNo,
    bool? isEmailVerified,
    bool? isContactNoVerified,
    String? referralCode,
    Map<String, ProductDetail>? productInfo,
    String? personalEmail,
    String? dob,
    String? fullName,
    String? memberId,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

@freezed
class UserInfoDto with _$UserInfoDto {
  const factory UserInfoDto({
    int? status,
    bool? success,
    String? message,
    UserData? data,
    String? error,
  }) = _UserInfoDto;

  factory UserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDtoFromJson(json);
}
