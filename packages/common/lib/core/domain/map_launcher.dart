import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class MapsLauncher {
  /// Launches the maps application for this platform.
  /// The maps application will show the result of the provided search [query].
  /// Returns a Future that resolves to true if the maps application
  /// was launched successfully, false otherwise.
  static Future<bool> launchQuery(String query) async {
    try {
      Uri uri = Uri.parse("comgooglemaps://?q=$query&zoom=15");
      Uri iOSUri = Uri.parse("maps://?q=$query");

      if (Platform.isIOS && await canLaunchUrl(uri)) {
        return launchUrl(uri);
      } else if (Platform.isIOS && await canLaunchUrl(iOSUri)) {
        return launchUrl(iOSUri);
      } else {
        Uri uri = Uri.https(
            'www.google.com', '/maps/search/', {'api': '1', 'query': query});
        return launchUrl(uri);
      }
    } catch (_) {
      Uri uri = Uri.https(
          'www.google.com', '/maps/search/', {'api': '1', 'query': query});
      return launchUrl(uri);
      // return false;
    }
  }

  static Future<bool> openMap(double latitude, double longitude,
      {String? label}) async {
    try {
      Uri uri = Uri.parse(
          "comgooglemaps://?q=@$latitude,$longitude${label != null && label.isNotEmpty ? '($label)' : ''}&zoom=15");
      Uri iOSUri = Uri.parse("maps://?q=$latitude,$longitude");

      if (Platform.isIOS && await canLaunchUrl(uri)) {
        return launchUrl(uri);
      } else if (Platform.isIOS && await canLaunchUrl(iOSUri)) {
        return launchUrl(iOSUri);
      } else {
        Uri uri = Uri.https('maps.google.com', '/maps/search/', {
          'api': '1',
          'query': '$latitude,$longitude',
        });
        return launchUrl(uri);
      }
    } catch (e) {
      Uri uri = Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': '$latitude,$longitude',
      });
      return launchUrl(uri);
      // return false;
    }
  }
}
