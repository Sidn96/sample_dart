import 'package:common/core/infrastructure/api_result.dart';
import 'package:common/core/infrastructure/dtos/faq_response.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/components_v2/providers_v2/faq_v2_provider.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/env/env.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_v2_repo.g.dart';

@riverpod
FaqV2Repo faqV2Repo(FaqV2RepoRef ref) {
  return FaqV2Repo(ref.read(apiFacadeProvider));
}

class FaqV2Repo {
  final ApiFacade _apiFacade;
  static const String faqEndPoint = '/api/faq';

  FaqV2Repo(this._apiFacade);

  Future<ApiResult> getFaq({required String category, required int limit, required int page}) async {
    try {
      // throw Error();
      var response = await _apiFacade.getDataRaw(
        path:
            "${Env.opsPanelBaseUrlFromEnv}api/faqs/$category?per_page=$limit&page=$page",
        // path: 'https://dev.thetruefin.com/api/faq',
      );
      if (response.statusCode == 200) {
        return Success(FaqResponse.fromJson(response.data));
      }
      return ApiResult.fromResponse(response, FaqResponse.fromJson);
    } catch (e) {
      // return Success(FaqResponse.fromJson(FAQComponentEvents.dummyAPIResponse));
      return InternalError('Internal Error, Something is wrong');
    }
  }

// Future<ApiResult> getFaqFor(String podName) async {
//   try {
//     var response = await _apiFacade.getDataRaw(
//       path: faqEndPoint,
//       // path: 'https://dev.thetruefin.com/api/faq',
//     );
//     if (response.statusCode == 200) {
//       var resData = FaqResponse.fromJson(response.data);
//       resData.posts.removeWhere((element) => element.category != podName);
//       return Success(resData);
//     }
//     // return ApiResult.fromResponse(response, FaqResponse.fromJson);
//     return InternalError('Internal Error, Something is wrong');
//   } catch (e) {
//     // final responseData = FAQComponentEvents.dummyAPIResponse;
//     // return Success(FaqResponse.fromJson(responseData));
//     return InternalError('Internal Error, Something is wrong');
//   }
// }
}
