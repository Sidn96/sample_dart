import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/features/refer_and_earn/data/dtos/partner_ref_messages_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refer_and_earn_remote_ds.g.dart';

@riverpod
ReferAndEarnRemoteDataSource referAndEarnRemoteDataSource(
    ReferAndEarnRemoteDataSourceRef ref) {
  return ReferAndEarnRemoteDataSource(api: ref.watch(apiFacadeProvider));
}

class ReferAndEarnRemoteDataSource {
  final ApiFacade api;

  final String partnerRefEmailPath = "/member/partnerRefEmail";
  final String getpartnerRefMessagesPath = "member/partnerRefMsg";

  ReferAndEarnRemoteDataSource({required this.api});

  Future<PartnerRefMessagesDto> getpartnerRefMessages() async {
    try {
      final response =
          await api.getData(path: getpartnerRefMessagesPath, sendToken: true);

      if (response.data != null) {
        return PartnerRefMessagesDto.fromJson(response.data);
      } else {
        return PartnerRefMessagesDto.fromJson(response.data);
      }
    } catch (e) {
      return const PartnerRefMessagesDto(status: 404, success: false);
    }
  }

  Future<bool> sendpartnerRefEmail({required String emailId}) async {
    try {
      final response = await api.postData(
          path: partnerRefEmailPath,
          data: {"partnerRefEmail": emailId},
          sendToken: true);

      if (response.data != null) {
        return response.data["success"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
