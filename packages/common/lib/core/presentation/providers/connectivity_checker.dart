import 'package:common/core/domain/check_internet_connection.dart';
import 'package:common/core/presentation/utils/connectivity_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_checker.g.dart';

@Riverpod(keepAlive: true)
class ConnectivityCheckerNotifier extends _$ConnectivityCheckerNotifier {
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;

  @override
  ConnectivityStatus build() {
    if (!kIsWeb) {
      startConnectivityStream();
    }
    return kIsWeb
        ? ConnectivityStatus.online
        : _connectivity.isOnline
            ? ConnectivityStatus.online
            : ConnectivityStatus.offline;
  }

  startConnectivityStream() async {
    state = await CheckInternetConnectivity.checkInternetStatus()
        ? ConnectivityStatus.online
        : ConnectivityStatus.offline;
  }
}

enum ConnectivityStatus { online, offline }
