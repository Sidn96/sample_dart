import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AppExpansionWidgetV2 extends HookWidget {
  final AppExpansionTileData data;
  final ValueChanged<bool> onExpansionChanged;
  final ExpansionTileController controller;

  const AppExpansionWidgetV2({
    super.key,
    required this.data,
    required this.onExpansionChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    var isExpanded = useValueNotifier(false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 19),
      decoration: BoxDecoration(
          border: Border.all(color: ColorUtilsV2.specialNeutral300, width: 1),
          borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 15.0),
        controller: controller,
        shape: const Border(),
        onExpansionChanged: (val) {
          if (isExpanded.value != val) {
            isExpanded.value = val;
          }
          onExpansionChanged(val);
        },
        // tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextV2(
              data: '${data.index.toString().padLeft(2, '0')}. ',
              fontSize: 14,
              textAlign: TextAlign.left,
              fontColor: ColorUtilsV2.hex_35354D,
            ),
            Expanded(
              child: AppTextV2(
                data: data.title,
                fontSize: 14,
                textAlign: TextAlign.left,
                fontColor: ColorUtilsV2.hex_35354D,
              ),
            ),
          ],
        ),
        trailing: ValueListenableBuilder(
          valueListenable: isExpanded,
          builder: (ctx, tIsExpanded, child) {
            return SizedBox(
                height: 20,
                width: 20,
                child: tIsExpanded
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: AppImage(
                          imgPath: AssetUtils.iconRemove,
                          iconColor: ColorUtilsV2.hex_35354D
                        ),
                      )
                    : const AppImage(imgPath: AssetUtils.iconAdd,iconColor: ColorUtilsV2.hex_35354D));
          },
        ),
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: const EdgeInsets.only(left: 17,top : 8, right: 4, bottom: 20),
        // children: data.children,
        children: [HtmlWidget(data.children)],
      ),
    );
  }
}

class AppExpansionTileData {
  final int index;
  final String category;
  final String title;
  // final List<Widget> children;
  final String children;

  AppExpansionTileData({
    required this.index,
    required this.title,
    required this.children,
    required this.category,
  });

}
