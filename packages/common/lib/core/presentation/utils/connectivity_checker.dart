import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityChecker {
  static final _instance = ConnectivityChecker._();

  static ConnectivityChecker get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  bool _isOnline = false;

  ConnectivityChecker._();
  bool get isOnline => _isOnline;

  Stream get myStream => _controller.stream;

  void disposeStream() => _controller.close();

  void initialise() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(List<ConnectivityResult> result) async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      _isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      _isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }
}
