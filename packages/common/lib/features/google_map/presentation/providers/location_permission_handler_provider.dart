import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_permission_handler_provider.g.dart';

Future<String> checkLocationServiceStatus() async {
  if (kIsWeb) {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return "enabled";
    } else {
      return "disabled";
    }
  } else {
    final serviceStatus = await Permission.location.serviceStatus;
    return serviceStatus.name;
  }
}

Future<PermissionStatus> checkLocationStatus() async {
  if (kIsWeb) {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return PermissionStatus.granted;
    } else {
      return PermissionStatus.denied;
    }
  } else {
    return await Permission.location.status;
  }
}

@Riverpod(keepAlive: true)
class LocationPermissionHandler extends _$LocationPermissionHandler {
  @override
  MapLocationAccess build() {
    return MapLocationAccess.initialLoading;
  }

  changePermissionState(MapLocationAccess value) => state = value;

  /// Request the files permission and updates the UI accordingly
  Future<MapLocationAccess> requestLocationPermission() async {
    final String serviceStatus = await checkLocationServiceStatus();

    if (serviceStatus != "disabled") {
      if (kIsWeb) {
        state = MapLocationAccess.allowedLocation;
      } else {
        PermissionStatus result = await Permission.location.request();
        if (result.isGranted) {
          state = MapLocationAccess.allowedLocation;
        } else if (Platform.isIOS || result.isPermanentlyDenied) {
          state = MapLocationAccess.noLocationPermissionPermanent;
        } else {
          state = MapLocationAccess.noLocationPermission;
        }
      }
    } else {
      state = MapLocationAccess.locationDisabled;
    }
    return state;
  }
}

// This enum will manage the overall state of the app
enum MapLocationAccess {
  initialLoading,
  locationDisabled,
  noLocationPermission, // Permission denied, but not forever
  noLocationPermissionPermanent, // Permission denied forever
  allowedLocation, // The UI shows the button to pick files
}
