// To parse this JSON data, do
//
//     final memberAddressesEntity = memberAddressesEntityFromJson(jsonString);

import 'dart:convert';

import '../dtos/member_details_dto.dart';


MemberAddressesEntity memberAddressesEntityFromJson(String str) =>
    MemberAddressesEntity.fromJson(json.decode(str));

String memberAddressesEntityToJson(MemberAddressesEntity data) =>
    json.encode(data.toJson());

class AddressElement {
  final MemberAddress? memberAddresses;
  final bool? forEdit;
  final bool? forTap;
  bool? isSelected;

  AddressElement({
    this.memberAddresses,
    this.forEdit = false,
    this.forTap,
    this.isSelected,
  });

  factory AddressElement.fromJson(Map<String, dynamic> json) => AddressElement(
        memberAddresses: MemberAddress.fromJson(json["memberAddresses"]),
      );

  Map<String, dynamic> toJson() => {
        "memberAddresses": memberAddresses?.toJson(),
      };
}

class DetailAddress {
  final String? addressLine1;
  final String? addressLine2;
  final String? landmark;
  final String? city;
  final String? state;
  final String? pincode;
  final String? label;
  final String? labelInfo;

  DetailAddress({
    this.addressLine1,
    this.addressLine2,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
    this.label,
    this.labelInfo,
  });

  factory DetailAddress.fromJson(Map<String, dynamic> json) => DetailAddress(
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        label: json["label"],
        labelInfo: json["labelInfo"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1?.trim(),
        "addressLine2": addressLine2?.trim(),
        "landmark": landmark,
        "city": city?.trim(),
        "state": state?.trim(),
        "pincode": pincode?.trim(),
        if (label != null) "label": label,
        if (labelInfo != null && label != "Home")
          "labelInfo": labelInfo?.trim(),
      };
}

class Details {
  final id;
  final DetailAddress? address;
  final GeoLocation? geoLocation;

  Details({
    this.id,
    this.address,
    this.geoLocation,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        address: DetailAddress.fromJson(json["address"]),
        geoLocation: GeoLocation.fromJson(json["geoLocation"]),
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        if (geoLocation?.lat != null && geoLocation?.long != null)
          "geoLocation": geoLocation?.toJson(),
      };
}

class GeoLocation {
  final String? lat;
  final String? long;

  GeoLocation({
    this.lat,
    this.long,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}

class MemberAddressesEntity {
  final List<AddressElement> addresses;

  MemberAddressesEntity({this.addresses = const []});

  factory MemberAddressesEntity.fromJson(Map<String, dynamic> json) =>
      MemberAddressesEntity(
        addresses: List<AddressElement>.from(
            json["addresses"].map((x) => AddressElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
      };
}
