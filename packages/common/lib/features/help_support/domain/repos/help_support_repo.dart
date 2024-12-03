import 'package:common/features/help_support/data/datasource/help_support_remote_datasource.dart';
import 'package:common/features/help_support/domain/entities/help_support_entity.dart';
import 'package:common/features/profile/presentation/common_imports.dart';

part 'help_support_repo.g.dart';

@riverpod
HelpSupportRepo helpSupportRepo(HelpSupportRepoRef ref) {
  return HelpSupportRepo(
    helpSupportRemoteDataSource: ref.watch(helpSupportRemoteDataSourceProvider),
  );
}

class HelpSupportRepo {
  final HelpSupportRemoteDataSource helpSupportRemoteDataSource;

  HelpSupportRepo({required this.helpSupportRemoteDataSource});

  Future<HelpSupportDataEntity?> getHelpSupport() async {
    try {
      final result = await helpSupportRemoteDataSource.getHelpSupport();
      return HelpSupportDataEntity.toEntity(result);
    } catch (_) {
      return null;
    }
  }
}
