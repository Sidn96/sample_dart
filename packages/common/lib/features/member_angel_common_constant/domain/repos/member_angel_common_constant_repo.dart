import 'package:common/features/member_angel_common_constant/data/data_sources/member_angel_commong_constant_remote_datasource.dart';
import 'package:common/features/member_angel_common_constant/data/dtos/member_angel_common_constant_dto.dart';
import 'package:common/features/profile/presentation/common_imports.dart';

part 'member_angel_common_constant_repo.g.dart';

@riverpod
MemberAngelCommonConstantRepo memberAngelCommonConstantRepo(
    MemberAngelCommonConstantRepoRef ref) {
  return MemberAngelCommonConstantRepo(
    memberAngelCommongConstantRemoteDataSource:
        ref.watch(memberAngelCommongConstantRemoteDataSourceProvider),
  );
}

class MemberAngelCommonConstantRepo {
  final MemberAngelCommongConstantRemoteDataSource
      memberAngelCommongConstantRemoteDataSource;

  MemberAngelCommonConstantRepo(
      {required this.memberAngelCommongConstantRemoteDataSource});

  Future<MemberAngelCommonConstantData?> getMemberAngelCommonConstant() async {
    return await memberAngelCommongConstantRemoteDataSource
        .getMemberAngelCommonConstant();
  }
}
