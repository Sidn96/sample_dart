import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/reverse_penny_drop/data/dtos/rpd_dto.dart';

part 'reverse_penny_drop_remote_ds.g.dart';

@Riverpod(keepAlive: true)
RPDRemoteDs rpdRemoteDs(RpdRemoteDsRef ref) {
  return RPDRemoteDs(api: ref.watch(apiFacadeProvider));
}

class RPDRemoteDs {
  static const String fetchRpd = 'nps/buyJourney/rpd';

  final ApiFacade api;
  RPDRemoteDs({required this.api});

  Future<RpdDto> fetchRpdDetials() async {
    try {
      final response = await api.postData(path: fetchRpd, sendToken: true);
      return RpdDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
