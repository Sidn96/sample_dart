import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/navigation_drawer/domain/drawer_item_model.dart';
import 'package:common/features/navigation_drawer/presentation/providers/drawer_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(60.0)),
                color: ColorUtilsV2.hex_7375FD,
              ),
              height: 200.0,
              width: double.infinity,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < drawerMenuItemsList.length; i++)
                      Builder(
                        builder: (context) {
                          DrawerMenuItemModel item = drawerMenuItemsList[i];
                          return Container(
                            padding: EdgeInsets.only(
                                left: 40.0,
                                right: 40.0,
                                top: i == 0 ? 30.0 : 20.0,
                                bottom: 20.0),
                            child: Row(
                              children: [
                                if(item.imagePath != null)...[
                                SvgPicture.asset(item.imagePath!, width: 28.0),
                                const SizedBox(width: 30.0),
                                ],
                                AppTextV2(
                                    data: item.name,
                                    fontSize: 14.0,
                                    height: 19.12 / 14.0,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                          );
                        },
                      ),
                    const Spacer(),
                    const AppTextV2(
                        data: AppConstants.logoutLabel, fontSize: 14.0),
                    const SizedBox(height: 33.0)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
