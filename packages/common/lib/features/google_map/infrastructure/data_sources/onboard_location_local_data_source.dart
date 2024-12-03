import 'package:common/core/infrastructure/local/store_local_preference.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entity/user_onboard_entity.dart';

part 'onboard_location_local_data_source.g.dart';

@riverpod
OnboardLocationServiceLocalDataSource onboardLocationServiceLocalDataSource(
    OnboardLocationServiceLocalDataSourceRef ref) {
  return OnboardLocationServiceLocalDataSource(
      localPreference: ref.watch(localPreferenceProvider));
}

class OnboardLocationServiceLocalDataSource {
  final LocalPreference localPreference;
  OnboardLocationServiceLocalDataSource({required this.localPreference});

  UserOnboardEntity? getUserOnboardLocation() {
    String? data = localPreference.getUserOnboardingLocation();
    return data != null ? userOnboardEntityFromJson(data) : null;
  }

  Future<void> storeUserOnboardLocation(UserOnboardEntity data) async {
    await localPreference
        .setUserOnboardingLocation(userOnboardEntityToJson(data));
  }
}
