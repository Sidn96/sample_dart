import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_list_dto.freezed.dart';
part 'service_list_dto.g.dart';

@freezed
class ServiceListDto with _$ServiceListDto {
  const factory ServiceListDto({
    required int status,
    required bool success,
    required String message,
    required List<ServiceListData>? data,
    required String error,
  }) = _ServiceListDto;

  factory ServiceListDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceListDtoFromJson(json);
}

@freezed
class ServiceListData with _$ServiceListData {
  const factory ServiceListData({
    int? id,
    String? name,
    String? description,
    String? image,
  }) = _ServiceType;

  factory ServiceListData.fromJson(Map<String, dynamic> json) =>
      _$ServiceListDataFromJson(json);
}
