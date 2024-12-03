import 'package:common/core/consts/constant_app_strings.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/widgets/dashline_horizontal_painter.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

import '../providers/address_map_provider.dart';
import 'address_suggested_list_widget.dart';
import 'use_my_current_location_widget.dart';

class AddressSuggestionWidget extends HookConsumerWidget {
  const AddressSuggestionWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isloading = useState<bool>(false);
    // ref.watch(finalSearchedGoogleMapAddressProvider);
    final suggestedAddress = ref.watch(mapAddressSuggestionNotifierProvider);
    return Container(
      color: Colors.white12,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
        decoration: BoxDecoration(
          color: ColorUtils.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 1.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.height,
            UseMyCurrentLocationWidget(isloading: isloading),
            // UseMyCurrentLocationWidget(isloading: isloading),
            // AddressSavedListWidget(isloading: isloading),
            CustomPaint(
              painter:
                  DashedLineHorizontalPainter(dotColor: ColorUtils.taxdarkGray),
              size: const Size(1, double.infinity),
              child: SizedBox(width: Sizes.screenWidth()),
            ),
            20.height,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  data: AppStrings.searchResult,
                  height: 1.3,
                  fontSize: 16,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontColor: ColorUtils.bluishblack,
                ),
              ),
            ),
            15.height,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AddressSuggestedListWidget(
                  suggestedAddress: suggestedAddress,
                  isloading: isloading,
                ),
              ),
            ),
            10.height,
          ],
        ),
      ),
    );
  }
}
