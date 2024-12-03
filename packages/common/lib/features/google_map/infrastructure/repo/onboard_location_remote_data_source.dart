import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboard_location_remote_data_source.g.dart';

@riverpod
OnboardLocationServiceRemoteDataSource onboardLocationServiceRemoteDataSource(
    OnboardLocationServiceRemoteDataSourceRef ref) {
  return OnboardLocationServiceRemoteDataSource(
      api: ref.watch(apiFacadeProvider));
}

class OnboardLocationServiceRemoteDataSource {
  final ApiFacade api;
  OnboardLocationServiceRemoteDataSource({required this.api});

  
}
