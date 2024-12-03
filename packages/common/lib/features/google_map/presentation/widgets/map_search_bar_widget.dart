import 'dart:async';

import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/address_map_provider.dart';
import '../providers/member_booking_map_address_provider.dart';
import '../providers/onboarding_location_provider.dart';
import '../providers/pal_address_form_provider.dart';
import '../providers/pal_address_provider.dart';

class MapSearchBarWidget extends HookConsumerWidget {
  const MapSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final editAddress = ref.watch(palAddressFormStateProvider);
    final searchController = ref.watch(addressSuggestionControllerProvider);
    final isfromBooking = ref.read(locationBookingServiceNotifierProvider);
    ref.watch(selectedSuggestedNameProvider);
    ref.watch(palAddressesNotifierProvider);
    Timer? debounce;
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (editAddress.editingIndex != null) {
          ref.read(showForceMapProvider.notifier).changeState(true);
          ref
              .read(addressSuggestionNotifierProvider.notifier)
              .changeState(false);
          ref
              .read(selectedSuggestedNameProvider.notifier)
              .changeState(editAddress.addressLine2?.split(",")[0] ?? "");
          searchController.text = editAddress.addressLine2 ?? "";
          if (editAddress.lat != null && editAddress.long != null) {
            ref.read(latLangCommonCallProvider(
              LatLng(double.parse(editAddress.lat!),
                  double.parse(editAddress.long!)),
              fromTap: true,
            ));
          }
        }
        if (isfromBooking) {
          final onboardDataNotifier =
              await ref.read(getUserOnboardDataProvider.future);
          if (onboardDataNotifier?.geolocator?.lat != null &&
              onboardDataNotifier?.geolocator?.lang != null) {
            ref.read(latLangCommonCallProvider(
              LatLng(onboardDataNotifier!.geolocator!.lat!,
                  onboardDataNotifier.geolocator!.lang!),
            ));
          }
        }
      });
      return null;
    }, const []);
    return Container(
      height: 70,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtils.kOffWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 4.0,
            color: ColorUtils.white,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.3,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.search),
            ),
            Expanded(
              child: TextFormField(
                controller: searchController,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: "Search your location",
                  fillColor: ColorUtils.kOffWhiteColor,
                  filled: true,
                  border: InputBorder.none,
                ),
                onTapOutside: (e) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onTap: () {
                  if (searchController.text.isNotEmpty) {
                    ref.read(
                        getAddressSuggestionProvider(searchController.text));
                  }
                  ref
                      .read(addressSuggestionNotifierProvider.notifier)
                      .changeState(true);
                },
                onChanged: (value) {
                  if (debounce?.isActive ?? false) debounce?.cancel();
                  debounce = Timer(const Duration(milliseconds: 500), () {
                    if (value.isNotEmpty) {
                      ref.read(getAddressSuggestionProvider(value));
                    }
                  });
                },
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    // ref.read(
                    //     getMapPlaceProvider(context, place: searchController.text));
                    ref.read(
                        getAddressSuggestionProvider(searchController.text));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => searchController.clear(),
                child: const Icon(Icons.highlight_remove_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
