// To parse this JSON data, do
//
//     final googleMapSearchedPlaceDto = googleMapSearchedPlaceDtoFromJson(jsonString);

import 'dart:convert';

import 'package:collection/collection.dart';

GoogleMapSearchedPlaceDto googleMapSearchedPlaceDtoFromJson(String str) =>
    GoogleMapSearchedPlaceDto.fromJson(json.decode(str));

String googleMapSearchedPlaceDtoToJson(GoogleMapSearchedPlaceDto data) =>
    json.encode(data.toJson());

class AddressComponent {
  final String? longName;
  final String? shortName;
  final List<String>? types;

  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
      };
}

class Geometry {
  final Location? location;
  final Viewport? viewport;

  Geometry({
    this.location,
    this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        viewport: json["viewport"] == null
            ? null
            : Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "viewport": viewport?.toJson(),
      };
}

class GoogleMapSearchedPlaceDto {
  final String? status;
  final Result? result;
  final String? message;
  final String? error;

  GoogleMapSearchedPlaceDto({
    this.status,
    this.result,
    this.message,
    this.error,
  });

  factory GoogleMapSearchedPlaceDto.fromJson(Map<String, dynamic> json) {
    List<Result> rawRess = json["data"].containsKey("results")
        ? List<Result>.from(
            json["data"]["results"].map((x) => Result.fromJson(x)))
        : [];

    Result finalAddRws = Result();

    for (var addres in rawRess) {
      if (addres.pincode != null || addres.pincode != "") {
        finalAddRws = addres;
        break;
      }
    }

    return GoogleMapSearchedPlaceDto(
      result: finalAddRws.pincode != null
          ? finalAddRws
          : rawRess.isEmpty
              ? json["data"] == null
                  ? null
                  : Result.fromJson(json["data"])
              : rawRess.isEmpty
                  ? null
                  : rawRess[0],
      status: json["data"]["status"],
      message: json["message"],
      error: json["error"],
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "status": status,
      };
}

class Location {
  final double? lat;
  final double? lng;

  Location({
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Result {
  final List<AddressComponent>? addressComponents;
  final String? adrAddress;
  final String? formattedAddress;
  final String? addressline2;
  final Geometry? geometry;
  final String? name;
  final String? subName;
  final String? pincode;
  final String? city;
  final String? state;
  final String? placeId;

  Result({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.addressline2,
    this.geometry,
    this.name,
    this.subName,
    this.city,
    this.pincode,
    this.state,
    this.placeId,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    List<String> rawAddressLine2 = json["formatted_address"].split(",");

    List<AddressComponent>? addressComponents =
        json["address_components"] == null
            ? []
            : List<AddressComponent>.from(json["address_components"]!
                .map((x) => AddressComponent.fromJson(x)));

    final AddressComponent? addressPinComponent =
        addressComponents.firstWhereOrNull((com) {
      if (com.types != null && com.types!.contains("postal_code")) {
        return true;
      } else {
        return false;
      }
    });

    final AddressComponent? addressCityComponent =
        addressComponents.firstWhereOrNull((com) {
      if (com.types != null && com.types!.contains("locality")) {
        return true;
      } else {
        return false;
      }
    });

    final AddressComponent? addressstreetNu =
        addressComponents.firstWhereOrNull((com) {
      if (com.types != null && com.types!.contains("street_number")) {
        return true;
      } else {
        return false;
      }
    });

    final AddressComponent? addresssubpremise =
        addressComponents.firstWhereOrNull((com) {
      if (com.types != null && com.types!.contains("subpremise")) {
        return true;
      } else {
        return false;
      }
    });

    final AddressComponent? addressStateComponent =
        addressComponents.firstWhereOrNull((com) {
      if (com.types != null &&
          com.types!.contains("administrative_area_level_1")) {
        return true;
      } else {
        return false;
      }
    });

    final AddressComponent? addressRouteComponent =
        addressComponents.firstWhereOrNull((com) {
      if (com.types != null && com.types!.contains("sublocality_level_2")) {
        return true;
      } else {
        return false;
      }
    });

    final AddressComponent? addressRoute3Component =
        addressComponents.firstWhereOrNull((com) {
      if (com.types != null && com.types!.contains("sublocality_level_3")) {
        return true;
      } else {
        return false;
      }
    });

    final AddressComponent? addressRoute0Component =
        addressComponents.firstWhereOrNull((com) {
      if (com.types != null && com.types!.contains("route")) {
        return true;
      } else {
        return false;
      }
    });

    final AddressComponent? addresspluscode =
        addressComponents.firstWhereOrNull((com) {
      if (com.types != null && com.types!.contains("plus_code")) {
        return true;
      } else {
        return false;
      }
    });

    final AddressComponent? addresspremise =
        addressComponents.firstWhereOrNull((com) {
      if (com.types != null && com.types!.contains("premise")) {
        return true;
      } else {
        return false;
      }
    });

    rawAddressLine2
        .removeWhere((add) => add.contains("${addressPinComponent?.longName}"));
    rawAddressLine2.removeWhere(
        (add) => add.contains("${addressCityComponent?.longName}"));
    rawAddressLine2.removeWhere(
        (add) => add.contains("${addressCityComponent?.longName}"));
    rawAddressLine2.removeWhere(
        (add) => add.contains("${addressStateComponent?.longName}"));
    rawAddressLine2.removeWhere((add) => add.contains(
        "${addressStateComponent?.longName} ${addressPinComponent?.longName}"));
    String? subTitle = addressRouteComponent?.longName ??
        addressRoute3Component?.longName ??
        addressRoute0Component?.longName;
    String add2 = rawAddressLine2.join(", ");

    final pluscoderaw = addresspluscode?.longName;

    String finalAddress = json["formatted_address"];
    final addrawlist = finalAddress.split(",");
    final rawadd2 = add2.split(",");

    rawadd2.remove(pluscoderaw);
    rawadd2.remove(" $pluscoderaw");
    addrawlist.remove(pluscoderaw);
    addrawlist.remove(" $pluscoderaw");
    addrawlist.remove(addressstreetNu?.longName);
    addrawlist.remove(" ${addressstreetNu?.longName}");
    addrawlist.remove(addresssubpremise?.longName);
    addrawlist.remove(" ${addresssubpremise?.longName}");
    addrawlist.remove(addresssubpremise?.longName);
    addrawlist.remove(" ${addresssubpremise?.longName}");
    addrawlist.remove(addresspremise?.longName);
    addrawlist.remove(" ${addresspremise?.longName}");
    rawadd2.remove(pluscoderaw);
    rawadd2.remove(" $pluscoderaw");
    rawadd2.remove(addressstreetNu?.longName);
    rawadd2.remove(" ${addressstreetNu?.longName}");
    rawadd2.remove(addresssubpremise?.longName);
    rawadd2.remove(" ${addresssubpremise?.longName}");
    rawadd2.remove(addresssubpremise?.longName);
    rawadd2.remove(" ${addresssubpremise?.longName}");
    rawadd2.remove(addresspremise?.longName);
    rawadd2.remove(" ${addresspremise?.longName}");

    return Result(
      addressComponents: addressComponents,
      adrAddress: json["adr_address"],
      formattedAddress: addrawlist.join(),
      addressline2: rawadd2.join(","),
      geometry:
          json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
      name: json["name"],
      subName: subTitle,
      pincode: addressPinComponent?.longName,
      city: addressCityComponent?.longName,
      state: addressStateComponent?.longName,
      placeId: json["place_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "address_components": addressComponents == null
            ? []
            : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
        "adr_address": adrAddress,
        "formatted_address": formattedAddress,
        "geometry": geometry?.toJson(),
        "name": name,
      };
}

class Viewport {
  final Location? northeast;
  final Location? southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: json["northeast"] == null
            ? null
            : Location.fromJson(json["northeast"]),
        southwest: json["southwest"] == null
            ? null
            : Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast?.toJson(),
        "southwest": southwest?.toJson(),
      };
}
