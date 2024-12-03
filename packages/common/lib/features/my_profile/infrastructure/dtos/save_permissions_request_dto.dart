import 'dart:convert';

SavePermissionRequestDto permissionResponseBodyDtoFromJson(String str) =>
    SavePermissionRequestDto.fromJson(json.decode(str));

String loginResponseBodyDtoToJson(SavePermissionRequestDto data) =>
    json.encode(data.toJson());

class SavePermissionRequestDto {
  bool? monthlyNSDLStatementAutoGeneration;
  bool? monthlyECASSync;
  bool? emailSync;

  SavePermissionRequestDto(
      {this.monthlyNSDLStatementAutoGeneration,this.monthlyECASSync,this.emailSync});

  SavePermissionRequestDto.fromJson(Map<String, dynamic> json) {
    monthlyNSDLStatementAutoGeneration =
    json['monthlyNSDLStatementAutoGeneration'];
    monthlyECASSync = json['monthlyECASSync'];
    emailSync = json['emailSync'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthlyNSDLStatementAutoGeneration'] =
        this.monthlyNSDLStatementAutoGeneration;
    data['monthlyECASSync'] = this.monthlyECASSync;
    data['emailSync'] = this.emailSync;
    return data;
  }
}
