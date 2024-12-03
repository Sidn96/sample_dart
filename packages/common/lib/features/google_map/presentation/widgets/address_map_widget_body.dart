import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/address_map_provider.dart';
import '../providers/member_booking_map_address_provider.dart';
import 'map_body_widget.dart';

class AddressMapWidgetBody extends ConsumerWidget {
  const AddressMapWidgetBody({super.key});

  @override
  Widget build(BuildContext context, ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      redirectMapForEditAddress(ref);
    });
    return const MapBodyWidget();
  }

  redirectMapForEditAddress(WidgetRef ref) {
    final savedAddress = ref.read(memberBookingMapAddressProvider);
    if (savedAddress.forEdit == true) {
      Future.delayed(const Duration(seconds: 1), () async {
        if (savedAddress.memberAddresses?.lat != null &&
            savedAddress.memberAddresses?.long != null) {
          ref.read(latLangCommonCallProvider(
            LatLng(
              double.parse(savedAddress.memberAddresses!.lat!),
              double.parse(savedAddress.memberAddresses!.long!),
            ),
            fromTap: true,
          ));
        }
      });
    }
  }
}
