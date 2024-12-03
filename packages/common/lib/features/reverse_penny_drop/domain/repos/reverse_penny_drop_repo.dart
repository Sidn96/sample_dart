import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/reverse_penny_drop/data/data_source/reverse_penny_drop_remote_ds.dart';
import 'package:common/features/reverse_penny_drop/data/dtos/rpd_dto.dart';

part 'reverse_penny_drop_repo.g.dart';

@Riverpod(keepAlive: true)
RPDRepository rpdRepository(RpdRepositoryRef ref) {
  return RPDRepository(remoteDs: ref.watch(rpdRemoteDsProvider));
}

class RPDRepository {
  final RPDRemoteDs remoteDs;

  RPDRepository({required this.remoteDs});

  Future<RpdDto> fetchRpdDetials() async {
    return await remoteDs.fetchRpdDetials();
  }
}
