import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/extensions/string_extensions.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/core/presentation/widgets/retire100_images_asset_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

import '../../../../core/consts/constant_app_strings.dart';
import '../../../../core/presentation/utils/app_images.dart';
import '../../infrastructure/dtos/google_map_searched_place_dto.dart';
import '../providers/address_map_provider.dart';
import '../providers/member_booking_map_address_provider.dart';
import '../providers/pal_address_form_provider.dart';
import 'location_unservicable_widget.dart';

class MapCtaWidget extends ConsumerWidget {
  final String? bttnTitle;
  final bool hideUnserviceableUi;
  final bool? enableButton;
  final Function(GoogleMapSearchedPlaceDto address)? onPressed;
  const MapCtaWidget({
    super.key,
    this.bttnTitle,
    this.onPressed,
    this.enableButton,
    this.hideUnserviceableUi = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    final savedAddress = ref.read(memberBookingMapAddressProvider);
    final searchedAddress = ref.watch(finalSearchedGoogleMapAddressProvider);
    final isServicable = ref.watch(servicablePincodeEnableProvider);
    final suggestedName = ref.watch(selectedSuggestedNameProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 0.8),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          21.height,
          if (isServicable || hideUnserviceableUi) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Retire100SvgImageAssetWidget(
                  path: AppImages.locatemappin,
                ),
                8.width,
                SizedBox(
                  width: 280,
                  child: AppText(
                    data: suggestedName.toTitleCase(),
                    textAlign: TextAlign.start,
                    fontSize: 16,
                    height: 1.4,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            8.height,
            AppText(
              data: (savedAddress.forEdit == true && savedAddress.forTap == true
                      ? savedAddress.memberAddresses?.addressLine2 ?? ""
                      : searchedAddress.result?.formattedAddress ?? "")
                  .toTitleCase()
                  .trim(),
              textAlign: TextAlign.start,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontColor: ColorUtils.midLightGrey,
              height: 1.4,
            ),
          ] else ...[
            const LocationUnServicableWidget(),
          ],
          30.height,
          MemberAngelAppButton(
            buttonWidth: double.infinity,
            label: bttnTitle ?? AppStrings.enterCompleteAddress,
            onSuccessHandler: () async {
              if (onPressed != null) {
                await saveMapAddress(ref, searchedAddress);
                onPressed?.call(searchedAddress);
              } else {
                await saveMapAddress(ref, searchedAddress);
              }
            },
            bttnEnabled:
                enableButton ?? ref.read(servicablePincodeEnableProvider),
          ),
          30.height,
        ],
      ),
    );
  }

  Future saveMapAddress(
      WidgetRef ref, GoogleMapSearchedPlaceDto searchedAddress) async {
    final paladdressformState = ref.read(palAddressFormStateProvider.notifier);
    paladdressformState
        .setAddressLine2(searchedAddress.result?.addressline2 ?? "");
    paladdressformState.setCity(searchedAddress.result?.city ?? "");
    paladdressformState.setStateData(searchedAddress.result?.state ?? "");
    paladdressformState.setPincode(searchedAddress.result?.pincode ?? "");
    paladdressformState
        .setLat((searchedAddress.result?.geometry?.location?.lat).toString());
    paladdressformState
        .setLong((searchedAddress.result?.geometry?.location?.lng).toString());
  }
}
