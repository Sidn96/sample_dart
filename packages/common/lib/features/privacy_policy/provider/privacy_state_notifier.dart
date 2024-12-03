import 'package:common/features/terms_conditions/infrastructure/tnc_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'privacy_state_notifier.g.dart';

@riverpod
class PrivacyStateNotifier extends _$PrivacyStateNotifier {
  @override
  AsyncValue<String> build() {
    fetchAndSetPrivacy();
    return const AsyncValue.loading();
  }

  fetchAndSetPrivacy() async {
    state = const AsyncValue.loading();
    final repo = ref.read(getTnCRepositoryProvider);
    final response = await repo.getPrivacyPolicy();
    response.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}
