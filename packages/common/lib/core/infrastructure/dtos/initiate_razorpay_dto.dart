// To parse this JSON data, do
//
//     final initiateRazorpayDto = initiateRazorpayDtoFromJson(jsonString);

import 'dart:convert';

InitiateRazorpayDto initiateRazorpayDtoFromJson(String str) =>
    InitiateRazorpayDto.fromJson(json.decode(str));

String initiateRazorpayDtoToJson(InitiateRazorpayDto data) =>
    json.encode(data.toJson());


class InitiateRazorpayDto {
  int? status;
  bool? success;
  String? message;
  InitiateRazorpayData? data;
  String? error;

  InitiateRazorpayDto({
    this.status,
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory InitiateRazorpayDto.fromJson(Map<String, dynamic> json) =>
      InitiateRazorpayDto(
        status: json["status"] ?? json["statusCode"],
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: InitiateRazorpayData.fromJson(json["data"]),
        error: json["error"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "error": error,
  };
}

class InitiateRazorpayData {
  CheckoutDetails checkoutDetails;

  InitiateRazorpayData({
    required this.checkoutDetails,
  });

  factory InitiateRazorpayData.fromJson(Map<String, dynamic> json) =>
      InitiateRazorpayData(
        checkoutDetails: CheckoutDetails.fromJson(json["checkoutDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "checkoutDetails": checkoutDetails.toJson(),
      };
}

class CheckoutDetails {
  String key;
  int amount;
  String currency;
  String name;
  String? image;
  String orderId;
  String callbackUrl;
  Prefill prefill;
  Notes notes;
  Theme theme;

  CheckoutDetails({
    required this.key,
    required this.amount,
    required this.currency,
    required this.name,
    this.image,
    required this.orderId,
    required this.callbackUrl,
    required this.prefill,
    required this.notes,
    required this.theme,
  });

  factory CheckoutDetails.fromJson(Map<String, dynamic> json) =>
      CheckoutDetails(
        key: json["key"],
        amount: json["amount"],
        currency: json["currency"],
        name: json["name"],
        image: json["image"],
        orderId: json["order_id"],
        callbackUrl: json["callback_url"],
        prefill: Prefill.fromJson(json["prefill"]),
        notes: Notes.fromJson(json["notes"]),
        theme: Theme.fromJson(json["theme"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "amount": amount,
        "currency": currency,
        "name": name,
        if (image != null) "image": image,
        "order_id": orderId,
        "callback_url": callbackUrl,
        "prefill": prefill.toJson(),
        "notes": notes.toJson(),
        "theme": theme.toJson(),
      };

  String toUrlParamString() =>
      "?k=$key&a=$amount&c=$currency&n=$name&i=$image&o=$orderId&cb=$callbackUrl&pn=${prefill.name}&pe=${prefill.email}&pc=${prefill.contact}&nt=${notes.txnNo}&tc=${theme.color}";
}

class Notes {
  String txnNo;

  Notes({
    required this.txnNo,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        txnNo: json["txnNo"],
      );

  Map<String, dynamic> toJson() => {
        "txnNo": txnNo,
      };
}

class Prefill {
  String? name;
  String? email;
  String? contact;

  Prefill({
    this.name,
    this.email,
     this.contact,
  });

  factory Prefill.fromJson(Map<String, dynamic> json) => Prefill(
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        if (name != null) "name": name,
        if (email != null) "email": email,
        "contact": contact,
      };
}

class Theme {
  String color;

  Theme({
    required this.color,
  });

  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
      };
}
