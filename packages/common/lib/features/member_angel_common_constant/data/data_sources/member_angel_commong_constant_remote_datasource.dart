import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/providers/connectivity_checker.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/member_angel_common_constant/data/dtos/member_angel_common_constant_dto.dart';

part 'member_angel_commong_constant_remote_datasource.g.dart';

@riverpod
MemberAngelCommongConstantRemoteDataSource
    memberAngelCommongConstantRemoteDataSource(
        MemberAngelCommongConstantRemoteDataSourceRef ref) {
  return MemberAngelCommongConstantRemoteDataSource(
    api: ref.watch(apiFacadeProvider),
    connectivityStatus: ref.watch(connectivityCheckerNotifierProvider),
  );
}

class MemberAngelCommongConstantRemoteDataSource {
  final ApiFacade api;
  final ConnectivityStatus connectivityStatus;

  final String commonConstant = "/tp/common/constant";

  MemberAngelCommongConstantRemoteDataSource(
      {required this.api, required this.connectivityStatus});

  Future<MemberAngelCommonConstantData?> getMemberAngelCommonConstant() async {
    try {
      final response = await api.getData(path: commonConstant);

      if (response.data != null) {
        final data = MemberAngelCommonConstantDto.fromJson(response.data);
        return data.data;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
