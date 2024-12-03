import 'package:connectivity_plus/connectivity_plus.dart';

import '../../presentation/utils/riverpod_framework.dart';

part 'network_info.g.dart';

@Riverpod(keepAlive: true)
NetworkInfo networkInfo(NetworkInfoRef ref) {
  return NetworkInfo(
    // DataConnectionChecker(),
    Connectivity(),
  );
}

class NetworkInfo {
  NetworkInfo(
    // this.dataConnectionChecker,
    this.connectivity,
  );

  // final DataConnectionChecker dataConnectionChecker;
  final Connectivity connectivity;

  Future<bool> get hasInternetConnection async =>
      await connectivity.checkConnectivity() != ConnectivityResult.none;
  // Future<bool> get hasInternetConnection => dataConnectionChecker.hasConnection;

  Future<List<ConnectivityResult>> get hasNetworkConnectivity =>
      connectivity.checkConnectivity();
}
