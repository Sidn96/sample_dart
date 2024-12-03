import 'package:common/core/infrastructure/network/network_info.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:dio/dio.dart';

import '../datasources/appupdate_check_data_source.dart';

part 'appupdate_check_repo.g.dart';

@riverpod
AppUpdateCheckRepo appUpdateCheckRepo(AppUpdateCheckRepoRef ref) {
  return AppUpdateCheckRepo(
      networkInfo: ref.watch(networkInfoProvider),
      remoteDataSource: ref.watch(appUpdateCheckDataSourceProvider));
}

class AppUpdateCheckRepo {
  final NetworkInfo networkInfo;
  final AppUpdateCheckDataSource remoteDataSource;
  AppUpdateCheckRepo(
      {required this.networkInfo, required this.remoteDataSource});

  Future<Response<dynamic>?> getAppCheckData(String userType, String os) async {
    final response = await remoteDataSource.getAppCheckData(userType, os);
    return response;
  }
}
