import 'dart:math';

import 'package:common/core/presentation/components_v2/app_expansion_tile_V2.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/providers_v2/faq_v2_provider.dart';
import 'package:common/core/presentation/components_v2/view_all_widget.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FAQComponent extends HookConsumerWidget {
  final int numberOfFaqs;
  final bool showTitle; // Frequently Asked Questions Title
  final bool showViewAll;
  final double bottomPadding;
  final bool showPageLoader;
  final String? podName;

  const FAQComponent(
      {super.key,
      this.numberOfFaqs = 3,
      this.showTitle = true,
      this.showViewAll = true,
      this.bottomPadding = 0.0,
      this.showPageLoader = false,
      this.podName = "truefin"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future(() async {
          await ref
              .read(faqV2DataProviderProvider.notifier)
              .fetchFaq(category: podName?.toLowerCase() ?? "");
          // if (podName.isNotNullNorEmpty()) {
          //   ref.read(faqV2DataProviderProvider.notifier).filterFaqBy(podName!);
          // }
        });
      });
      return null;
    }, []);

    return ref.watch(faqV2DataProviderProvider).when(
        data: (data) {
          //If openNewPageOnViewAll is false then show all Faqs
          if (data.isEmpty) {
            return const SizedBox();
            /* return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 36),
                child: AppTextV2(
                  data: 'No Record Found',
                  fontSize: 16,
                ),
              ),
            );*/
          }

          return _FAQComponentWidget(
            dataList: data,
            numberOfFaqs: numberOfFaqs,
            viewAllCallback: () async =>
                await context.pushNamed('faq-view-all',extra: podName),
            showTitle: showTitle,
            showViewAll: showViewAll,
            bottomPadding: bottomPadding,
          );
        },
        error: (_, __) =>
            const SizedBox() /*const Center(
          child: AppTextV2(
            data: 'Something went wrong',
            fontSize: 14,
          ),
        )*/
        ,
        loading: () => showPageLoader == true
            ? Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2 - 140.0),
                child: const CommonTrueFinLoader(),
              )
            : const SizedBox.shrink());
  }
}

class _FAQComponentWidget extends HookWidget {
  final List<AppExpansionTileData> dataList;
  final bool showViewAll;
  final VoidCallback? viewAllCallback;
  final int numberOfFaqs;
  final bool showTitle;
  final double bottomPadding;

  const _FAQComponentWidget(
      {super.key,
      required this.dataList,
      required this.numberOfFaqs,
      required this.showTitle,
      this.showViewAll = true,
      this.viewAllCallback,
      this.bottomPadding = 0.0});

  @override
  Widget build(BuildContext context) {
    var length = useState(
        showViewAll ? min(dataList.length, numberOfFaqs) : dataList.length);
    var controllers = useValueNotifier<List<ExpansionTileController>>([]);
    if (controllers.value.isEmpty) {
      controllers.value
          .addAll(List.generate(dataList.length, (index) => ExpansionTileController()));
    }

    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      color: ColorUtilsV2.hex_F5F5FF,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTitle) ...[
            const SizedBox(height: 34),
            const AppTextV2(
                data: 'Frequently Asked Questions ',
                fontSize: 26,
                fontWeight: FontWeight.w400),
            const SizedBox(height: 20),
          ],
          for (int i = 0; i < length.value; i++)
            AppExpansionWidgetV2(
                data: dataList[i],
                controller: controllers.value[i],
                onExpansionChanged: (val) {
                  if (val) {
                    collapseOtherTilesController(controllers.value,
                        index: i, length: length.value);
                  }
                }),
          const SizedBox(height: 10),
          if (/*length.value != dataList.length && */showViewAll)
            ViewAllWidget(
                onPressed:
                    viewAllCallback ?? () => length.value = dataList.length),
          const SizedBox(height: 36.0)
        ],
      ),
    );
  }

  void collapseOtherTilesController(List<ExpansionTileController> controllers,
      {int index = 0, int length = 0}) {
    for (int i = 0; i < length; i++) {
      if (index == i) continue;

      if (controllers[i].isExpanded) {
        controllers[i].collapse();
      }
    }
  }
}
