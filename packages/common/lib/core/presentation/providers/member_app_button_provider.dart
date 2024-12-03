import 'package:common/core/presentation/utils/riverpod_framework.dart';

part 'member_app_button_provider.g.dart';

@Riverpod(keepAlive: true)
class MemberAppButtonPressed extends _$MemberAppButtonPressed {
  @override
  bool build() {
    return false;
  }

  changeState(bool value) => state = value;
}
