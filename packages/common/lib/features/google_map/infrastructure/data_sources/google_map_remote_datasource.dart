import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../presentation/providers/address_map_provider.dart';
import '../../presentation/providers/onboarding_location_provider.dart';
import '../dtos/google_map_place_id_dto.dart';
import '../dtos/google_map_searched_place_dto.dart';
import '../dtos/map_address_suggestion_dto.dart';
import '../dtos/nearbysearch_dto.dart';
import '../dtos/service_list_dto.dart';

part 'google_map_remote_datasource.g.dart';

@Riverpod(keepAlive: true)
GoogleMapRemoteDataSource googleMapRemoteDataSource(
    GoogleMapRemoteDataSourceRef ref) {
  return GoogleMapRemoteDataSource(ref: ref, api: ref.watch(apiFacadeProvider));
}

class GoogleMapRemoteDataSource {
  static const String googleMapBaseApi = "/care100/google/place/";
  static const String tpLocationServices = "/tp/location/services";

  final ApiFacade api;
  final GoogleMapRemoteDataSourceRef ref;

  GoogleMapRemoteDataSource({required this.ref, required this.api});

  Future<NearbysearchDto> getMapNearByLocationUsingLatLang(
      LatLng latLng) async {
    try {
      final response = await api.getData(
        path:
            "${googleMapBaseApi}nearbysearch?lat=${latLng.latitude}&long=${latLng.longitude}",
        sendToken: true,
      );
      if (response.data != null) {
        return NearbysearchDto.fromJson(response.data);
      } else {
        return NearbysearchDto.fromJson(response.data);
      }
    } on ServerException catch (e) {
      return NearbysearchDto.fromJson(e.fullErrorResponse.response?.data);
    } catch (e) {
      return const NearbysearchDto();
    }
  }

  Future<GoogleMapSearchedPlaceDto> getMapPlace(String place,
      {String? rawPlaceId}) async {
    try {
      final response = await api.getData(
        path: place != ""
            ? "${googleMapBaseApi}details?place=$place"
            : "${googleMapBaseApi}details?rawPlaceId=$rawPlaceId",
        sendToken: true,
      );
      if (response.data != null) {
        return GoogleMapSearchedPlaceDto.fromJson(response.data);
      } else {
        return GoogleMapSearchedPlaceDto.fromJson(response.data);
      }
    } on ServerException catch (e) {
      return GoogleMapSearchedPlaceDto.fromJson(
          e.fullErrorResponse.response?.data);
    } catch (e) {
      return GoogleMapSearchedPlaceDto();
    }
  }

  Future<GoogleMapPlaceIdDto> getMapPlaceId(String place) async {
    try {
      final response = await api.getData(
        path: "${googleMapBaseApi}fromtext?place=$place",
        sendToken: true,
      );
      if (response.data != null) {
        return GoogleMapPlaceIdDto.fromJson(response.data);
      } else {
        return GoogleMapPlaceIdDto.fromJson(response.data);
      }
    } on ServerException catch (e) {
      return GoogleMapPlaceIdDto.fromJson(e.fullErrorResponse.response?.data);
    } catch (e) {
      return const GoogleMapPlaceIdDto();
    }
  }

  Future<MapAddressSuggestionDto> getMapPlaceSuggestions(String place) async {
    try {
      final response = await api.getData(
        path: "${googleMapBaseApi}suggestions?place=$place",
        sendToken: true,
      );
      if (response.data != null) {
        return MapAddressSuggestionDto.fromJson(response.data);
      } else {
        return MapAddressSuggestionDto.fromJson(response.data);
      }
    } on ServerException catch (e) {
      return MapAddressSuggestionDto.fromJson(e.fullErrorResponse.response);
    } catch (e) {
      return const MapAddressSuggestionDto();
    }
  }

  Future<ServiceListDto?> getServiceListData({String? rawPin}) async {
    try {
      String? pincode;
      pincode =
          rawPin ?? ref.read(searchedPincodeNotifierProvider.notifier).pincode;
      if (pincode != null) {
        final response = await api.getData(
            path: tpLocationServices, queryParameters: {"pincode": pincode});
        return ServiceListDto.fromJson(response.data);
      } else {
        final pincodeData = await ref.read(getUserOnboardDataProvider.future);
        pincode = pincodeData?.pincode;
        if (pincode != null) {
          final response = await api.getData(
              path: tpLocationServices, queryParameters: {"pincode": pincode});
          return ServiceListDto.fromJson(response.data);
        } else {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }

  Future<GoogleMapSearchedPlaceDto> getMapPlaceUsingLatLang(
      String lat, String lang) async {
    try {
      final response = await api.getData(
        path: "${googleMapBaseApi}details-by-lat-long?lat=$lat&long=$lang",
        sendToken: true,
      );
      if (response.data != null) {
        return GoogleMapSearchedPlaceDto.fromJson(response.data);
      } else {
        return GoogleMapSearchedPlaceDto.fromJson(response.data);
      }
    } on ServerException catch (e) {
      return GoogleMapSearchedPlaceDto.fromJson(
          e.fullErrorResponse.response?.data);
    } catch (e) {
      return GoogleMapSearchedPlaceDto();
    }
  }
}
