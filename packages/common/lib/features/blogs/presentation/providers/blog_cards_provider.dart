import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/blogs/domain/blog_item_model.dart';
import 'package:common/features/blogs/infrastructure/blog_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'blog_cards_provider.g.dart';

StateProvider<bool> blogToggleStateProvider = StateProvider((ref) => false);

@riverpod
class BlogCardsStateNotifier extends _$BlogCardsStateNotifier {
  @override
  AsyncValue<BlogPostListResponse> build() {
    //clearBlogsPrefs();
    loadCacheDataForLikesAndViews();
    return const AsyncValue.loading();
  }

  List<String> likedBlogIdsInCache = [];
  List<String> viewedBlogIdsInCache = [];

  Future<void> callAndSetResponse(String url, {String? category}) async {
    state = const AsyncValue.loading();
    final blogsRepositoryInstance = ref.read(getBlogRepositoryProvider);
    final result = await blogsRepositoryInstance.fetchBlogPostsResponse(url,10,1);
    result.fold(
      (l) {
        //incase error
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        // if (category != null) {
        //   (r.data?.data
        //       ?.removeWhere((element) => element.categories?[0] != category));
        // }
        //incase success
        state = AsyncValue.data(r);
      },
    );
  }

  bool checkIfBlogItemIsLiked(String blogId) {
    return likedBlogIdsInCache.contains(blogId) == true;
  }

  bool checkIfBlogItemIsViewed(String blogId) {
    return viewedBlogIdsInCache.contains(blogId) == true;
  }

  //add blog item
  Future<void> addBlogItemToLikedList(String blogId) async {
    final prefs = await SharedPreferences.getInstance();
    if (likedBlogIdsInCache.contains(blogId) == true) {
      //already contains , return
      return;
    } else {
      likedBlogIdsInCache.add(blogId);
      await prefs.setStringList(
          AppConstants.likedBlogsStorageKey, likedBlogIdsInCache);
      return;
    }
  }

  //add blog item
  Future<void> addBlogItemToViewedList(String blogId) async {
    final prefs = await SharedPreferences.getInstance();
    if (viewedBlogIdsInCache.contains(blogId) == true) {
      //already contains , return
      return;
    } else {
      viewedBlogIdsInCache.add(blogId);
      await prefs.setStringList(
          AppConstants.viewedBlogsStorageKey, viewedBlogIdsInCache);
      return;
    }
  }

  //remove blog item
  Future<void> removeBlogItem(String blogId) async {
    final prefs = await SharedPreferences.getInstance();
    if (likedBlogIdsInCache.contains(blogId) == true) {
      //already contains , return
      likedBlogIdsInCache.remove(blogId);
      await prefs.setStringList(
          AppConstants.likedBlogsStorageKey, likedBlogIdsInCache);
      return;
    } else {
      //if not contains return
      return;
    }
  }

  Future<void> onLikeIconClick(String blogId) async {
    if (checkIfBlogItemIsLiked(blogId) == true) {
      //is liked , remove
      await removeBlogItem(blogId);
    } else {
      await addBlogItemToLikedList(blogId);
    }
    ref.read(blogToggleStateProvider.notifier).state =
        !ref.read(blogToggleStateProvider.notifier).state;
    return;
  }

  loadCacheDataForLikesAndViews() async {
    final prefs = await SharedPreferences.getInstance();
    likedBlogIdsInCache =
        prefs.getStringList(AppConstants.likedBlogsStorageKey) ?? <String>[];
    viewedBlogIdsInCache =
        prefs.getStringList(AppConstants.viewedBlogsStorageKey) ?? <String>[];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.notifyListeners();
    });
  }

  checkAndIncreaseViewCountForBlogItem(String blogId) {
    if (checkIfBlogItemIsViewed(blogId) == false) {
      addBlogItemToViewedList(blogId);
      ref.read(blogToggleStateProvider.notifier).state =
          !ref.read(blogToggleStateProvider.notifier).state;
    }
  }

  clearBlogsPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(AppConstants.likedBlogsStorageKey);
    prefs.remove(AppConstants.viewedBlogsStorageKey);
  }
}

StateProvider<int> blogCardsIndexStateNotifier = StateProvider((ref) => 0);
