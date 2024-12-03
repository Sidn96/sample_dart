import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_data_entity.freezed.dart';
part 'service_data_entity.g.dart';

@freezed
class ServiceDataEntity with _$ServiceDataEntity {
  const factory ServiceDataEntity({
    int? id,
    String? serviceName,
  }) = _ServiceDataEntity;

  factory ServiceDataEntity.fromJson(Map<String, dynamic> json) =>
      _$ServiceDataEntityFromJson(json);
}
