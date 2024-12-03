import 'package:common/core/presentation/components_v2/app_bar_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/platform_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/components/holdings_dashboard_component.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/components/orders_dashboard_component.dart';
import 'package:mf_pod/presentation/features/landing_page/screen/diy_home/diy_home_screen.dart';
import 'package:mf_pod/presentation/features/landing_page/screen/mf_home/mf_landing_screen.dart';
import 'package:mf_pod/utils/enums/investment_type_enum.dart';
import 'package:mf_pod/utils/mf_moengage_utils.dart';
import 'package:mf_pod/utils/mf_string_constants.dart';
import 'package:mf_pod/utils/mf_moengage_constants.dart';

//TODO remove
class LandingScreenArgs {
  final int index;
  final InvestmentTypeEnum investType;
  int? tempIndex;

  LandingScreenArgs({this.index = 0,required this.investType}){
    tempIndex = index;
  }

  @override
  String toString() {
    return "Index $index InvestType $investType TempIndex $index";
  }
}


class MfNewLandingScreen extends StatelessWidget {
  final LandingScreenArgs args;
  const MfNewLandingScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return PlatformBuilder(
        mWebView: MfNewLandingMobileView( args: args,
        ),
        mobileAppView: MfNewLandingMobileView(args: args,
        ),
        desktopView: MfNewLandingMobileView(args: args,
        ));
  }
}

class MfNewLandingMobileView extends HookConsumerWidget {
  final LandingScreenArgs args;
  const MfNewLandingMobileView({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tabController = useTabController(initialLength: 4, initialIndex: args.index);
    // useListenable(tabController);
    var tabPos = useState(args.index);
    // if(args.tempIndex != null){
    //   tabController.index = args.tempIndex!;
    //   args.tempIndex = null;
    // }
    useEffect((){
      tabController.addListener((){
        if(tabPos.value != tabController.index){
          tabPos.value = tabController.index;
        }
      });
      return null;
    },[]);
    return Scaffold(
      appBar: AppBarV2(
          toolbarHeight: kToolbarHeight,
          backgroundColor: ColorUtilsV2.hex_F5F5FF,
          title: MfStringConstants.mutualFund,
          centerTitle: true,
          isUseDefaultPop: false,
          onLeadingTap: () {
            if (!context.canPop()) {
              context.go("/");
            } else {
              context.pop();
            }
          },
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
              _moengageTabSelectedTrack(pos);
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
                icon: Icon(Icons.home),
              ),
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
            child: switch(tabPos.value) {
              0 => MFLandingScreen(goToExplore: () {
                tabController.animateTo(1, duration: kTabScrollDuration, curve: Curves.ease);
                tabController.index = 1;
              }),
              1 => const DIYHomeScreen(),
              // 2 => const RiskAnalysisBasePage(),
            ///uncomment following widget for old dashboard screen widget
              2 => SingleChildScrollView(child: HoldingsDashboardComponent(
                  onStartInvestingTap: () {
                    tabController.animateTo(1,
                        duration: kTabScrollDuration, curve: Curves.ease);
                    tabController.index = 1;
                  },
                )),
              // 2 => MyHoldingsDashboardComponent(onStartInvestingTap: () {
              //     tabController.animateTo(1,
              //         duration: kTabScrollDuration, curve: Curves.ease);
              //     tabController.index = 1;
              //   }),
              3 => OrdersDashboardComponent(
                      OrderDashboardPageArgs(investmentType: args.investType),
                      () {
                        tabController.animateTo(1, duration: kTabScrollDuration, curve: Curves.ease);
                        tabController.index = 1;
                      }),
              _ => const SizedBox.shrink(),
            },
          )
        ],
      ),
    );
  }

  void _moengageTabSelectedTrack(int value) {
    final constants = MfMoEngageConstants();
    var tabName = switch (value) {
      1 => constants.propertiesValue.explore,
      2 => constants.propertiesValue.dashboard,
      3 => constants.propertiesValue.orders,
      _ => ""
    };
    if (tabName.isNotNullNorEmpty()) {
      MfMoEngageUtils().postEvent(constants.eventNames.homeTabSelected,
          properties: {constants.propertiesKey.section: tabName});
    }
  }
}
