import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../infrastructure/dtos/google_map_searched_place_dto.dart';
import '../../infrastructure/dtos/nearbysearch_dto.dart';
import '../../infrastructure/entity/user_onboard_entity.dart';
import '../../infrastructure/repo/google_map_repo.dart';
import '../../infrastructure/repo/onboard_location_service_repo.dart';
import 'address_map_provider.dart';

part 'onboarding_location_provider.g.dart';

@Riverpod(keepAlive: true)
Future<UserOnboardEntity?> getUserOnboardData(Ref ref) async {
  return await ref
      .read(onboardLocationServiceRepoProvider)
      .getUserOnboardLocation();
}

@riverpod
Future<void> getUserPincodefromLatLang(ref, {required LatLng latLng}) async {
  GoogleMapSearchedPlaceDto result = await ref
      .read(googleMapRepoProvider)
      .getMapPlaceUsingLatLang(
          latLng.latitude.toString(), latLng.longitude.toString());
  // if pincode not present in above response will search user near by location and get pincode of nearby address
  if (result.result?.pincode == null) {
    NearbysearchDto nearbysearchDto = await ref
        .read(googleMapRepoProvider)
        .getMapNearByLocationUsingLatLang(LatLng(
            result.result!.geometry!.location!.lat!,
            result.result!.geometry!.location!.lng!));

    result = await ref
        .read(startPoolForPinUsingPlaceIdProvider(nearbysearchDto).future);
  }

  await ref.read(saveOnboardAddressToLocalProvider(result));
}

@riverpod
Future<void> saveOnboardAddressToLocal(
    Ref ref, GoogleMapSearchedPlaceDto result) async {
  await ref.read(findServicablePincodeFromAddressProvider(result).future);
  // storing onboard locatiion data to local storage.
  await ref
      .read(onboardLocationServiceRepoProvider)
      .storeUserOnboardLocationData(
        UserOnboardEntity(
          isServicable: ref.read(servicablePincodeEnableProvider),
          pincode: result.result?.pincode,
          address: result.result?.formattedAddress,
          city: result.result?.name ?? result.result?.city,
          state: result.result?.state,
          placeId: result.result?.placeId,
          geolocator: Geolocator(
            lat: result.result?.geometry?.location?.lat,
            lang: result.result?.geometry?.location?.lng,
          ),
        ),
      );
  final _ =
      ref.refresh(getUserOnboardDataProvider); // refresh UI with local data
}

@Riverpod(keepAlive: true)
class LocationBookingServiceNotifier extends _$LocationBookingServiceNotifier {
  @override
  bool build() {
    return false;
  }

  void changeState(bool value) => state = value;
}
