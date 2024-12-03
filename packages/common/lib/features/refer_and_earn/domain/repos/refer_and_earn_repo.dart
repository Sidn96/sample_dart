import 'package:common/features/refer_and_earn/data/data_sources/refer_and_earn_remote_ds.dart';
import 'package:common/features/refer_and_earn/data/dtos/partner_ref_messages_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refer_and_earn_repo.g.dart';

@riverpod
ReferAndEarnRepo referAndEarnRepo(ReferAndEarnRepoRef ref) {
  return ReferAndEarnRepo(
      remoteDataSource: ref.watch(referAndEarnRemoteDataSourceProvider));
}

class ReferAndEarnRepo {
  final ReferAndEarnRemoteDataSource remoteDataSource;

  ReferAndEarnRepo({required this.remoteDataSource});

  Future<PartnerRefMessagesDto> getpartnerRefMessages() async {
    return await remoteDataSource.getpartnerRefMessages();
  }

  Future<bool> sendpartnerRefEmail({required String emailId}) async {
    return await remoteDataSource.sendpartnerRefEmail(emailId: emailId);
  }
}
