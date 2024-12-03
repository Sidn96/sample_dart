import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../dtos/member_details_dto.dart';

part 'member_address_entity.freezed.dart';
part 'member_address_entity.g.dart';

List<MapAddressEntity> fromModelAddressListaToEntityAddressList(
        List<MemberAddress> modelList) =>
    List<MapAddressEntity>.from(
        (modelList).map((x) => MapAddressEntity.fromModelToEntity(x)));

MapAddressEntity memberAddressEntityFromJson(String str) =>
    MapAddressEntity.fromJson(json.decode(str));

List<MapAddressEntity> memberAddressEntityListFromJson(String str) =>
    List<MapAddressEntity>.from(
        json.decode(str).map((x) => MapAddressEntity.fromJson(x)));

String memberAddressEntityListToJson(List<MapAddressEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String memberAddressEntityToJson(MapAddressEntity data) =>
    json.encode(data.toJson());

@freezed
class MapAddressEntity with _$MapAddressEntity {
  @JsonSerializable(includeIfNull: false)
  const factory MapAddressEntity({
    int? id,
    String? lat,
    String? long,
    String? addressLine1,
    String? addressLine2,
    String? landmark,
    String? label,
    String? labelInfo,
    String? city,
    String? state,
    String? pincode,
    int? editingIndex,
    bool? hasEditedOrNewAdded,
  }) = _MemberAddressEntity;

  factory MapAddressEntity.fromJson(Map<String, dynamic> json) =>
      _$MapAddressEntityFromJson(json);

  factory MapAddressEntity.fromModelToEntity(MemberAddress model) {
    return MapAddressEntity(
      id: model.id,
      lat: model.lat,
      long: model.long,
      addressLine1: model.addressLine1,
      addressLine2: model.addressLine2,
      landmark: model.landmark,
      label: model.label,
      labelInfo: model.labelInfo,
      city: model.city,
      state: model.state,
      pincode: model.pincode,
    );
  }

  const MapAddressEntity._();

  bool checkLableInfo() {
    if (label == "Home") {
      return true;
    } else {
      return labelInfo?.isNotEmpty == true;
    }
  }

  bool isValid() {
    bool result = addressLine1?.isNotEmpty == true &&
        landmark?.isNotEmpty == true &&
        addressLine2?.isNotEmpty == true &&
        lat?.isNotEmpty == true &&
        long?.isNotEmpty == true &&
        label?.isNotEmpty == true &&
        city?.isNotEmpty == true &&
        state?.isNotEmpty == true &&
        pincode?.isNotEmpty == true &&
        checkLableInfo() == true;
    return result;
  }
}
