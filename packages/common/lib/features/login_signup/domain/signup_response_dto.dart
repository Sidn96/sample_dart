// To parse this JSON data, do
//
//     final signUpResponseBody = signUpResponseBodyFromJson(jsonString);

/*
import 'dart:convert';

SignUpResponseBody signUpResponseBodyFromJson(String str) => SignUpResponseBody.fromJson(json.decode(str));

String signUpResponseBodyToJson(SignUpResponseBody data) => json.encode(data.toJson());

class SignUpResponseBody {
  final int status;
  final bool success;
  final String message;
  final Data data;
  final String error;

  SignUpResponseBody({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
    required this.error,
  });

  factory SignUpResponseBody.fromJson(Map<String, dynamic> json) => SignUpResponseBody(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
    "error": error,
  };
}

class Data {
  final String fullName;
  final String personalEmail;
  final String countryCode;
  final String contactNo;
  final List<dynamic> corporateDetails;
  final bool isEmailVerified;
  final bool isContactNoVerified;
  final String status;
  final String referralCode;
  final String source;
  final bool isWhatsappCommEnabled;
  final ProductInfo productInfo;
  final List<dynamic> familyMembers;
  final String createdAt;
  final String updatedAt;
  final Tokens tokens;

  Data({
    required this.fullName,
    required this.personalEmail,
    required this.countryCode,
    required this.contactNo,
    required this.corporateDetails,
    required this.isEmailVerified,
    required this.isContactNoVerified,
    required this.status,
    required this.referralCode,
    required this.source,
    required this.isWhatsappCommEnabled,
    required this.productInfo,
    required this.familyMembers,
    required this.createdAt,
    required this.updatedAt,
    required this.tokens,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fullName: json["fullName"],
    personalEmail: json["personalEmail"],
    countryCode: json["countryCode"],
    contactNo: json["contactNo"],
    corporateDetails: List<dynamic>.from(json["corporateDetails"].map((x) => x)),
    isEmailVerified: json["isEmailVerified"],
    isContactNoVerified: json["isContactNoVerified"],
    status: json["status"],
    referralCode: json["referralCode"],
    source: json["source"],
    isWhatsappCommEnabled: json["isWhatsappCommEnabled"],
    productInfo: ProductInfo.fromJson(json["productInfo"]),
    familyMembers: List<dynamic>.from(json["familyMembers"].map((x) => x)),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    tokens: Tokens.fromJson(json["tokens"]),
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "personalEmail": personalEmail,
    "countryCode": countryCode,
    "contactNo": contactNo,
    "corporateDetails": List<dynamic>.from(corporateDetails.map((x) => x)),
    "isEmailVerified": isEmailVerified,
    "isContactNoVerified": isContactNoVerified,
    "status": status,
    "referralCode": referralCode,
    "source": source,
    "isWhatsappCommEnabled": isWhatsappCommEnabled,
    "productInfo": productInfo.toJson(),
    "familyMembers": List<dynamic>.from(familyMembers.map((x) => x)),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "tokens": tokens.toJson(),
  };
}

class ProductInfo {
  final Rc rc;

  ProductInfo({
    required this.rc,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
    rc: Rc.fromJson(json["rc"]),
  );

  Map<String, dynamic> toJson() => {
    "rc": rc.toJson(),
  };
}

class Rc {
  final bool interestedFirstConsult;
  final bool completedFirstConsult;
  final bool isSubscribed;

  Rc({
    required this.interestedFirstConsult,
    required this.completedFirstConsult,
    required this.isSubscribed,
  });

  factory Rc.fromJson(Map<String, dynamic> json) => Rc(
    interestedFirstConsult: json["interestedFirstConsult"],
    completedFirstConsult: json["completedFirstConsult"],
    isSubscribed: json["isSubscribed"],
  );

  Map<String, dynamic> toJson() => {
    "interestedFirstConsult": interestedFirstConsult,
    "completedFirstConsult": completedFirstConsult,
    "isSubscribed": isSubscribed,
  };
}

class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
*/

// To parse this JSON data, do
//
//     final signUpResponseBody = signUpResponseBodyFromJson(jsonString);

import 'dart:convert';

SignUpResponseBody signUpResponseBodyFromJson(String str) => SignUpResponseBody.fromJson(json.decode(str));

String signUpResponseBodyToJson(SignUpResponseBody data) => json.encode(data.toJson());

class SignUpResponseBody {
  final int? status;
  final bool? success;
  final String? message;
  final Data? data;
  final String? error;

  SignUpResponseBody({
    this.status,
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory SignUpResponseBody.fromJson(Map<String, dynamic> json) => SignUpResponseBody(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "error": error,
  };
}

class Data {
  final String? fullName;
  final String? personalEmail;
  final String? countryCode;
  final String? contactNo;
  final List<dynamic>? corporateDetails;
  final bool? isEmailVerified;
  final bool? isContactNoVerified;
  final String? status;
  final String? referralCode;
  final String? source;
  final bool? isWhatsappCommEnabled;
  final ProductInfo? productInfo;
  final List<dynamic>? familyMembers;
  final String? createdAt;
  final String? updatedAt;
  final Tokens? tokens;
  final String? memberId;
  final bool? registration;

  Data({
    this.fullName,
    this.personalEmail,
    this.countryCode,
    this.contactNo,
    this.corporateDetails,
    this.isEmailVerified,
    this.isContactNoVerified,
    this.status,
    this.referralCode,
    this.source,
    this.isWhatsappCommEnabled,
    this.productInfo,
    this.familyMembers,
    this.createdAt,
    this.updatedAt,
    this.tokens,
    this.memberId,
    this.registration,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fullName: json["fullName"],
        personalEmail: json["personalEmail"],
        countryCode: json["countryCode"],
        contactNo: json["contactNo"],
        corporateDetails: json["corporateDetails"] == null
            ? []
            : List<dynamic>.from(json["corporateDetails"]!.map((x) => x)),
        isEmailVerified: json["isEmailVerified"],
        isContactNoVerified: json["isContactNoVerified"],
        status: json["status"],
        referralCode: json["referralCode"],
        source: json["source"],
        isWhatsappCommEnabled: json["isWhatsappCommEnabled"],
        productInfo: json["productInfo"] == null
            ? null
            : ProductInfo.fromJson(json["productInfo"]),
        familyMembers: json["familyMembers"] == null
            ? []
            : List<dynamic>.from(json["familyMembers"]!.map((x) => x)),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
        memberId: json["memberId"],
        registration: json["registration"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "personalEmail": personalEmail,
        "countryCode": countryCode,
        "contactNo": contactNo,
        "corporateDetails": corporateDetails == null
            ? []
            : List<dynamic>.from(corporateDetails!.map((x) => x)),
        "isEmailVerified": isEmailVerified,
        "isContactNoVerified": isContactNoVerified,
        "status": status,
        "referralCode": referralCode,
        "source": source,
        "isWhatsappCommEnabled": isWhatsappCommEnabled,
        "productInfo": productInfo?.toJson(),
        "familyMembers": familyMembers == null
            ? []
            : List<dynamic>.from(familyMembers!.map((x) => x)),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "tokens": tokens?.toJson(),
        "memberId": memberId,
        "registration":registration,
      };
}

class ProductInfo {
  final Rc? rc;

  ProductInfo({
    this.rc,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
    rc: json["rc"] == null ? null : Rc.fromJson(json["rc"]),
  );

  Map<String, dynamic> toJson() => {
    "rc": rc?.toJson(),
  };
}

class Rc {
  final bool? interestedFirstConsult;
  final bool? completedFirstConsult;
  final bool? isSubscribed;

  Rc({
    this.interestedFirstConsult,
    this.completedFirstConsult,
    this.isSubscribed,
  });

  factory Rc.fromJson(Map<String, dynamic> json) => Rc(
    interestedFirstConsult: json["interestedFirstConsult"],
    completedFirstConsult: json["completedFirstConsult"],
    isSubscribed: json["isSubscribed"],
  );

  Map<String, dynamic> toJson() => {
    "interestedFirstConsult": interestedFirstConsult,
    "completedFirstConsult": completedFirstConsult,
    "isSubscribed": isSubscribed,
  };
}

class Tokens {
  final String? accessToken;
  final String? refreshToken;

  Tokens({
    this.accessToken,
    this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
