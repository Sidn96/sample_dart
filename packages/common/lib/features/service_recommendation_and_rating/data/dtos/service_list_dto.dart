// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_list_dto.freezed.dart';
part 'service_list_dto.g.dart';

@freezed
class ServiceListDto with _$ServiceListDto {
  const factory ServiceListDto({
    int? status,
    bool? success,
    String? message,
    ServiceData? data,
    String? error,
  }) = _ServiceListDto;

  factory ServiceListDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceListDtoFromJson(json);
}

@freezed
class ServiceData with _$ServiceData {
  const factory ServiceData({
    int? id,
    String? name,
    String? description,
    String? image,
    @JsonKey(name: "service_sub_groups")
    List<ServiceSubGroup>? serviceSubGroups,
  }) = _ServiceData;

  factory ServiceData.fromJson(Map<String, dynamic> json) =>
      _$ServiceDataFromJson(json);
}

@freezed
class ServiceSubGroup with _$ServiceSubGroup {
  const factory ServiceSubGroup({
    int? id,
    int? serviceGroupId,
    String? name,
    dynamic description,
    String? image,
    dynamic order,
    List<Service>? services,
  }) = _ServiceSubGroup;

  factory ServiceSubGroup.fromJson(Map<String, dynamic> json) =>
      _$ServiceSubGroupFromJson(json);
}

@freezed
class Service with _$Service {
  const factory Service({
    int? id,
    int? serviceSubGroupId,
    String? name,
    String? description,
    String? hexCode,
    String? image,
    Details? details,
    int? order,
    int? productCatalogId,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
}

@freezed
class Details with _$Details {
  const factory Details({
    String? type,
    String? title,
    String? hexCode,
    String? subType,
    String? subtitle1,
    String? subtitle2,
    String? cardDescription,
  }) = _Details;

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
}
