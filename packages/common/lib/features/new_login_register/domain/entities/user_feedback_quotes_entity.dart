import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_feedback_quotes_entity.freezed.dart';
part 'user_feedback_quotes_entity.g.dart';

@freezed
class UserFeedbackQuotesEntity with _$UserFeedbackQuotesEntity {
    const factory UserFeedbackQuotesEntity({
      required String quotes,
      required String author,
      required String authorDesignation,
    }) = _UserFeedbackQuotesEntity;

    factory UserFeedbackQuotesEntity.fromJson(Map<String, dynamic> json) => _$UserFeedbackQuotesEntityFromJson(json);
}
