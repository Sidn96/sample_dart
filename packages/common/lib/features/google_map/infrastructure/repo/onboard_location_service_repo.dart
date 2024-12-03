import 'package:common/core/infrastructure/network/network_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data_sources/onboard_location_local_data_source.dart';
import '../entity/user_onboard_entity.dart';
import 'onboard_location_remote_data_source.dart';

part 'onboard_location_service_repo.g.dart';

@riverpod
OnboardLocationServiceRepo onboardLocationServiceRepo(
    OnboardLocationServiceRepoRef ref) {
  return OnboardLocationServiceRepo(
    networkInfo: ref.watch(networkInfoProvider),
    onboardLocationServiceRemoteDataSource:
        ref.watch(onboardLocationServiceRemoteDataSourceProvider),
    onboardLocationServiceLocalDataSource:
        ref.watch(onboardLocationServiceLocalDataSourceProvider),
  );
}

class OnboardLocationServiceRepo {
  final NetworkInfo networkInfo;
  final OnboardLocationServiceRemoteDataSource
      onboardLocationServiceRemoteDataSource;
  final OnboardLocationServiceLocalDataSource
      onboardLocationServiceLocalDataSource;

  OnboardLocationServiceRepo({
    required this.networkInfo,
    required this.onboardLocationServiceRemoteDataSource,
    required this.onboardLocationServiceLocalDataSource,
  });

  Future<UserOnboardEntity?> getUserOnboardLocation() async {
    return onboardLocationServiceLocalDataSource.getUserOnboardLocation();
  }

  Future<void> storeUserOnboardLocationData(UserOnboardEntity data) async {
    await onboardLocationServiceLocalDataSource.storeUserOnboardLocation(data);
  }
}
