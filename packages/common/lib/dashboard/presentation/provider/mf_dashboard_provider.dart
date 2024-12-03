import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:mf_pod/presentation/features/dashboard/data/holdings_dashboard_datasource.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/holdings_dashboard_usecase.dart';

final getDashboardProvider = Provider<HoldingsDashboardUseCase>((ref) {
  var apiFacade = ref.read(apiFacadeProvider);
  return HoldingsDashboardUseCaseImpl(HoldingsDashboardDatasource(apiFacade));
});
