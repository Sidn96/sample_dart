
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cta_button_state_notifier.g.dart';
part 'cta_button_state_notifier.freezed.dart';

@freezed
class CtaButtonState with _$CtaButtonState{
  const factory CtaButtonState({
    required bool isEnable,
    required String name,
  }) = _CtaButtonState;
}

@riverpod
class CtaButtonStateNotifier extends _$CtaButtonStateNotifier {
  @override
  CtaButtonState build() {
    return const CtaButtonState(isEnable: false, name: 'Get OTP');
  }

  void updateState(CtaButtonState newState) {
    state = newState;
  }
}