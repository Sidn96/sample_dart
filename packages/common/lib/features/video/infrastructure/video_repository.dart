
import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/utils/app_errors.dart';
import 'package:common/features/video/domain/video_list_model.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_repository.g.dart';

@riverpod
VideosRepository getVideosRepository(GetVideosRepositoryRef ref) {
  return VideosRepository(apiFacade: ref.read(apiFacadeProvider));
}

class VideosRepository {
  final ApiFacade apiFacade;

  VideosRepository({required this.apiFacade});

  Future<Either<String, VideosListResponse>> fetchVideosResponse(String url, int limit , int page) async {
    try {

      final result = await apiFacade.getData(path: url,queryParameters: {"page":page,"per_page":limit});
      if (result.statusCode == 200) {
        return right(VideosListResponse.fromJson(result.data));
      }
      return left(AppErrors.mSomethingWentWrong);
    } catch (e) {
      if (e is ServerException) return left(e.message);
      return left(e.toString());
    }
  }
}