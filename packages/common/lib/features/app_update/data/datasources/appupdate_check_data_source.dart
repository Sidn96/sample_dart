import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:dio/dio.dart';

part 'appupdate_check_data_source.g.dart';

@riverpod
AppUpdateCheckDataSource appUpdateCheckDataSource(
        AppUpdateCheckDataSourceRef ref) =>
    AppUpdateCheckDataSource(
      api: ref.watch(apiFacadeProvider),
    );

class AppUpdateCheckDataSource {
  final ApiFacade api;
  AppUpdateCheckDataSource({
    required this.api,
  });

  Future<Response<dynamic>?> getAppCheckData(String userType, String os) async {
    try {
      final response = await api.getData(
          path: "/tp/common/version?userType=$userType&os=$os");
      return response;
    } catch (e) {
      return null;
    }
  }
}
