
import 'dart:ui';

import 'package:common/core/presentation/components_v2/app_button_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:common/features/config/visibility_config.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_pod/presentation/core/mf_bottomsheet.dart';
import 'package:mf_pod/presentation/features/dashboard/data/mf_sync_dashboard_dto.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/components/dashboard_for_under_process.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/components/overall_portfolio_widget.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/provider/sync_mf_api_notifier.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/quadrant_chart/bubble_util.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/quadrant_chart/quadrant_graph_widget.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widget/check_your_portfolio_widget.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widgets/user_mf_performance_base/user_mf_performance_base_widget.dart';
import 'package:mf_pod/presentation/features/import_external/screens/import_external_invest_bottomsheet_base.dart';
import 'package:mf_pod/presentation/features/landing_page/data/user_details_dto_model.dart';
import 'package:mf_pod/presentation/features/landing_page/domain/purchase_status_enum.dart';
import 'package:mf_pod/presentation/features/landing_page/provider/home_page_provider.dart';
import 'package:mf_pod/routing/mf_route_paths.dart';
import 'package:mf_pod/utils/enums/investment_flow_type_enum.dart';
import 'package:mf_pod/utils/mf_string_constants.dart';

class MyHoldingsDashboardComponent extends HookConsumerWidget{
  final Function onStartInvestingTap;
  final MfSyncDashboardApiDto? mfSyncDtoModel;
  const MyHoldingsDashboardComponent({super.key, required this.onStartInvestingTap,this.mfSyncDtoModel,});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    var dummySetState = useState(0); //added a dummy setState for quick solution
    useEffect((){
      WidgetsBinding.instance.addPostFrameCallback((t) async {
        var isUserLoggedIn = await checkUserLogin(ref);
        if (context.mounted) {
          if (!isUserLoggedIn) {
            MfBottomSheet.loginBottomSheet(context, () async {
              context.pop();
             var res = await ref
                  .read(syncMfHoldingsApiNotifierProvider.notifier)
                  .getAllMfSyncHoldings();
             if(res?.camsKycModificationLink == null){

               ///this will be called once and only
               ///when the response is empty from v2/sync-mf
               ///to trigger below future builder
               dummySetState.value = 1;
             }
            });
          }
        }
      });

      return null;
    },[]);
    var model = ref.watch(syncMfHoldingsApiNotifierProvider);

    var loaderNotifier = useValueNotifier(true);
    if (loaderNotifier.value && model != null) {
      loaderNotifier.value = false;
    }
    var isDataEmpty = model == null || model.schemes!.isEmpty;

    var currPurchaseStatus = useValueNotifier(PurchaseStatusEnum.pending);

    return NotificationListener<ScrollNotification>(
      onNotification: (scroll){
        BubbleUtil(0).hideTooltip();
        return true;
      },
      child: Container(
          color: ColorUtilsV2.hex_FFFFFF,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: useScrollController(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: FutureBuilder(
                    future: ref.read(homePageProvider).getUserDetails(),
                    builder: (BuildContext context,
                        AsyncSnapshot<UserDetailsDtoModel?> snapshot) {

                      WidgetsBinding.instance.addPostFrameCallback((t){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          loaderNotifier.value = true;
                        }
                        if(snapshot.connectionState == ConnectionState.done){
                          loaderNotifier.value = false;
                          currPurchaseStatus.value = snapshot.data?.purchaseStatus ?? PurchaseStatusEnum.pending;
                        }
                      });


                      if (snapshot.data == null) {
                        return const SizedBox.shrink();
                      }

                      return IgnorePointer(
                        ignoring: isDataEmpty && snapshot.data!.purchaseStatus != PurchaseStatusEnum.pending,
                        child: ClipRect(
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                                sigmaX: (isDataEmpty && snapshot.data!.purchaseStatus != PurchaseStatusEnum.pending) ? 1.5 : 0,
                                sigmaY: (isDataEmpty && snapshot.data!.purchaseStatus != PurchaseStatusEnum.pending) ? 1.5 : 0),
                            child: Column(
                              children: [
                                snapshot.data!.purchaseStatus ==
                                    PurchaseStatusEnum.pending ?
                                DashboardForUnderProcess(
                                      camsKycModificationLink: model?.camsKycModificationLink,
                                      kycStatusEnum: model?.kycStatus,
                                      purchaseStatusEnum: snapshot.data!.purchaseStatus,
                                    )
                                  : OverallPortfolioWidget(
                                      model: model?.getOverAllPortfolio(),
                                      onStartInvestingTap: () {
                                        onStartInvestingTap.call();
                                      },
                                      onRefreshTap: () async {
                                        openSyncJourneyBottomSheet(context, true);
                                      },
                                    ),
                              if(snapshot.data!.purchaseStatus != PurchaseStatusEnum.pending)
                                QuadrantGraphWidget(inputSchemes: isDataEmpty ? BubbleUtil(0).getDummySchemes(): model.schemes ?? [],),

                                if(snapshot.data!.purchaseStatus != PurchaseStatusEnum.pending)
                                UserMfPerformanceBaseWidget(),

                                if (VisibilityConfig.instance.enableFetchRiskAnalysis)
                                if (snapshot.data!.purchaseStatus != PurchaseStatusEnum.pending)
                                  CheckYourPortfolioWidget(onTap: () {
                                    context.pushNamed(MutualFundRoutePaths.riskAnalysis);
                                  }),
                            ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ValueListenableBuilder(valueListenable: currPurchaseStatus,
                builder: (BuildContext context, value, Widget? child) {
                  return bottomButton(context, isDataEmpty,value != PurchaseStatusEnum.pending);
                })),
              ValueListenableBuilder(
                valueListenable: loaderNotifier,
                builder: (BuildContext context, showLoader, Widget? child) {
                  return Visibility(
                      visible: showLoader,
                      child: const Center(child: CommonTrueFinLoader()));
                },
              )
          ],
          ),
        ),
      );
  }

  Widget bottomButton(BuildContext context, bool isDataEmpty, bool showView){
    return (isDataEmpty && showView) ? Material(
      elevation: 6.0,
      child: Container(
        color: ColorUtilsV2.genericWhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 24),
          child: PrimaryAppButtonV2(
              label: MfStringConstants.syncMyPortfolio,
              onTap: () {
                openSyncJourneyBottomSheet(context,true);
                // context.pushNamed(MutualFundRoutePaths.riskAnalysis);
              }),
        ),
      ),
    ) : const SizedBox.shrink();
  }

  Future<void> openSyncJourneyBottomSheet(BuildContext context,bool isRefreshFlow) async {
    await MfBottomSheet.showBottomSheet(
        paddingFromTop: 0,
        context: context,
        child: ImportExternalInvestBottomSheet(
          investmentFlowTypeEnum:
          InvestmentFlowTypeEnum.checkKycStatus,
          refreshFlow: isRefreshFlow,
        ));
  }

  Future<bool> checkUserLogin(WidgetRef ref) async {
    return await ref.read(loginStatusProvider.notifier).checkIfLoggedIn();
  }
}