abstract class ILocationService {
  Future<bool> isLocationServiceEnabled();

  Future<bool> isWhileInUsePermissionGranted();

  Future<bool> isAlwaysPermissionGranted();

  Future<bool> enableLocationService();

  Future<bool> requestWhileInUsePermission();

  Future<bool> requestAlwaysPermission();
}
