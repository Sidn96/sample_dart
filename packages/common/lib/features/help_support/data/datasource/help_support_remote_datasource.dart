import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/providers/connectivity_checker.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/help_support/data/dtos/help_support_dto.dart';

part 'help_support_remote_datasource.g.dart';

@riverpod
HelpSupportRemoteDataSource helpSupportRemoteDataSource(
    HelpSupportRemoteDataSourceRef ref) {
  return HelpSupportRemoteDataSource(
    api: ref.watch(apiFacadeProvider),
    connectivityStatus: ref.watch(connectivityCheckerNotifierProvider),
  );
}

class HelpSupportRemoteDataSource {
  final ApiFacade api;
  final ConnectivityStatus connectivityStatus;

  final String supportAPI = "/tp/common/support-number";

  HelpSupportRemoteDataSource(
      {required this.api, required this.connectivityStatus});

  Future<HelpSupportData?> getHelpSupport() async {
    try {
      final response = await api.getData(path: supportAPI);

      if (response.data != null) {
        final data = HelpSupportDto.fromJson(response.data);
        return data.data;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
