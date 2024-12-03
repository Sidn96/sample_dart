import 'package:freezed_annotation/freezed_annotation.dart';

part 'help_support_dto.freezed.dart';
part 'help_support_dto.g.dart';

@freezed
class HelpSupportDto with _$HelpSupportDto {
  const factory HelpSupportDto({
    int? status,
    bool? success,
    String? message,
    HelpSupportData? data,
    String? error,
  }) = _HelpSupportDto;

  factory HelpSupportDto.fromJson(Map<String, dynamic> json) =>
      _$HelpSupportDtoFromJson(json);
}

@freezed
class HelpSupportData with _$HelpSupportData {
  const factory HelpSupportData({
    String? member,
    String? pal,
    String? email,
    @JsonKey(name: "PAL_TIMING") String? palTiming,
    @JsonKey(name: "MEMBER_TIMING") String? memberTiming,
  }) = _HelpSupportData;

  factory HelpSupportData.fromJson(Map<String, dynamic> json) =>
      _$HelpSupportDataFromJson(json);
}
