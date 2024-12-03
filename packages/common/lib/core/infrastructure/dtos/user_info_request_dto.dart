// To parse this JSON data, do
//
//     final userInfoRequestDto = userInfoRequestDtoFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_request_dto.freezed.dart';
part 'user_info_request_dto.g.dart';

UserInfoRequestDto userInfoRequestDtoFromJson(String str) =>
    UserInfoRequestDto.fromJson(json.decode(str));

String userInfoRequestDtoToJson(UserInfoRequestDto data) =>
    json.encode(data.toJson());

@freezed
class CorporateDetail with _$CorporateDetail {
  const factory CorporateDetail({
    String? corporateId,
    String? designation,
    String? corporateName,
    String? corporateEmail,
    int? annualIncome,
  }) = _CorporateDetail;

  factory CorporateDetail.fromJson(Map<String, dynamic> json) =>
      _$CorporateDetailFromJson(json);
}

@freezed
class UserInfoRequestDto with _$UserInfoRequestDto {
  @JsonSerializable(includeIfNull: false)
  const factory UserInfoRequestDto({
    String? fullName,
    String? personalEmail,
    String? dob,
    String? gender,
    String? profilePic,
    String? maritalStatus,
    String? alternateContactNo,
    List<CorporateDetail>? corporateDetails,
  }) = _UserInfoRequestDto;

  factory UserInfoRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserInfoRequestDtoFromJson(json);
}
