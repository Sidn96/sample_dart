import 'package:geolocator/geolocator.dart';

class GeoLocatorUtils {
  static GeoLocatorUtils? instance;

  const GeoLocatorUtils._();

  factory GeoLocatorUtils() {
    instance ??= const GeoLocatorUtils._();
    return instance!;
  }

  Future<(double lat, double lng)> getUserCurrentLatLong() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ));
    return (position.latitude, position.longitude);
  }

  Future<bool> askForLatLongPermissionOnceIfNotGranted() async {
    var permissionGranted = await haveLatLongPermission();
    if (permissionGranted) {
      return true;
    } else {
      await Geolocator.requestPermission();
    }
    return await haveLatLongPermission();
  }

  Future<bool> haveLatLongPermission() async {
    var permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
      case LocationPermission.unableToDetermine:
        return false;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        return true;
    }
  }
}
