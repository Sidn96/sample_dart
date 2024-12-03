import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/features/blogs/domain/blog_item_model.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/utils/app_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blog_repo.g.dart';

@riverpod
BlogRepository getBlogRepository(GetBlogRepositoryRef ref) {
  return BlogRepository(apiFacade: ref.read(apiFacadeProvider));
}

class BlogRepository {
  final ApiFacade apiFacade;

  BlogRepository({required this.apiFacade});

  Future<Either<String, BlogPostListResponse>> fetchBlogPostsResponse(
      String url, int limit, int page) async {
    try {
      final result = await apiFacade.getData(
          path: url, queryParameters: {"page": page, "per_page": limit});
      if (result.statusCode == 200) {
        return right(BlogPostListResponse.fromJson(result.data));
      }
      return left(AppErrors.mSomethingWentWrong);
    } catch (e) {
      // return right(BlogPostListResponse.fromJson(jsonResponse));
      if (e is ServerException) return left(e.message);
      return left(e.toString());
    }
  }

  Future<Either<String, BlogItemDetailResponse>> fetchBlogItemDetails(String url) async {
    try {
      final result = await apiFacade.getData(path: url);
      if (result.statusCode == 200) {
        return right(BlogItemDetailResponse.fromJson(result.data));
      }
      return left(AppErrors.mSomethingWentWrong);
    } catch (e) {
      // return right(BlogPostListResponse.fromJson(jsonResponse));
      if (e is ServerException) return left(e.message);
      return left(e.toString());
    }
  }
}
