import 'package:common/core/infrastructure/network/network_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../infrastructure/data_sources/google_map_remote_datasource.dart';
import '../../infrastructure/dtos/google_map_place_id_dto.dart';
import '../../infrastructure/dtos/google_map_searched_place_dto.dart';
import '../../infrastructure/dtos/map_address_suggestion_dto.dart';
import '../../infrastructure/dtos/nearbysearch_dto.dart';
import '../dtos/service_list_dto.dart';

part 'google_map_repo.g.dart';

@Riverpod(keepAlive: true)
GoogleMapRepo googleMapRepo(GoogleMapRepoRef ref) {
  return GoogleMapRepo(
    networkInfo: ref.watch(networkInfoProvider),
    remoteDataSource: ref.watch(googleMapRemoteDataSourceProvider),
  );
}

class GoogleMapRepo {
  final NetworkInfo networkInfo;
  final GoogleMapRemoteDataSource remoteDataSource;
  GoogleMapRepo({required this.networkInfo, required this.remoteDataSource});

  Future<MapAddressSuggestionDto> getAddressSuggestion(String place) async {
    return await remoteDataSource.getMapPlaceSuggestions(place);
  }

  Future<ServiceListDto?> getServiceListData({String? rawPin}) async {
    return await remoteDataSource.getServiceListData(rawPin: rawPin);
  }

  Future<NearbysearchDto> getMapNearByLocationUsingLatLang(
      LatLng latLng) async {
    return await remoteDataSource.getMapNearByLocationUsingLatLang(latLng);
  }

  Future<GoogleMapSearchedPlaceDto> getMapPlace(String place,
      {String? rawPlaceId}) async {
    return await remoteDataSource.getMapPlace(place, rawPlaceId: rawPlaceId);
  }

  Future<GoogleMapSearchedPlaceDto> getMapPlaceUsingLatLang(
      String lat, String lang) async {
    final res = await remoteDataSource.getMapPlaceUsingLatLang(lat, lang);
    return res;
  }

  Future<GoogleMapPlaceIdDto> getPlaceId(String place) async {
    return await remoteDataSource.getMapPlaceId(place);
  }

  Future<GoogleMapSearchedPlaceDto> getPlaceUsidPId(String pId) async {
    return await remoteDataSource.getMapPlace("", rawPlaceId: pId);
  }
}
