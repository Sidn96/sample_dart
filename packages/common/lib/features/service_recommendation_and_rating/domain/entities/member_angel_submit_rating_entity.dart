import 'package:common/features/member_angel_common_constant/domain/entities/truepal_constant_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_angel_submit_rating_entity.freezed.dart';
part 'member_angel_submit_rating_entity.g.dart';

@freezed
class MemberAngelSubmitRatingEntity with _$MemberAngelSubmitRatingEntity {
  const factory MemberAngelSubmitRatingEntity({
    @Default([]) List<TruepalFeedbackDetail> palFeedbackDetails,
    int? bookingId,
    int? ratings,
    @Default(false) bool isButtonEnabled,
  }) = _MemberAngelSubmitRatingEntity;

  factory MemberAngelSubmitRatingEntity.fromJson(Map<String, dynamic> json) =>
      _$MemberAngelSubmitRatingEntityFromJson(json);
}

@freezed
class PartnerSubmitRatingEntity with _$PartnerSubmitRatingEntity {
  const factory PartnerSubmitRatingEntity({
    @Default([]) List<TruepalFeedbackDetail> memberFeedbackDetails,
    int? bookingId,
    int? ratings,
    int? sessionsRecommended,
    int? recommendedServiceId,
    @Default(false) bool isButtonEnabled,
  }) = _PartnerSubmitRatingEntity;

  factory PartnerSubmitRatingEntity.fromJson(Map<String, dynamic> json) =>
      _$PartnerSubmitRatingEntityFromJson(json);
}

// @freezed
// class PalRecommendationDetail with _$PalRecommendationDetail {
//   const factory PalRecommendationDetail({
//     String? question,
//     String? type,
//     bool? isMandatory,
//     List<String>? options,
//     dynamic value,
//   }) = _PalRecommendationDetail;

//   factory PalRecommendationDetail.fromJson(Map<String, dynamic> json) =>
//       _$PalRecommendationDetailFromJson(json);
// }
