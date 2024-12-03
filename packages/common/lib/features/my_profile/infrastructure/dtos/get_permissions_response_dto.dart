import 'dart:convert';

GetPermissionResponseDto permissionResponseBodyDtoFromJson(String str) =>
    GetPermissionResponseDto.fromJson(json.decode(str));

String loginResponseBodyDtoToJson(GetPermissionResponseDto data) =>
    json.encode(data.toJson());

class GetPermissionResponseDto {
  int? status;
  bool? success;
  String? message;
  ManagePermissionData? data;
  String? error;

  GetPermissionResponseDto(
      {this.status, this.success, this.message, this.data, this.error});

  GetPermissionResponseDto.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ManagePermissionData.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class ManagePermissionData {
  Config? config;

  ManagePermissionData({this.config});

  ManagePermissionData.fromJson(Map<String, dynamic> json) {
    config =
    json['config'] != null ? Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (config != null) {
      data['config'] = config!.toJson();
    }
    return data;
  }
}

class Config {
  bool? monthlyNSDLStatementAutoGeneration;
  bool? monthlyECASSync;
  bool? emailSync;

  Config(
      {this.monthlyNSDLStatementAutoGeneration,
        this.monthlyECASSync,
        this.emailSync});

  Config.fromJson(Map<String, dynamic> json) {
    monthlyNSDLStatementAutoGeneration =
    json['monthlyNSDLStatementAutoGeneration'];
    monthlyECASSync = json['monthlyECASSync'];
    emailSync = json['emailSync'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['monthlyNSDLStatementAutoGeneration'] =
        monthlyNSDLStatementAutoGeneration;
    data['monthlyECASSync'] = monthlyECASSync;
    data['emailSync'] = emailSync;
    return data;
  }
}
