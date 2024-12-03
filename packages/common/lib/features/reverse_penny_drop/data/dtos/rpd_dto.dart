// To parse this JSON data, do
//
//     final rpdDto = rpdDtoFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'rpd_dto.freezed.dart';
part 'rpd_dto.g.dart';

RpdDto rpdDtoFromJson(String str) => RpdDto.fromJson(json.decode(str));

String rpdDtoToJson(RpdDto data) => json.encode(data.toJson());

@freezed
class RpdDto with _$RpdDto {
    const factory RpdDto({
        int? status,
        bool? success,
        String? message,
        Data? data,
        String? error,
        String? requestId,
    }) = _RpdDto;

    factory RpdDto.fromJson(Map<String, dynamic> json) => _$RpdDtoFromJson(json);
}

@freezed
class Data with _$Data {
    const factory Data({
        String? requestId,
        Result? result,
        int? statusCode,
        ClientData? clientData,
    }) = _Data;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class ClientData with _$ClientData {
    const factory ClientData({
        String? caseId,
    }) = _ClientData;

    factory ClientData.fromJson(Map<String, dynamic> json) => _$ClientDataFromJson(json);
}

@freezed
class Result with _$Result {
    const factory Result({
        String? refId,
        String? status,
        String? amount,
        String? message,
        DateTime? expiryDate,
        String? statusRefId,
        List<PaymentLink>? paymentLinks,
        String? qrCode,
    }) = _Result;

    factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@freezed
class PaymentLink with _$PaymentLink {
    const factory PaymentLink({
        String? mode,
        String? paymentUrl,
    }) = _PaymentLink;

    factory PaymentLink.fromJson(Map<String, dynamic> json) => _$PaymentLinkFromJson(json);
}
