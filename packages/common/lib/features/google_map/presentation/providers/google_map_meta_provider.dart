import 'dart:async';
import 'dart:ui' as ui;

import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'address_map_provider.dart';
import 'location_permission_handler_provider.dart';

part 'google_map_meta_provider.g.dart';

Future<Uint8List> getBytesFromAsset(String path, {int? width}) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width ?? 3.round() * 30);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

Future<LatLng> getUserCurrentLocation() async {
  var position = await GeolocatorPlatform.instance.getCurrentPosition(
      locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.high,
  ));
  return LatLng(position.latitude, position.longitude);
}

@riverpod
Future<LatLng> initialMapLatalang(ref) async {
  final locationPermission = ref.watch(locationPermissionHandlerProvider);
  if (locationPermission == MapLocationAccess.allowedLocation) {
    return await getUserCurrentLocation();
  } else {
    return const LatLng(20.5937, 78.9629);
  }
}

Future<Marker> setGMapMark(ref, LatLng latLng) async {
  final Uint8List markerIcon =
      await getBytesFromAsset(AppImages.mapPin, width: kIsWeb ? 30 : null);
  Marker kMapMarker = Marker(
    draggable: true,
    markerId: MarkerId("${DateTime.now().microsecondsSinceEpoch}"),
    infoWindow: const InfoWindow(title: "Your Pal will reach at this place"),
    icon: BitmapDescriptor.fromBytes(markerIcon),
    position: latLng,
    onDragEnd: (latLang) async {
      ref.read(latLangCommonCallProvider(latLang));
    },
  );
  return kMapMarker;
}

Circle setMapCircle(LatLng latLng) {
  Circle aCircle = Circle(
    circleId: CircleId("${DateTime.now().microsecondsSinceEpoch}"),
    consumeTapEvents: false,
    fillColor: ColorUtils.warningCircle.withOpacity(0.4),
    center: latLng,
    radius: 100,
    strokeColor: ColorUtils.yellow,
    strokeWidth: 2,
    visible: true,
  );
  return aCircle;
}

Polygon setPolygon(List<LatLng> laglangs) {
  Polygon polygon = Polygon(
      polygonId: PolygonId("${DateTime.now().microsecondsSinceEpoch}"),
      points: laglangs,
      fillColor: ColorUtils.warningCircle,
      strokeColor: ColorUtils.yellow,
      strokeWidth: 1,
      visible: true);
  return polygon;
}

Polyline setPolyline(List<LatLng> laglangs) {
  Polyline polyline = Polyline(
    polylineId: PolylineId("${DateTime.now().microsecondsSinceEpoch}"),
    points: laglangs,
    width: 2,
    color: Colors.transparent,
  );
  return polyline;
}

@riverpod
class MapCircle extends _$MapCircle {
  @override
  Set<Circle> build() => {};

  updateCircle(LatLng latLng) async {
    final Circle mark = setMapCircle(latLng);
    state.clear();
    state.add(mark);
    state = {...state};
  }
}

@riverpod
class MapMarkers extends _$MapMarkers {
  @override
  Set<Marker> build() => {};

  updateMarker(LatLng latLng) async {
    final Marker mark = await setGMapMark(ref, latLng);
    state.clear();
    state.add(mark);
    state = {...state};
  }
}

@riverpod
class MapPolygon extends _$MapPolygon {
  @override
  Set<Polygon> build() => {};

  updatePolygon(List<LatLng> latLng) async {
    final Polygon mark = setPolygon(latLng);
    state.clear();
    state.add(mark);
    state = {...state};
  }
}

@riverpod
class MapPolyline extends _$MapPolyline {
  @override
  Set<Polyline> build() => {};

  updatePolyline(List<LatLng> latLng) async {
    final Polyline mark = setPolyline(latLng);
    state.clear();
    state.add(mark);
    state = {...state};
  }
}

@riverpod
class TruePalGoogleMapController extends _$TruePalGoogleMapController {
  @override
  Completer<GoogleMapController> build() {
    return Completer<GoogleMapController>();
  }

  Future<void> goToPlace(LatLng latLng) async {
    GoogleMapController control = await state.future;
    control.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 16.4746)));
  }
}
