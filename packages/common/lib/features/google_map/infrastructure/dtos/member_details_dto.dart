import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_details_dto.freezed.dart';
part 'member_details_dto.g.dart';

MemberAddress memberAddressFromJson(String str) =>
    MemberAddress.fromJson(json.decode(str));

MemberDetailsDto memberDetailsDtoFromJson(String str) =>
    MemberDetailsDto.fromJson(json.decode(str));

@freezed
class MemberAddress with _$MemberAddress {
  @JsonSerializable(includeIfNull: false)
  const factory MemberAddress({
    int? id,
    String? lat,
    String? long,
    String? addressLine1,
    String? addressLine2,
    String? landmark,
    String? label,
    String? labelInfo,
    String? city,
    String? state,
    String? pincode,
  }) = _MemberAddress;

  factory MemberAddress.fromJson(Map<String, dynamic> json) =>
      _$MemberAddressFromJson(json);
}

@freezed
class MemberDetailsDto with _$MemberDetailsDto {
  const factory MemberDetailsDto({
    int? status,
    bool? success,
    String? message,
    Data? data,
    String? error,
  }) = _MemberDetailsDto;

  factory MemberDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailsDtoFromJson(json);
}

@freezed
class MemberParticipant with _$MemberParticipant {
  @JsonSerializable(includeIfNull: false)
  const factory MemberParticipant({
    String? firstName,
    String? lastName,
    String? phoneNo,
    int? id,
    String? gender,
    String? age,
    String? relationship,
    String? countryCode,
    List<String>? communicationLanguage,
    int? weight,
  }) = _MemberParticipant;

  factory MemberParticipant.fromJson(Map<String, dynamic> json) =>
      _$MemberParticipantFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    String? fullName,
    String? phoneNo,
    String? emailId,
    dynamic dob,
    String? memberId,
    String? status,
    dynamic gender,
    String? ratingCount,
    String? rating,
    dynamic userType,
    dynamic deleteReason,
    dynamic deletionTimestamp,
    bool? isMigrated,
    bool? isActive,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<MemberAddress>? memberAddresses,
    List<MemberParticipant>? memberParticipants,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
