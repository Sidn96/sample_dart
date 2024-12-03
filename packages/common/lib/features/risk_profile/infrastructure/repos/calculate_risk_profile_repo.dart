import 'package:common/core/infrastructure/network/network_info.dart';
import 'package:common/features/risk_profile/infrastructure/data_source/calculate_risk_profile_remote_data_source.dart';
import 'package:common/features/risk_profile/infrastructure/dtos/calculate_risk_profile_request_dto.dart';
import 'package:common/features/risk_profile/infrastructure/dtos/calculate_risk_profile_response_dto_custom.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calculate_risk_profile_repo.g.dart';

@Riverpod(keepAlive: true)
RiskProfileRepo riskProfileRepo(RiskProfileRepoRef ref) {
  return RiskProfileRepo(
    networkInfo: ref.watch(networkInfoProvider),
    remoteDataSource: ref.watch(riskProfileCalculateDataSourceProvider),
  );
}

class RiskProfileRepo {
  RiskProfileRepo({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  final NetworkInfo networkInfo;
  final RiskProfileCalculateDataSource remoteDataSource;

  Future<CalculateRiskProfileResponseDtoCustom> postRiskProfileFlowApi(
      CalculateRiskProfileRequestDto calculateRiskProfileRequestDto,
      String token) async {
    dynamic riskProfileFlowData;

    try {
      riskProfileFlowData = await remoteDataSource
          .postRiskProfileCalculatedData(calculateRiskProfileRequestDto, token);
      return riskProfileFlowData;
    } catch (e) {
      e.toString();
    }
    return riskProfileFlowData;
  }

  Future<CalculateRiskProfileResponseDtoCustom> getRiskProfileFlowApi() async {
    dynamic riskProfileFlowData;

    try {
      riskProfileFlowData =
          await remoteDataSource.getRiskProfileCalculatedData();
      return riskProfileFlowData;
    } catch (e) {
      e.toString();
    }
    return riskProfileFlowData;
  }
}
