import 'package:common/features/help_support/data/dtos/help_support_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'help_support_entity.freezed.dart';

@freezed
class HelpSupportDataEntity with _$HelpSupportDataEntity {
  const factory HelpSupportDataEntity({
    String? partnerPhoneNumber1,
    String? partnerPhoneNumber2,
    String? memberPhoneNumber1,
    String? memberPhoneNumber2,
    String? email,
    String? palTiming,
    String? memberTiming,
  }) = _HelpSupportDataEntity;

  factory HelpSupportDataEntity.toEntity(HelpSupportData? data) {
    List<String> partnerPh = data?.pal?.split(",") ?? [];
    List<String> memberPh = data?.member?.split(",") ?? [];

    return HelpSupportDataEntity(
      partnerPhoneNumber1: (partnerPh.isNotEmpty) ? partnerPh[0].trim() : "",
      partnerPhoneNumber2: (partnerPh.length > 1) ? partnerPh[1].trim() : "",
      memberPhoneNumber1: (memberPh.isNotEmpty) ? memberPh[0].trim() : "",
      memberPhoneNumber2: (memberPh.length > 1) ? memberPh[1].trim() : "",
      email: data?.email,
      palTiming: data?.palTiming,
      memberTiming: data?.memberTiming,
    );
  }
}
