import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/help_support/domain/entities/help_support_entity.dart';
import 'package:common/features/help_support/domain/repos/help_support_repo.dart';

part 'help_support_provider.g.dart';

// @riverpod
// Future<HelpSupportDataEntity?> getHelpSupport(Ref ref) async {
//   return await ref.read(helpSupportRepoProvider).getHelpSupport();
// }

@Riverpod(keepAlive: true)
class HelpSupport extends _$HelpSupport {
  @override
  HelpSupportDataEntity build() {
    return const HelpSupportDataEntity();
  }

  Future<HelpSupportDataEntity?> getHelpSupport() async {
    final value = await ref.read(helpSupportRepoProvider).getHelpSupport();
    state = state.copyWith(
      partnerPhoneNumber1: value?.partnerPhoneNumber1,
      partnerPhoneNumber2: value?.partnerPhoneNumber2,
      memberPhoneNumber1: value?.memberPhoneNumber1,
      memberPhoneNumber2: value?.memberPhoneNumber2,
      email: value?.email,
      palTiming: value?.palTiming,
      memberTiming: value?.memberTiming,
    );

    return value;
  }
}
