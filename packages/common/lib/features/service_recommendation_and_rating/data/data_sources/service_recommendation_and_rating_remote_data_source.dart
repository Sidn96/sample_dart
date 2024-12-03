import 'dart:convert';

import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/providers/connectivity_checker.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/service_recommendation_and_rating/domain/entities/member_angel_submit_rating_entity.dart';

part 'service_recommendation_and_rating_remote_data_source.g.dart';

@riverpod
ServiceRecommendationAndRatingRemoteDataSource
    serviceRecommendationAndRatingRemoteDataSource(
        ServiceRecommendationAndRatingRemoteDataSourceRef ref) {
  return ServiceRecommendationAndRatingRemoteDataSource(
    api: ref.watch(apiFacadeProvider),
    connectivityStatus: ref.watch(connectivityCheckerNotifierProvider),
  );
}

class ServiceRecommendationAndRatingRemoteDataSource {
  final ApiFacade api;
  final ConnectivityStatus connectivityStatus;

  final String submitMemberRating = "/tp/member/booking/ratings";
  final String submitPartnerRating = "/tp/pal/booking-ratings";
  final String ignoreRatingByMember = "/tp/member/booking/ratings/ignore/";
  final String ignoreRatingByPartner = "/tp/pal/booking/ratings/ignore/";

  ServiceRecommendationAndRatingRemoteDataSource(
      {required this.api, required this.connectivityStatus});

  Future<bool> submitRatingRecommendation(
      {required PartnerSubmitRatingEntity ratingEntity}) async {
    try {
      final requestData = ratingEntity.toJson();
      requestData.removeWhere(
          (key, value) => value == null || key == "isButtonEnabled");

      final response = await api.postData(
          path: submitPartnerRating,
          data: jsonEncode(requestData),
          sendToken: true);

      if (response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendUserRatingRecommendation(
      {required MemberAngelSubmitRatingEntity ratingEntity}) async {
    try {
      final requestData = ratingEntity.toJson();
      requestData.removeWhere(
          (key, value) => value == null || key == "isButtonEnabled");

      final response = await api.postData(
          path: submitMemberRating,
          data: jsonEncode(requestData),
          sendToken: true);

      if (response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendIgnoreRatingByMember({required int bookingId}) async {
    try {
      final response = await api.postData(
          path: "$ignoreRatingByMember$bookingId", sendToken: true);

      if (response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendIgnoreRatingByPartner({required int bookingId}) async {
    try {
      final response = await api.postData(
          path: "$ignoreRatingByPartner$bookingId", sendToken: true);

      if (response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
