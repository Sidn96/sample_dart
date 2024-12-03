import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/features/my_profile/infrastructure/dtos/get_permissions_response_dto.dart';
import 'package:common/features/my_profile/infrastructure/dtos/save_permissions_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_permission_datasource.g.dart';

@Riverpod(keepAlive: true)
GetPermissionDataSource getPermissionDataSource(
    GetPermissionDataSourceRef ref) {
  return GetPermissionDataSource(ref.read(apiFacadeProvider));
}

class GetPermissionDataSource {
  final ApiFacade _api;

  GetPermissionDataSource(this._api);

  final String _getPermissionPath = "/member/config";
  final String _savePermissionPath = "/member/config";

  Future<GetPermissionResponseDto> getPermission() async {
    try {
      final response = await _api.getData(path: _getPermissionPath, sendToken: true);
      if (response.data != null) {
        GetPermissionResponseDto newInfo = GetPermissionResponseDto.fromJson(response.data);
        return newInfo;
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'data not found.',
        );
      }
    } on DioException catch (e) {
      return GetPermissionResponseDto.fromJson(e.response?.data);
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }

  Future<GetPermissionResponseDto> savePermission(dynamic requestBody) async {
    try {
      final response = await _api.postDataRaw(
          path: _savePermissionPath, sendToken: true, data: requestBody);
      if (response.data != null) {
        debugPrint('dataSource--> ${response.statusCode}${response.data}');
        GetPermissionResponseDto newInfo = GetPermissionResponseDto.fromJson(response.data);
        return newInfo;
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'data not found.',
        );
      }
    } on DioException catch (e) {
      return GetPermissionResponseDto.fromJson(e.response?.data);
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }
}
