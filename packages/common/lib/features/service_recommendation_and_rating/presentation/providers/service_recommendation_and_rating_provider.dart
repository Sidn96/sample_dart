import 'package:common/core/presentation/utils/enums/app_type.dart';
import 'package:common/features/member_angel_common_constant/domain/entities/truepal_constant_data.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/service_recommendation_and_rating/domain/entities/member_angel_submit_rating_entity.dart';
import 'package:common/features/service_recommendation_and_rating/domain/repos/service_recommendation_and_rating_repo.dart';

part 'service_recommendation_and_rating_provider.g.dart';

@riverpod
Future<bool> sendUserRatingRecommendation(Ref ref) async {
  final ratingRepo = ref.read(serviceRecommendationAndRatingRepoProvider);
  return await ratingRepo.sendUserRatingRecommendation(
      ratingEntity: ref.read(memberRecommendationAndRatingDataProvider));
}

@riverpod
Future<bool> submitRatingRecommendation(Ref ref) async {
  final ratingRepo = ref.read(serviceRecommendationAndRatingRepoProvider);
  return await ratingRepo.submitRatingRecommendation(
      ratingEntity: ref.read(partnerRecommendationAndRatingDataProvider));
}

@riverpod
Future<bool> sendIgnoreRating(Ref ref, {required AppType? appType}) async {
  final ratingRepo = ref.read(serviceRecommendationAndRatingRepoProvider);

  if (appType == AppType.member) {
    final bookingId =
        ref.read(memberRecommendationAndRatingDataProvider).bookingId;
    if (bookingId == null) return false;
    return await ratingRepo.sendIgnoreRatingByMember(bookingId: bookingId);
  } else {
    final bookingId =
        ref.read(partnerRecommendationAndRatingDataProvider).bookingId;
    if (bookingId == null) return false;
    return await ratingRepo.sendIgnoreRatingByPartner(bookingId: bookingId);
  }
}

@Riverpod(keepAlive: true)
class MemberRecommendationAndRatingData
    extends _$MemberRecommendationAndRatingData {
  @override
  MemberAngelSubmitRatingEntity build() {
    return const MemberAngelSubmitRatingEntity();
  }

  void clearState() {
    state = const MemberAngelSubmitRatingEntity();
  }

  void _validate() {
    if (state.bookingId == null ||
        state.ratings == null ||
        state.ratings == 0) {
      _disableButton();
      return;
    } else {
      for (int i = 0; i < state.palFeedbackDetails.length; i++) {
        final memberDetails = state.palFeedbackDetails[i];
        if ((memberDetails.isMandatory ?? false) &&
            (memberDetails.value == null ||
                memberDetails.value.toString().isEmpty)) {
          _disableButton();
          return;
        } else {
          _enableButton();
        }
      }
    }
  }

  void _enableButton() {
    state = state.copyWith(isButtonEnabled: true);
  }

  void _disableButton() {
    state = state.copyWith(isButtonEnabled: false);
  }

  void setQuestionDetails(List<TruepalFeedbackDetail> details) {
    state = state.copyWith(palFeedbackDetails: details);
    _validate();
  }

  void updateQuestionAnswer(TruepalFeedbackDetail details,
      {bool shouldValidate = true}) {
    List<TruepalFeedbackDetail> detailList = [...state.palFeedbackDetails];

    final alreadyAddedIndex =
        detailList.indexWhere((data) => data.question == details.question);

    if (alreadyAddedIndex != -1) {
      detailList[alreadyAddedIndex] = details;
    } else {
      detailList.add(details);
    }
    state = state.copyWith(palFeedbackDetails: detailList);
    if (shouldValidate) {
      _validate();
    } else if (state.ratings != 0) {
      _enableButton();
    }
  }

  void setBookingId(int? bId) {
    state = state.copyWith(bookingId: bId);
    _validate();
  }

  void setRatingCount(int? count, bool shouldValidate) {
    state = state.copyWith(ratings: count);
    if (shouldValidate) {
      _validate();
    } else if (state.ratings != 0) {
      _enableButton();
    }
  }
}

@Riverpod(keepAlive: true)
class PartnerRecommendationAndRatingData
    extends _$PartnerRecommendationAndRatingData {
  @override
  PartnerSubmitRatingEntity build() {
    return const PartnerSubmitRatingEntity();
  }

  void clearState() {
    state = const PartnerSubmitRatingEntity();
  }

  void _validate() {
    if (state.bookingId == null ||
        state.ratings == null ||
        state.ratings == 0 ||
        state.sessionsRecommended == null) {
      _disableButton();
      return;
    } else {
      for (int i = 0; i < state.memberFeedbackDetails.length; i++) {
        final memberDetails = state.memberFeedbackDetails[i];
        if ((memberDetails.isMandatory ?? false) &&
            (memberDetails.value == null ||
                memberDetails.value.toString().isEmpty)) {
          _disableButton();
          return;
        } else {
          _enableButton();
        }
      }
    }
  }

  void _enableButton() {
    state = state.copyWith(isButtonEnabled: true);
  }

  void _disableButton() {
    state = state.copyWith(isButtonEnabled: false);
  }

  void setQuestionDetails(List<TruepalFeedbackDetail> details) {
    state = state.copyWith(memberFeedbackDetails: details);
    _validate();
  }

  void updateQuestionAnswer(TruepalFeedbackDetail details,
      {bool shouldValidate = true}) {
    List<TruepalFeedbackDetail> detailList = [...state.memberFeedbackDetails];

    final alreadyAddedIndex =
        detailList.indexWhere((data) => data.question == details.question);

    if (alreadyAddedIndex != -1) {
      detailList[alreadyAddedIndex] = details;
    } else {
      detailList.add(details);
    }
    state = state.copyWith(memberFeedbackDetails: detailList);
    if (shouldValidate) {
      _validate();
    } else if (state.ratings != 0) {
      _enableButton();
    }
  }

  void setBookingId(int? bId) {
    state = state.copyWith(bookingId: bId);
    _validate();
  }

  void setRatingCount(int? count, bool shouldValidate) {
    state = state.copyWith(ratings: count);
    if (shouldValidate) {
      _validate();
    } else if (state.ratings != 0) {
      _enableButton();
    }
  }

  void setRecommendedServiceId(int? id) {
    state = state.copyWith(recommendedServiceId: id);
    _validate();
  }

  void setSessionsRecommended(int? value) {
    state = state.copyWith(sessionsRecommended: value);
    _validate();
  }
}
