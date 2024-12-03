import 'package:common/features/terms_conditions/infrastructure/tnc_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'legal_state_notifier.g.dart';

@riverpod
class LegalStateNotifier extends _$LegalStateNotifier {
  @override
  AsyncValue<String> build() {
    fetchAndSetLegalDisclaimer();
    return const AsyncValue.loading();
  }

  fetchAndSetLegalDisclaimer() async {
    state = const AsyncValue.loading();
    final repo = ref.read(getTnCRepositoryProvider);
    final response = await repo.getLegalDisclaimer();
    response.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}
