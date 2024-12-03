import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../../../core/presentation/widgets/user_journey_app_bar_widget.dart';
import '../providers/address_map_provider.dart';
import '../providers/member_booking_map_address_provider.dart';
import '../screens/map_visit_address_page.dart';
import 'address_suggestion_widget.dart';
import 'map_cta_widget.dart';
import 'map_search_bar_widget.dart';

class MapLocationBottomSheetWidget extends ConsumerWidget {
  const MapLocationBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(showForceMapProvider);
    ref.watch(forcePincodeEnableProvider);
    final addressSuggestionEnable =
        ref.watch(addressSuggestionNotifierProvider);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border.all(color: ColorUtils.darkGrayColor),
          color: ColorUtils.white2,
        ),
        child: Column(
          children: [
            20.height,
            const UserJourneyAppBarWidget(
              title: "Confirm Visit Location",
              bgColor: ColorUtils.white2,
            ),
            const MapSearchBarWidget(),
            10.height,
            Expanded(
              child: Stack(
                children: [
                  const MapVisitAddressPage(
                    bottomWidget: MapCtaWidget(),
                  ),
                  if (addressSuggestionEnable)
                    kIsWeb
                        ? PointerInterceptor(
                            child: const AddressSuggestionWidget())
                        : const AddressSuggestionWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
