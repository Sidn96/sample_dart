import 'package:common/core/infrastructure/api_result.dart';
import 'package:common/features/risk_profile/infrastructure/dtos/calculate_risk_profile_response_dto_custom.dart';
import 'package:mf_pod/infrastructure/dtos/get_portfolio_allocation_dto.dart';
import 'package:mf_pod/presentation/features/dashboard/data/holdings_dashboard_datasource.dart';
import 'package:mf_pod/presentation/features/dashboard/data/mf_sync_dashboard_dto.dart';

abstract class HoldingsDashboardUseCase {
  Future<CalculateRiskProfileResponseDtoCustom?> getRiskProfile();
  Future<GetPortfolioAllocationDto?> getPortfolioMix(int age, String riskProfile);
  Future<MfSyncDashboardApiDto?> getAllMfSyncHoldings();
}

class HoldingsDashboardUseCaseImpl implements HoldingsDashboardUseCase{
  final HoldingsDashboardDatasource holdingsDashboardDatasource;
  const HoldingsDashboardUseCaseImpl(this.holdingsDashboardDatasource);

  @override
  Future<CalculateRiskProfileResponseDtoCustom?> getRiskProfile() async {
    var response = await holdingsDashboardDatasource.getRiskProfile(
        mapper: CalculateRiskProfileResponseDtoCustom.fromJson);
      return response;
  }


  @override
  Future<GetPortfolioAllocationDto?> getPortfolioMix(int age, String riskProfile) async {

    var response = await holdingsDashboardDatasource.getPortfolioAllocation(
        mapper: GetPortfolioAllocationDto.fromJson, age: age, riskProfile: riskProfile);

    return response;
  }

  @override
  Future<MfSyncDashboardApiDto?> getAllMfSyncHoldings() async {
    var response = await holdingsDashboardDatasource.getMfSyncHoldings(
        mapper: MfSyncDashboardApiDto.fromJson);

    try{
      if (response is Success) {
        return response.data as MfSyncDashboardApiDto;
      } else {
        return const MfSyncDashboardApiDto(schemes: []);
      }
    }catch(e){
      print(e);
    }

    return const MfSyncDashboardApiDto(schemes: []);
  }


}