import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_angel_common_constant_dto.freezed.dart';
part 'member_angel_common_constant_dto.g.dart';

@freezed
class MemberAngelCommonConstantData with _$MemberAngelCommonConstantData {
  const factory MemberAngelCommonConstantData({
    @JsonKey(name: "BOOKING_STATUS_TYPE") List<String>? bookingStatusType,
    @JsonKey(name: "PAL_ONBOARDING_STATUS") List<String>? palOnboardingStatus,
    @JsonKey(name: "AGE_GROUP_LIST") List<String>? ageGroupList,
    @JsonKey(name: "PAYMENT_STATUS_TYPE") List<String>? paymentStatusType,
    @JsonKey(name: "VALID_CURRENCIES") List<String>? validCurrencies,
    @JsonKey(name: "PAL_PROFILE_TYPE") List<String>? palProfileType,
    @JsonKey(name: "PAL_FEEDBACK_DETAILS")
    List<MemberAngelFeedbackDetail>? palFeedbackDetails,
    @JsonKey(name: "MEMBER_FEEDBACK_DETAILS")
    List<MemberAngelFeedbackDetail>? memberFeedbackDetails,
    @JsonKey(name: "SUBSCRIBER_TRACK_STATUS")
    List<String>? subscriberTrackStatus,
    @JsonKey(name: "CANCELLATION_REASON") List<String>? cancellationReason,
    @JsonKey(name: "VALID_ADDRESS_LABELS") List<String>? validAddressLabels,
  }) = _MemberAngelCommonConstantData;

  factory MemberAngelCommonConstantData.fromJson(Map<String, dynamic> json) =>
      _$MemberAngelCommonConstantDataFromJson(json);
}

@freezed
class MemberAngelCommonConstantDto with _$MemberAngelCommonConstantDto {
  const factory MemberAngelCommonConstantDto({
    int? status,
    bool? success,
    String? message,
    MemberAngelCommonConstantData? data,
    String? error,
  }) = _MemberAngelCommonConstantDto;

  factory MemberAngelCommonConstantDto.fromJson(Map<String, dynamic> json) =>
      _$MemberAngelCommonConstantDtoFromJson(json);
}

@freezed
class MemberAngelFeedbackDetail with _$MemberAngelFeedbackDetail {
  const factory MemberAngelFeedbackDetail({
    String? question,
    String? type,
    dynamic value,
    bool? isMandatory,
    int? min,
    int? max,
    List<String>? options,
  }) = _MemberAngelFeedbackDetail;

  factory MemberAngelFeedbackDetail.fromJson(Map<String, dynamic> json) =>
      _$MemberAngelFeedbackDetailFromJson(json);
}

@freezed
class Misc with _$Misc {
  const factory Misc({
    String? noShow,
    String? rescheduledBooking,
  }) = _Misc;

  factory Misc.fromJson(Map<String, dynamic> json) => _$MiscFromJson(json);
}
