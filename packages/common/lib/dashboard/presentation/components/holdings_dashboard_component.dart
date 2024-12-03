import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';
import 'package:mf_pod/presentation/core/mf_search_bar_component.dart';
import 'package:mf_pod/presentation/features/check_your_kyc/presentation/pages/all_holdings_screen.dart';


class HoldingsDashboardComponent extends StatelessWidget{
  final Function onStartInvestingTap;
  const HoldingsDashboardComponent({super.key, required this.onStartInvestingTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18),
      color: ColorUtilsV2.hex_F5F5FF,
      child:  Column(
          children: [
            ///add your component here
            const MFSearchBarComponent(),
            AllHoldingsScreenMobileView(onStartInvesting: onStartInvestingTap,),
          ],
        ),
    );
  }

}