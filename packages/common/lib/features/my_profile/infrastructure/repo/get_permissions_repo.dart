import 'package:common/core/infrastructure/network/network_info.dart';
import 'package:common/features/my_profile/infrastructure/data_sources/get_permission_datasource.dart';
import 'package:common/features/my_profile/infrastructure/dtos/get_permissions_response_dto.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_permissions_repo.g.dart';

@Riverpod(keepAlive: true)
GetPermissionsRepo getPermissionsRepo(GetPermissionsRepoRef ref) {
  return GetPermissionsRepo(
      getPermissionDataSource: ref.watch(getPermissionDataSourceProvider),
      networkInfo: ref.watch(networkInfoProvider));
}

class GetPermissionsRepo {
  GetPermissionsRepo({required this.getPermissionDataSource, required this.networkInfo});

  final NetworkInfo networkInfo;
  final GetPermissionDataSource getPermissionDataSource;

  Future<GetPermissionResponseDto> getPermissionRepo() async {
    dynamic permissionDetails;
    try {
      permissionDetails = await getPermissionDataSource.getPermission();
      debugPrint('Repo--> $permissionDetails');
      return permissionDetails;
    } catch (e) {
      debugPrint("Repo Error: $e");
    }
    return permissionDetails;
  }


  Future<GetPermissionResponseDto> savePermissionRepo(dynamic requestBody) async {
    dynamic permissionDetails;
    try {
      permissionDetails = await getPermissionDataSource.savePermission(requestBody);

      return permissionDetails;
    } catch (e) {
      debugPrint("Repo Error: $e");
    }
    return permissionDetails;
  }
}
