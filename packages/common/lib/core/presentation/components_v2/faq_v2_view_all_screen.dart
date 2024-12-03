import 'package:common/core/presentation/components_v2/app_bar_v2.dart';
import 'package:common/core/presentation/components_v2/app_chip_widget.dart';
import 'package:common/core/presentation/components_v2/app_expansion_tile_V2.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/models/app_chip_model.dart';
import 'package:common/core/presentation/components_v2/providers_v2/faq_v2_provider.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:common/features/config/visibility_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

ValueNotifier<int> selectedIndex = ValueNotifier(-1);

class ExpansionItemWidget extends HookWidget {
  final int index;
  final AppExpansionTileData itemData;

  const ExpansionItemWidget(
      {required this.index, required this.itemData, super.key});

  @override
  Widget build(BuildContext context) {
    final controllerState = useState(ExpansionTileController());
    final isExpanded = useState(false);
    useEffect(() {
      selectedIndex.addListener(() {
        if (selectedIndex.value != index) {
          if (controllerState.value.isExpanded) {
            controllerState.value.collapse();
            isExpanded.value = false;
          }
        }
      });

      return null;
    }, []);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 19),
      decoration: BoxDecoration(
          border: Border.all(color: ColorUtilsV2.specialNeutral300, width: 1),
          borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 15.0),
        controller: controllerState.value,
        shape: const Border(),
        onExpansionChanged: (value) {
          if (value) {
            selectedIndex.value = index;
            isExpanded.value = true;
          } else {
            isExpanded.value = false;
          }
        },
        // tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextV2(
              data: '${(index + 1).toString().padLeft(2, '0')}. ',
              fontSize: 14,
              textAlign: TextAlign.left,
              fontColor: ColorUtilsV2.hex_35354D,
            ),
            Expanded(
              child: AppTextV2(
                data: itemData.title,
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
                child: isExpanded.value
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: AppImage(
                            imgPath: AssetUtils.iconRemove,
                            iconColor: ColorUtilsV2.hex_35354D),
                      )
                    : const AppImage(
                        imgPath: AssetUtils.iconAdd,
                        iconColor: ColorUtilsV2.hex_35354D));
          },
        ),
        expandedAlignment: Alignment.centerLeft,
        childrenPadding:
            const EdgeInsets.only(left: 17, top: 8, right: 4, bottom: 20),
        // children: data.children,
        children: [HtmlWidget(itemData.children)],
      ),
    );
    /* return ExpansionTile(
        onExpansionChanged: (value) {
          if (value) {
            selectedIndex.value = index;
          }
        },
        children: [const Text("child")],
        title: const Text("Demo"),
        controller: controllerState.value);*/
  }
}

class FaqV2ViewAllScreen extends HookConsumerWidget {
  final String category;

  const FaqV2ViewAllScreen({super.key, this.category = "truefin"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(faqViewAllDataProviderProvider.notifier);
    useEffect(() {
      notifier.setCategory(category);
      MoEngageService().trackEvent(
          eventName: MoEngageEventsConsts.eventsNames.truefinfaqscreenviewed,
          product: ProductEvent.truefin,
          properties: {"tab_selected": notifier.selectedCategory});
      return () {
        selectedIndex.value = -1;
      };
    }, []);
    //useEffect and set value as -1 for selectedIndex
    return Scaffold(
        backgroundColor: ColorUtilsV2.hex_F5F5FF,
        appBar: AppBarV2(title: getPageTitleFromCategory(category)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: _FaqChipRowWidget(),
            ),
            Expanded(
              child: PagedListView.separated(
                //physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox();
                },
                pagingController: notifier.faqPagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<AppExpansionTileData>(
                  firstPageProgressIndicatorBuilder: (context) {
                    return const CommonTrueFinLoader();
                  },
                  noItemsFoundIndicatorBuilder: (context) {
                    return const Center(
                        child:
                            AppTextV2(data: "No Data Found", fontSize: 12.0));
                  },
                  animateTransitions: true,
                  itemBuilder: (context, itemData, index) {
                    return ExpansionItemWidget(
                        index: index, itemData: itemData);
                  },
                ),
              ),
            ),
          ],
        ));
  }

  String getPageTitleFromCategory(String category) {
    switch (category) {
      case "truefin":
        return "Truefin";
      case "nps":
        return "FAQ";
      case "epf":
        return "EPF";
      case "health-insurance":
        return "Health";
      case "mutual-funds":
        return "Mutual Funds";
      default:
        return "";
    }
  }
}

class _FaqChipRowWidget extends HookConsumerWidget {
  const _FaqChipRowWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(faqViewAllDataProviderProvider.notifier);
    ref.watch(faqViewAllDataProviderProvider);
    final scrollController = useScrollController();

    if(notifier.selectedCategory == 'mutual-funds'){
      WidgetsBinding.instance.addPostFrameCallback((t){
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      });
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          // crossAxisAlignment: WrapCrossAlignment.start,
          // alignment: WrapAlignment.start,
          // spacing: 10,
          children: [
            AppChipWidget(
              width: 84,
              contentPadding: EdgeInsets.zero,
              model: const AppChipModel(label: 'TrueFin', value: 'truefin'),
              isSelected: notifier.selectedCategory == 'truefin',
              activeChipBgColor: ColorUtilsV2.hex_86EFAC,
              disabledColor: ColorUtilsV2.hex_C3C4FE,
              activeTextColor: ColorUtilsV2.hex_35354D,
              inactiveTextColor: ColorUtilsV2.hex_5D5D70,
              onSelected: () {
                notifier.onCategoryChange("truefin");
              },
            ),
            const SizedBox(width: 10.0),
            AppChipWidget(
              width: 84,
              contentPadding: EdgeInsets.zero,
              model: const AppChipModel(label: 'NPS', value: 'nps'),
              isSelected: notifier.selectedCategory == 'nps',
              activeChipBgColor: ColorUtilsV2.hex_86EFAC,
              disabledColor: ColorUtilsV2.hex_C3C4FE,
              activeTextColor: ColorUtilsV2.hex_35354D,
              inactiveTextColor: ColorUtilsV2.hex_5D5D70,
              onSelected: () {
                notifier.onCategoryChange("nps");
              },
            ),
            const SizedBox(width: 10.0),
            AppChipWidget(
              width: 100,
              contentPadding: EdgeInsets.zero,
              model: const AppChipModel(label: 'EPF', value: 'epf'),
              isSelected: notifier.selectedCategory == 'epf',
              activeChipBgColor: ColorUtilsV2.hex_86EFAC,
              disabledColor: ColorUtilsV2.hex_C3C4FE,
              activeTextColor: ColorUtilsV2.hex_35354D,
              inactiveTextColor: ColorUtilsV2.hex_5D5D70,
              onSelected: () {
                notifier.onCategoryChange("epf");
                // print("OnSelected Mutual Funds");
                //   selectedChip.value = "epf";
                // ref.read(faqV2DataProviderProvider.notifier).filterFaqBy(
                //     selectedChip.value);
              },
            ),
            if (VisibilityConfig.instance.showInsurance)
              const SizedBox(width: 10.0),
            if (VisibilityConfig.instance.showInsurance)
              AppChipWidget(
                width: 100,
                contentPadding: EdgeInsets.zero,
                model: const AppChipModel(label: 'Health', value: 'insurance'),
                isSelected: notifier.selectedCategory == 'insurance',
                activeChipBgColor: ColorUtilsV2.hex_86EFAC,
                disabledColor: ColorUtilsV2.hex_C3C4FE,
                activeTextColor: ColorUtilsV2.hex_35354D,
                inactiveTextColor: ColorUtilsV2.hex_5D5D70,
                onSelected: () {
                  notifier.onCategoryChange("insurance");
                  // print("OnSelected Mutual Funds");
                  //   selectedChip.value = "epf";
                  // ref.read(faqV2DataProviderProvider.notifier).filterFaqBy(
                  //     selectedChip.value);
                },
              ),
            if(VisibilityConfig.instance.showMutualFunds)
              const SizedBox(width: 10.0),
            if(VisibilityConfig.instance.showMutualFunds)
              AppChipWidget(
                width: 100,
                contentPadding: EdgeInsets.zero,
                model: const AppChipModel(label: 'Mutual Funds', value: 'mutual-funds'),
                isSelected: notifier.selectedCategory == 'mutual-funds',
                activeChipBgColor: ColorUtilsV2.hex_86EFAC,
                disabledColor: ColorUtilsV2.hex_C3C4FE,
                activeTextColor: ColorUtilsV2.hex_35354D,
                inactiveTextColor: ColorUtilsV2.hex_5D5D70,
                onSelected: () {
                  notifier.onCategoryChange("mutual-funds");
                  // print("OnSelected Mutual Funds");
                  //   selectedChip.value = "epf";
                  // ref.read(faqV2DataProviderProvider.notifier).filterFaqBy(
                  //     selectedChip.value);
                },
              )
          ],
        ),
      ),
    );
  }
}
