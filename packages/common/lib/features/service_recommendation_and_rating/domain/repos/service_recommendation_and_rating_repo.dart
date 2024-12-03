import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/service_recommendation_and_rating/data/data_sources/service_recommendation_and_rating_remote_data_source.dart';
import 'package:common/features/service_recommendation_and_rating/domain/entities/member_angel_submit_rating_entity.dart';

part 'service_recommendation_and_rating_repo.g.dart';

@riverpod
ServiceRecommendationAndRatingRepo serviceRecommendationAndRatingRepo(
    ServiceRecommendationAndRatingRepoRef ref) {
  return ServiceRecommendationAndRatingRepo(
      remoteDataSource:
          ref.watch(serviceRecommendationAndRatingRemoteDataSourceProvider));
}

class ServiceRecommendationAndRatingRepo {
  final ServiceRecommendationAndRatingRemoteDataSource remoteDataSource;

  ServiceRecommendationAndRatingRepo({required this.remoteDataSource});

  Future<bool> sendUserRatingRecommendation(
      {required MemberAngelSubmitRatingEntity ratingEntity}) async {
    return await remoteDataSource.sendUserRatingRecommendation(
        ratingEntity: ratingEntity);
  }

  Future<bool> submitRatingRecommendation(
      {required PartnerSubmitRatingEntity ratingEntity}) async {
    return await remoteDataSource.submitRatingRecommendation(
        ratingEntity: ratingEntity);
  }

  Future<bool> sendIgnoreRatingByMember({required int bookingId}) async {
    return await remoteDataSource.sendIgnoreRatingByMember(
        bookingId: bookingId);
  }

  Future<bool> sendIgnoreRatingByPartner({required int bookingId}) async {
    return await remoteDataSource.sendIgnoreRatingByPartner(
        bookingId: bookingId);
  }
}
