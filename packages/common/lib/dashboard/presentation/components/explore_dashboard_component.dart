import 'package:flutter/material.dart';
import 'package:mf_pod/presentation/core/mf_search_bar_component.dart';
import 'package:mf_pod/presentation/features/landing_page/component/mf_home/goal_based_basket_component.dart';

class ExploreDashboardComponent extends StatelessWidget{
  const ExploreDashboardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0,horizontal: 12),
        child: Column(children: [
          MFSearchBarComponent(),
          SizedBox(height: 20),
          GoalBasedInvestmentBaskets(showExploreMore: false)
        ],),
      ),
    );
  }

}