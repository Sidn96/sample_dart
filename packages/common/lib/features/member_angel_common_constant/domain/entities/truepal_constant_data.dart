import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dtos/member_angel_common_constant_dto.dart';

part 'truepal_constant_data.freezed.dart';
part 'truepal_constant_data.g.dart';

@freezed
class TruepalConstantData with _$TruepalConstantData {
  const factory TruepalConstantData({
    List<TruepalFeedbackDetail>? palFeedbackDetails,
    List<TruepalFeedbackDetail>? memberFeedbackDetails,
    List<String>? subscriberTrackStatus,
    List<String>? cancellationReason,
    List<String>? validAddressLabels,
  }) = _TruepalConstantData;

  factory TruepalConstantData.fromJson(Map<String, dynamic> json) =>
      _$TruepalConstantDataFromJson(json);

  factory TruepalConstantData.toEntity(MemberAngelCommonConstantData data) =>
      TruepalConstantData(
        palFeedbackDetails: data.palFeedbackDetails
            ?.map((e) => TruepalFeedbackDetail.toEntity(e))
            .toList(),
        memberFeedbackDetails: data.memberFeedbackDetails
            ?.map((e) => TruepalFeedbackDetail.toEntity(e))
            .toList(),
        subscriberTrackStatus: data.subscriberTrackStatus,
        cancellationReason: data.cancellationReason,
        validAddressLabels: data.validAddressLabels,
      );
}

@freezed
class TruepalFeedbackDetail with _$TruepalFeedbackDetail {
  const factory TruepalFeedbackDetail({
    String? question,
    String? type,
    dynamic value,
    bool? isMandatory,
    int? min,
    int? max,
    List<String>? options,
  }) = _TruepalFeedbackDetail;

  factory TruepalFeedbackDetail.fromJson(Map<String, dynamic> json) =>
      _$TruepalFeedbackDetailFromJson(json);

  factory TruepalFeedbackDetail.toEntity(MemberAngelFeedbackDetail data) =>
      TruepalFeedbackDetail(
        question: data.question,
        type: data.type,
        value: data.value,
        isMandatory: data.isMandatory,
        min: data.min,
        max: data.max,
        options: data.options,
      );
}
