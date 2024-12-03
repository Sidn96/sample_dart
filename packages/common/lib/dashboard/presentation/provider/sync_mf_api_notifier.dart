import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:mf_pod/presentation/features/dashboard/data/mf_sync_dashboard_dto.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/analysis_quadrant_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/provider/mf_dashboard_provider.dart';

part 'sync_mf_api_notifier.g.dart';

@Riverpod(keepAlive: true)
class SyncMfHoldingsApiNotifier extends _$SyncMfHoldingsApiNotifier {

  List<MapEntry<String, List<AmcScheme>>> amcSchemesDetailsList = [];
  List<MapEntry<AnalysisQuadrantEnum, List<AmcScheme>>> performanceSchemesDetailsList = [];
  @override
  // FutureOr<MfSyncDtoModel?> build(){
  MfSyncDashboardApiDto? build(){
    getAllMfSyncHoldings();

    ref.listen(loginStatusProvider, (prev, next){
      var tPrev = prev?.value ?? false;
      var tNext = next.value ?? false;
       if (tPrev && !tNext){
        /// User Logged Out Now
        ref.invalidateSelf();
        amcSchemesDetailsList.clear();
        performanceSchemesDetailsList.clear();
      }
    });
    return null;
  }

  Future<MfSyncDashboardApiDto?> getAllMfSyncHoldings() async {
    var response = await ref.read(getDashboardProvider).getAllMfSyncHoldings();
    // state = AsyncValue.data(response);
    getSchemeBifurcation(response);
    state = response;
    return state;
    // return null;
  }

  void getSchemeBifurcation(MfSyncDashboardApiDto? mfSyncDtoModel){
    final Map<String,List<AmcScheme>> amcSchemesDetailsMap = {};
    final Map<AnalysisQuadrantEnum,List<AmcScheme>> performanceSchemesDetailsMap = {};
    mfSyncDtoModel?.schemes?.forEach((amcScheme){
      if(!amcSchemesDetailsMap.containsKey(amcScheme.amcName)){
        amcSchemesDetailsMap[amcScheme.amcName!] = [];
      }

      if(!performanceSchemesDetailsMap.containsKey(amcScheme.analysisQuadrantEnum)){
        performanceSchemesDetailsMap[amcScheme.analysisQuadrantEnum] = [];
      }
      amcSchemesDetailsMap[amcScheme.amcName]?.add(amcScheme);
      performanceSchemesDetailsMap[amcScheme.analysisQuadrantEnum]?.add(amcScheme);
    });

    // map to list conversion
    amcSchemesDetailsList = amcSchemesDetailsMap.entries.toList();
    performanceSchemesDetailsList = performanceSchemesDetailsMap.entries.toList();
    //sorting
    amcSchemesDetailsList.sort((a,b)=>a.key.compareTo(b.key));
    performanceSchemesDetailsList.sort((a,b) => a.key.sortIndex.compareTo(b.key.sortIndex));
  }

}