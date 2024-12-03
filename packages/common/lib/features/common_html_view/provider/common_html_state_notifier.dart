import 'package:common/features/terms_conditions/infrastructure/tnc_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'common_html_state_notifier.g.dart';

@riverpod
class CommonHtmlStateNotifier extends _$CommonHtmlStateNotifier {
  @override
  AsyncValue<String> build() {
    return const AsyncValue.loading();
  }

  fetchAndSetContent(String contentUrl) async {
    state = const AsyncValue.loading();
    final repo = ref.read(getTnCRepositoryProvider);
    final response = await repo.getCommonHtmlContent(contentUrl);
    response.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}
