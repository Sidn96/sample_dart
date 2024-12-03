import 'package:common/features/terms_conditions/infrastructure/tnc_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tnc_state_notifier.g.dart';

@riverpod
class TncStateNotifier extends _$TncStateNotifier {
  @override
  AsyncValue<String> build() {
    fetchAndSetTnC();
    return const AsyncValue.loading();
  }

  fetchAndSetTnC() async {
    state = const AsyncValue.loading();
    final repo = ref.read(getTnCRepositoryProvider);
    final response = await repo.getTnc();
    response.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}
