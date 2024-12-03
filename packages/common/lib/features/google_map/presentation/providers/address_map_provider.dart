import 'package:collection/collection.dart';
import 'package:common/core/infrastructure/dtos/pincode_list_dto.dart';
import 'package:common/core/infrastructure/repos/pincode_repo.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/toast_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../infrastructure/dtos/google_map_searched_place_dto.dart';
import '../../infrastructure/dtos/map_address_suggestion_dto.dart';
import '../../infrastructure/dtos/member_details_dto.dart';
import '../../infrastructure/dtos/nearbysearch_dto.dart';
import '../../infrastructure/dtos/service_list_dto.dart';
import '../../infrastructure/entity/member_addresses_entity.dart';
import '../../infrastructure/repo/google_map_repo.dart';
import '../../presentation/providers/google_map_meta_provider.dart';
import 'member_booking_map_address_provider.dart';

part 'address_map_provider.g.dart';

@riverpod
Future<void> findServicablePincodeFromAddress(
    Ref ref, GoogleMapSearchedPlaceDto data) async {
  final AddressComponent? addressComponent =
      data.result?.addressComponents?.firstWhereOrNull((com) {
    if (com.types != null && com.types!.contains("postal_code")) {
      return true;
    } else {
      return false;
    }
  });
  if (addressComponent != null) {
    await ref
        .read(searchedPincodeNotifierProvider.notifier)
        .changeState(addressComponent.longName);

    // if (addressComponent != null) {
    //   await ref
    //       .read(searchedPincodeNotifierProvider.notifier)
    //       .changeState(addressComponent.longName);

    //   ref.read(servicablePincodeEnableProvider.notifier).changeState(true);
    // } else {
    //   ref.read(servicablePincodeEnableProvider.notifier).changeState(false);
    // }

    // TODO: Ask how to find serviceable / un - serviceable UI in common
    // which API endpoint should be used
    final homeData = await ref
        .read(getServiceListDataProvider(addressComponent.longName).future);

    List<ServiceListData>? listdata = homeData?.data;

    if (listdata != null && listdata.isNotEmpty) {
      ref.read(servicablePincodeEnableProvider.notifier).changeState(true);
    } else {
      ref.read(servicablePincodeEnableProvider.notifier).changeState(false);
    }
  } else {
    ref.read(servicablePincodeEnableProvider.notifier).changeState(false);
  }
}

@riverpod
Future<ServiceListDto?> getServiceListData(Ref ref, String? rawPin) async {
  try {
    return await ref
        .read(googleMapRepoProvider)
        .getServiceListData(rawPin: rawPin);
  } catch (e) {
    return null;
  }
}

@riverpod
Future<MapAddressSuggestionDto> getAddressSuggestion(
    Ref ref, String place) async {
  final result =
      await ref.read(googleMapRepoProvider).getAddressSuggestion(place);
  ref.read(mapAddressSuggestionNotifierProvider.notifier).updateState(result);
  return result;
}

@riverpod
Future<GoogleMapSearchedPlaceDto> getfinalMapPlace(ref, String place) async {
  final result = await ref.read(googleMapRepoProvider).getMapPlace(place);
  ref.read(finalSearchedGoogleMapAddressProvider.notifier).changeState(result);
  return result;
}

@Riverpod(keepAlive: true)
Future<GoogleMapSearchedPlaceDto> getMapPlace(ref, BuildContext context,
    {String? place, String? lat, String? lang, bool updatemark = true}) async {
  GoogleMapSearchedPlaceDto result = place != null
      ? await ref.read(googleMapRepoProvider).getMapPlace(place)
      : await ref
          .read(googleMapRepoProvider)
          .getMapPlaceUsingLatLang(lat, lang);
  if (result.result == null ||
      result.status == null ||
      result.status == "ZERO_RESULTS") {
    ref.read(showAddressBottomSheetProvider.notifier).changeState(false);
    showToastBox(
      context,
      message: "Address not Found. Please enter a valid address",
      status: ToastStatus.error,
    );
  } else {
    await ref.read(showAddressBottomSheetProvider.notifier).changeState(true);

    // to redirect marker on map
    ref.read(truePalGoogleMapControllerProvider.notifier).goToPlace(LatLng(
        result.result!.geometry!.location!.lat!,
        result.result!.geometry!.location!.lng!));

    await ref.read(findServicablePincodeFromAddressProvider(result));

    await ref
        .read(searchedGoogleMapAddressProvider.notifier)
        .changeState(result);

    if (updatemark) {
      // to set marker on map
      ref.read(mapMarkersProvider.notifier).updateMarker(LatLng(
          result.result!.geometry!.location!.lat!,
          result.result!.geometry!.location!.lng!));

      // to set circle on map
      ref.read(mapCircleProvider.notifier).updateCircle(LatLng(
          result.result!.geometry!.location!.lat!,
          result.result!.geometry!.location!.lng!));
    }

    // await ref.read(getfinalMapPlaceProvider(result.result!.addressline2!));

    if (place == null) {
      ref.read(selectedSuggestedNameProvider.notifier).changeState(
          result.result?.name ??
              result.result?.subName ??
              result.result?.addressline2?.split(",")[0]);
    }
  }
  return result;
}

@riverpod
Future<GoogleMapSearchedPlaceDto> getMapPlaceUsingPlaceId(
    ref, String placeId) async {
  return await ref
      .read(googleMapRepoProvider)
      .getMapPlace("", rawPlaceId: placeId);
}

@riverpod
Future<GoogleMapSearchedPlaceDto> getMapUsingPlaceId(ref, String pId) async {
  return await ref.read(googleMapRepoProvider).getPlaceUsidPId(pId);
}

@riverpod
Future<String> getServicablePincodesText(ref) async {
  final PincodeListDto pincodeList = await ref.read(getPincodesProvider.future);
  final List<String?> allPin = [];
  pincodeList.data?.serviceablePincodes
      ?.forEach((pin) => allPin.add(pin.pincode));
  return allPin.join(", ");
}

@riverpod
Future<void> latLangCommonCall(Ref ref, LatLng latLang,
    {bool fromTap = false}) async {
  final savedAddress = ref.read(memberBookingMapAddressProvider);

  GoogleMapSearchedPlaceDto result = await ref
      .read(googleMapRepoProvider)
      .getMapPlaceUsingLatLang(
          latLang.latitude.toString(), latLang.longitude.toString());

  if (result.result?.geometry?.location?.lat != null &&
      result.result?.geometry?.location?.lat != null) {
    final AddressElement newAddress = AddressElement(
      memberAddresses: MemberAddress(
        id: savedAddress.forEdit == true
            ? savedAddress.memberAddresses?.id
            : null,
        lat: result.result?.geometry?.location?.lat?.toString(),
        long: result.result?.geometry?.location?.lng?.toString(),
      ),
    );
    await ref
        .read(memberBookingMapAddressProvider.notifier)
        .changeState(newAddress);

    // to move the marker
    if (savedAddress.forEdit == true && fromTap == true) {
      LatLng latLng = LatLng(double.parse(savedAddress.memberAddresses!.lat!),
          double.parse(savedAddress.memberAddresses!.long!));
      ref.read(truePalGoogleMapControllerProvider.notifier).goToPlace(latLng);
      // to set marker on map
      ref.read(mapMarkersProvider.notifier).updateMarker(latLng);
      // to set circle on map
      ref.read(mapCircleProvider.notifier).updateCircle(latLng);
    } else {
      // to move the marker
      ref.read(truePalGoogleMapControllerProvider.notifier).goToPlace(LatLng(
          result.result!.geometry!.location!.lat!,
          result.result!.geometry!.location!.lng!));
      // to set marker on map
      ref.read(mapMarkersProvider.notifier).updateMarker(LatLng(
          result.result!.geometry!.location!.lat!,
          result.result!.geometry!.location!.lng!));

      // to set circle on map
      ref.read(mapCircleProvider.notifier).updateCircle(LatLng(
          result.result!.geometry!.location!.lat!,
          result.result!.geometry!.location!.lng!));

      final AddressElement newAddress = AddressElement(forTap: false);
      await ref
          .read(memberBookingMapAddressProvider.notifier)
          .changeState(newAddress);
    }

    ref.read(forcePincodeEnableProvider.notifier).changeState(false);

    if (result.result?.pincode == null) {
      ref.read(forcePincodeEnableProvider.notifier).changeState(true);
      NearbysearchDto nearbysearchDto = await ref
          .read(googleMapRepoProvider)
          .getMapNearByLocationUsingLatLang(LatLng(
              result.result!.geometry!.location!.lat!,
              result.result!.geometry!.location!.lng!));

      result = await ref
          .read(startPoolForPinUsingPlaceIdProvider(nearbysearchDto).future);
    }
  }
  await ref.read(showForceMapProvider.notifier).changeState(true);
  await ref.read(addressSuggestionNotifierProvider.notifier).changeState(false);

  if (result.result?.geometry?.location?.lat != null &&
      result.result?.geometry?.location?.lng != null) {
    await ref.read(showAddressBottomSheetProvider.notifier).changeState(true);

    ref.read(findServicablePincodeFromAddressProvider(result));

    ref
        .read(finalSearchedGoogleMapAddressProvider.notifier)
        .changeState(result);

    await ref
        .read(searchedGoogleMapAddressProvider.notifier)
        .changeState(result);

    // ref.read(getfinalMapPlaceProvider(result.result!.addressline2!));

    ref.read(selectedSuggestedNameProvider.notifier).changeState(
        result.result?.name ??
            result.result?.subName ??
            result.result?.addressline2?.split(",")[0] ??
            "");
    ref.read(addressSuggestionControllerProvider).text =
        result.result?.addressline2 ?? "";
  }
}

@riverpod
Future<void> searchSelectedAddress(Ref ref, String placeId) async {
  GoogleMapSearchedPlaceDto result;
  result = await ref.read(getMapUsingPlaceIdProvider(placeId).future);
  if (result.result?.geometry?.location?.lat != null &&
      result.result?.geometry?.location?.lat != null) {
    final savedAddress = ref.read(memberBookingMapAddressProvider);
    final AddressElement newAddress = AddressElement(
      memberAddresses: MemberAddress(
        id: savedAddress.forEdit == true
            ? savedAddress.memberAddresses?.id
            : null,
        lat: result.result?.geometry?.location?.lat?.toString(),
        long: result.result?.geometry?.location?.lng?.toString(),
      ),
    );
    await ref
        .read(memberBookingMapAddressProvider.notifier)
        .changeState(newAddress);
    ref.read(truePalGoogleMapControllerProvider.notifier).goToPlace(LatLng(
        result.result!.geometry!.location!.lat!,
        result.result!.geometry!.location!.lng!));

    // to set marker on map
    ref.read(mapMarkersProvider.notifier).updateMarker(LatLng(
        result.result!.geometry!.location!.lat!,
        result.result!.geometry!.location!.lng!));

    // to set circle on map
    ref.read(mapCircleProvider.notifier).updateCircle(LatLng(
        result.result!.geometry!.location!.lat!,
        result.result!.geometry!.location!.lng!));

    if (result.result?.pincode == null) {
      ref.read(forcePincodeEnableProvider.notifier).changeState(true);
      NearbysearchDto nearbysearchDto = await ref
          .read(googleMapRepoProvider)
          .getMapNearByLocationUsingLatLang(LatLng(
              result.result!.geometry!.location!.lat!,
              result.result!.geometry!.location!.lng!));

      result = await ref
          .read(startPoolForPinUsingPlaceIdProvider(nearbysearchDto).future);
    }
  }
  await ref.read(showForceMapProvider.notifier).changeState(true);
  await ref.read(addressSuggestionNotifierProvider.notifier).changeState(false);

  if (result.result?.geometry?.location?.lat != null &&
      result.result?.geometry?.location?.lng != null) {
    await ref.read(showAddressBottomSheetProvider.notifier).changeState(true);

    ref.read(findServicablePincodeFromAddressProvider(result));

    ref
        .read(finalSearchedGoogleMapAddressProvider.notifier)
        .changeState(result);

    await ref
        .read(searchedGoogleMapAddressProvider.notifier)
        .changeState(result);

    // ref.read(getfinalMapPlaceProvider(result.result!.addressline2!));

    ref.read(selectedSuggestedNameProvider.notifier).changeState(
        result.result?.name ??
            result.result?.subName ??
            result.result?.addressline2?.split(",")[0] ??
            "");
  }
}

@riverpod
Future<GoogleMapSearchedPlaceDto> startPoolForPinUsingPlaceId(
    ref, NearbysearchDto nearbysearchDto) async {
  GoogleMapSearchedPlaceDto googleMapSearchedPlaceDto =
      GoogleMapSearchedPlaceDto();
  if (nearbysearchDto.results != null || nearbysearchDto.results!.isNotEmpty) {
    for (int i = 0; i < nearbysearchDto.results!.length; i++) {
      if (nearbysearchDto.results?[i].placeId != null) {
        googleMapSearchedPlaceDto = await ref.read(
            getMapPlaceUsingPlaceIdProvider(
                    nearbysearchDto.results![i].placeId!)
                .future);

        if (googleMapSearchedPlaceDto.result?.pincode != null) {
          break;
        }
      }
    }
  }
  return googleMapSearchedPlaceDto;
}

@Riverpod(keepAlive: true)
class FinalSearchedGoogleMapAddress extends _$FinalSearchedGoogleMapAddress {
  @override
  GoogleMapSearchedPlaceDto build() => GoogleMapSearchedPlaceDto();
  changeState(GoogleMapSearchedPlaceDto value) => state = value;
}

@riverpod
class ForcePincodeEnable extends _$ForcePincodeEnable {
  @override
  bool build() => false;
  changeState(bool value) => state = value;
}

@riverpod
class MapAddressSuggestionNotifier extends _$MapAddressSuggestionNotifier {
  @override
  MapAddressSuggestionDto build() {
    return const MapAddressSuggestionDto();
  }

  updateState(MapAddressSuggestionDto value) => state = value;
}

@riverpod
class MapBodyLoader extends _$MapBodyLoader {
  @override
  bool build() => false;
  changeState(bool value) => state = value;
}

@riverpod
class SearchedGoogleMapAddress extends _$SearchedGoogleMapAddress {
  @override
  GoogleMapSearchedPlaceDto build() => GoogleMapSearchedPlaceDto();
  changeState(GoogleMapSearchedPlaceDto value) => state = value;
}

@riverpod
class SearchedPincodeNotifier extends _$SearchedPincodeNotifier {
  String? pincode;
  @override
  String? build() {
    return null;
  }

  changeState(String? value) => pincode = value;
}

@riverpod
class SelectedSuggestedName extends _$SelectedSuggestedName {
  @override
  String build() => "";
  changeState(String value) => state = value;
}

@Riverpod(keepAlive: true)
class ServicablePincodeEnable extends _$ServicablePincodeEnable {
  @override
  bool build() {
    return false;
  }

  changeState(bool value) => state = value;
}

@riverpod
class ShowAddressBottomSheet extends _$ShowAddressBottomSheet {
  @override
  bool build() => false;
  changeState(bool value) => state = value;
}

@riverpod
class ShowForceMap extends _$ShowForceMap {
  @override
  bool build() => false;
  changeState(bool value) => state = value;
}
