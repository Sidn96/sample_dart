import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner_ref_messages_dto.freezed.dart';
part 'partner_ref_messages_dto.g.dart';

@freezed
class Data with _$Data {
  const factory Data({
    DirectMessage? directMessage,
    Story? story,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class DirectMessage with _$DirectMessage {
  const factory DirectMessage({
    String? title,
    String? message,
  }) = _DirectMessage;

  factory DirectMessage.fromJson(Map<String, dynamic> json) =>
      _$DirectMessageFromJson(json);
}

@freezed
class PartnerRefMessagesDto with _$PartnerRefMessagesDto {
  const factory PartnerRefMessagesDto({
    int? status,
    bool? success,
    String? message,
    Data? data,
    String? error,
  }) = _PartnerRefMessagesDto;

  factory PartnerRefMessagesDto.fromJson(Map<String, dynamic> json) =>
      _$PartnerRefMessagesDtoFromJson(json);
}

@freezed
class Story with _$Story {
  const factory Story({
    String? title,
    String? message,
    String? image,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
