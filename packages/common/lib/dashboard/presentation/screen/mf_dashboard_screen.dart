import 'package:common/core/presentation/components_v2/app_bar_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/platform_builder.dart';
import 'package:flutter/material.dart';
import 'package:mf_pod/presentation/features/check_your_kyc/data/kyc_all_holdings_dto_model.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/components/explore_dashboard_component.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/components/holdings_dashboard_component.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/components/orders_dashboard_component.dart';
import 'package:mf_pod/utils/enums/investment_type_enum.dart';
import 'package:mf_pod/utils/mf_string_constants.dart';


//TODO check and remove this Screen, not in use for now
class MfDashboardScreen extends StatelessWidget {
  final KycAllHoldingsDtoModel? kycAllHoldingsDtoModel;

  const MfDashboardScreen({super.key, this.kycAllHoldingsDtoModel});

  @override
  Widget build(BuildContext context) {
    return PlatformBuilder(
        mWebView: MfDashboardMobileView(
          dtoModel: kycAllHoldingsDtoModel,
        ),
        mobileAppView: MfDashboardMobileView(
          dtoModel: kycAllHoldingsDtoModel,
        ),
        desktopView: MfDashboardMobileView(
          dtoModel: kycAllHoldingsDtoModel,
        ));
  }
}

class MfDashboardMobileView extends HookConsumerWidget {
  final KycAllHoldingsDtoModel? dtoModel;

  const MfDashboardMobileView({
    super.key,
    this.dtoModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 3, initialIndex: 0);
    useListenable(tabController);
    var tabPos = useState(tabController.index);
    return Scaffold(
      appBar: const AppBarV2(
        toolbarHeight: kToolbarHeight,
        backgroundColor: ColorUtilsV2.hex_F5F5FF,
        title: MfStringConstants.mutualFund,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(

            splashFactory: NoSplash.splashFactory,
            controller: tabController,
            isScrollable: true,
            onTap: (pos) {
              tabPos.value = pos;
            },
            tabAlignment: TabAlignment.start,
            dividerColor: ColorUtilsV2.specialNeutral200,
            indicatorColor: ColorUtilsV2.hex_4E52F8,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyles.manropeStyle(Sizes.textSize14,
                color: ColorUtilsV2.hex_4E52F8, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyles.manropeStyle(
              Sizes.textSize14,
              color: ColorUtilsV2.specialNeutral600,
            ),
            tabs: const [
              Tab(
                text: MfStringConstants.explore,
              ),
              Tab(
                text: MfStringConstants.dashboard,
              ),
              Tab(
                text: MfStringConstants.orders,
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: tabPos.value == 0
                  ? const ExploreDashboardComponent()
                  :(tabPos.value == 1)
                  ?  HoldingsDashboardComponent(onStartInvestingTap: (){},)
                  : (tabPos.value == 2)
                  ? OrdersDashboardComponent(OrderDashboardPageArgs(investmentType: InvestmentTypeEnum.lumpsum),(){})
                  : const SizedBox.shrink(),
            ),
          )
        ],
      ),
    );
  }
}
