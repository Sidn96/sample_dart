import 'dart:convert';

GetAccountDetailsResponseDto loginResponseBodyDtoFromJson(String str) =>
    GetAccountDetailsResponseDto.fromJson(json.decode(str));

String loginResponseBodyDtoToJson(GetAccountDetailsResponseDto data) =>
    json.encode(data.toJson());

class GetAccountDetailsResponseDto {
  final int? status;
  final bool? success;
  final String? message;
  final AccountDetailsData? data;
  final String? error;

  GetAccountDetailsResponseDto({
    this.status,
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory GetAccountDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      GetAccountDetailsResponseDto(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : AccountDetailsData.fromJson(json["data"]),
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

class AccountDetailsData {
  String? profilePic;
  String? fullName;
  String? pan;
  String? dob;
  String? contactNo;
  String? personalEmail;
  String? gender;
  String? maritalStatus;
  String? location;
  bool? isKycVerified;

  AccountDetailsData({
    this.profilePic,
    this.fullName,
    this.pan,
    this.dob,
    this.contactNo,
    this.personalEmail,
    this.gender,
    this.maritalStatus,
    this.location,
    this.isKycVerified,
  });

  factory AccountDetailsData.fromJson(Map<String, dynamic> json) =>
      AccountDetailsData(
        fullName: json["fullName"],
        profilePic: json["profilePic"],
        pan: json["pan"],
        dob: json["dob"],
        contactNo: json["contactNo"],
        personalEmail: json["personalEmail"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        location: json["location"],
        isKycVerified: json["isKycVerified"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "profilePic": profilePic,
        "pan": pan,
        "dob": dob,
        "contactNo": contactNo,
        "personalEmail": personalEmail,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "location": location,
        "isKycVerified": isKycVerified,
      };
}
