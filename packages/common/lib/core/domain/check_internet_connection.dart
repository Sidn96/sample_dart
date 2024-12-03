import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternetConnectivity {
  CheckInternetConnectivity._();

  static Future<bool> checkInternetStatus() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}
