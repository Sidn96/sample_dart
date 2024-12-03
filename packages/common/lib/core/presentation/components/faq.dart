import 'package:common/core/presentation/components/landing_faq_list_item.dart';
import 'package:common/core/presentation/providers/faq_provider.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/image_asset_widget.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:flutter/material.dart';

class FAQs extends HookConsumerWidget {
  const FAQs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabbarlist = listoftabs(false);
    final controller = useTabController(initialLength: tabbarlist.length);
    final index = useState(0);
    controller.addListener(() {
      index.value = controller.index;
    });
    return DefaultTabController(
      length: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(245, 245, 255, 1),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                controller: controller,
                tabs: tabbarlist
                    .map((e) => Tab(
                          child: AppText(
                            data: e,
                            fontSize: Sizes.textSize12,
                            fontWeight: FontWeight.w600,
                            fontColor: ColorUtils.blueishPurpleColor,
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 700,
                child: TabBarView(controller: controller, children: const [
                  AboutUs(),
                  AboutUs(),
                  AboutUs(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutUs extends HookConsumerWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: ImageAssetWidget(
                path: AssetUtils.dotdot,
                height: 83,
              )),
        ),
        SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return LandingFAQListItem(
                      index:
                          "${(index < 9 ? '0' : '')}${(index + 1).toString()}.",
                      headerContent:
                          ref.watch(listOfHeaderContentProvider)[index],
                      expandedContent:
                          ref.watch(listOfExpandedContentProvider)[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                      height: 1, color: ColorUtils.taxdarkGray);
                },
                itemCount: ref.watch(showAllProvider)
                    ? ref.watch(listOfExpandedContentProvider).length
                    : 5,
              ),
            ),
            const Divider(
              height: 1,
              color: ColorUtils.taxdarkGray,
            ),
            if (!ref.watch(showAllProvider)) ...[
              SizedBox(
                height: 80,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(showAllProvider.notifier).state =
                          !ref.read(showAllProvider);
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          data: AppConstants.viewAll,
                          textAlign: TextAlign.center,
                          fontSize: Sizes.textSize14,
                          fontWeight: FontWeight.w500,
                          fontColor: Color.fromRGBO(30, 34, 251, 1),
                        ),
                        SizedBox(width: 8),
                        AppImage(imgPath: AssetUtils.arrowRightIcon),
                      ],
                    ),
                  ),
                ),
              ),
            ] else ...[
              const Divider(
                height: 1,
                color: ColorUtils.taxdarkGray,
              ),
              SizedBox(
                height: 80,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(showAllProvider.notifier).state = false;
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          data: AppConstants.showless,
                          textAlign: TextAlign.center,
                          fontSize: Sizes.textSize14,
                          fontWeight: FontWeight.w500,
                          fontColor: Color.fromRGBO(30, 34, 251, 1),
                        ),
                        SizedBox(width: 8),
                        AppImage(imgPath: AssetUtils.arrowUpIcon),
                      ],
                    ),
                  ),
                ),
              ),
            ]
          ]),
        )
      ],
    );
  }
}
