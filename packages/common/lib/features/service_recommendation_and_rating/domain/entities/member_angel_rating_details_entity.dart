import 'package:common/core/presentation/utils/enums/app_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_angel_rating_details_entity.freezed.dart';
part 'member_angel_rating_details_entity.g.dart';

@freezed
class MemberAngelRatingDetailsEntity with _$MemberAngelRatingDetailsEntity {
  const factory MemberAngelRatingDetailsEntity({
    AppType? appType,
    String? serviceGroupName,
    String? gender,
    bool? showQuestion,
    String? name,
    String? profileUrl,
  }) = _MemberAngelRatingDetailsEntity;

  factory MemberAngelRatingDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$MemberAngelRatingDetailsEntityFromJson(json);
}
