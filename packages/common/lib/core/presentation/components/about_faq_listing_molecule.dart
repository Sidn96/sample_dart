import 'package:common/core/presentation/providers/faq_provider.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';

import 'landing_faq_list_item.dart';

class MemberFaqSection extends HookConsumerWidget {
  const MemberFaqSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final listOfHeaderContent =
        ref.read(listOfTruePalMemberHeaderContentProvider);
    final listOfExpandedContent =
        ref.read(listOfTruePalMemberExpandedContentProvider);
    final showAll = useState(false);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: ColorUtils.kSuggestionsBgColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return LandingFAQListItem(
                              index:
                                  "${(index < 9 ? '0' : '')}${(index + 1).toString()}.",
                              headerContent: listOfHeaderContent[index],
                              expandedContent: listOfExpandedContent[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                              height: 1, color: ColorUtils.taxdarkGray);
                        },
                        itemCount:
                            showAll.value ? listOfExpandedContent.length : 5,
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: ColorUtils.taxdarkGray,
                    ),
                    if (!showAll.value) ...[
                      SizedBox(
                        height: 80,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              showAll.value = !showAll.value;
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText(
                                  data: AppConstants.viewAll,
                                  textAlign: TextAlign.center,
                                  fontSize: Sizes.textSize14,
                                  fontWeight: FontWeight.w600,
                                  fontColor: ColorUtils.kBlackDark,
                                ),
                                // SizedBox(width: 8),
                                // AppImage(imgPath: AssetUtils.arrowRightIcon),
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
                              showAll.value = false;
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText(
                                  data: AppConstants.showless,
                                  textAlign: TextAlign.center,
                                  fontSize: Sizes.textSize14,
                                  fontWeight: FontWeight.w600,
                                  fontColor: ColorUtils.kBlackDark,
                                ),
                                // SizedBox(width: 8),
                                // AppImage(imgPath: AssetUtils.arrowUpIcon),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    // Container(height: 80)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
