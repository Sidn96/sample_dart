import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

class LandingFAQListItem extends HookWidget {
  final String index;
  final String headerContent;
  final String expandedContent;

  const LandingFAQListItem(
      {Key? key,
      required this.index,
      required this.headerContent,
      required this.expandedContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var click = useState(false);
    return GFAccordion(
      titlePadding: const EdgeInsets.symmetric(vertical: 8.0),
      onToggleCollapsed: (v) {
        click.value = v;
      },
      titleChild: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: AppText(
              data: index,
              textAlign: TextAlign.start,
              fontSize: Sizes.textSize14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: AppText(
              data: headerContent,
              textAlign: TextAlign.start,
              fontSize: Sizes.textSize14,
              fontWeight: click.value ? FontWeight.w700 : FontWeight.w400,
              height: 1.3,
            ),
          )),
        ],
      ),
      contentChild: Padding(
          padding: const EdgeInsets.only(left: 17),
          child: AppText(
            data: expandedContent,
            textAlign: TextAlign.start,
            fontSize: Sizes.textSize14,
            fontWeight: FontWeight.w400,
            height: 1.3,
          )),
      collapsedIcon: const AppImage(
        imgPath: AssetUtils.newCircleDownArrowIcon,
        width: 30,
        height: 30,
        showColorFilter: false,
      ),
      expandedIcon: const AppImage(
        imgPath: AssetUtils.newCircleUpArrowIcon,
        width: 30,
        height: 30,
        showColorFilter: false,
      ),
      collapsedTitleBackgroundColor: Colors.transparent,
      expandedTitleBackgroundColor: Colors.transparent,
      contentBackgroundColor: Colors.transparent,
    );
  }
}
