import 'package:common/core/presentation/utils/enums/app_type.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/member_angel_common_constant/domain/repos/member_angel_common_constant_repo.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/providers/service_recommendation_and_rating_provider.dart';

import '../../domain/entities/truepal_constant_data.dart';

part 'member_angel_common_constant_provider.g.dart';

// @riverpod
// Future<MemberAngelCommonConstantDto> getMemberAngelCommonConstant(
//     Ref ref) async {
//   return await ref
//       .read(memberAngelCommonConstantRepoProvider)
//       .getMemberAngelCommonConstant();
// }

/// using keepAlive caching data
@Riverpod(keepAlive: true)
class MemberAngelConstant extends _$MemberAngelConstant {
  // caching data
  TruepalConstantData? data;
  @override
  Future<TruepalConstantData?> build() async {
    return null;
  }

  Future<TruepalConstantData?> getMemberAngelConstantData(
      AppType appType) async {
    try {
      if (data != null) {
        state = AsyncValue.data(data);
        return state.value;
      }
      state = const AsyncValue.loading();
      final constantData = await ref
          .read(memberAngelCommonConstantRepoProvider)
          .getMemberAngelCommonConstant();
      if (constantData == null) {
        state = const AsyncValue.error("Error", StackTrace.empty);
        return state.value;
      }

      data = TruepalConstantData.toEntity(constantData);

      if (appType == AppType.partner) {
        ref
            .read(partnerRecommendationAndRatingDataProvider.notifier)
            .setQuestionDetails(data!.memberFeedbackDetails!);
      } else {
        ref
            .read(memberRecommendationAndRatingDataProvider.notifier)
            .setQuestionDetails(data!.palFeedbackDetails!);
      }
      state = AsyncValue.data(data);
      return state.value;
    } catch (_) {
      return state.value;
    }
  }
}
