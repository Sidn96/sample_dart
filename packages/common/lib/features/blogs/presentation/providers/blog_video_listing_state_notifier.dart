import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/env/env.dart';
import 'package:common/features/blogs/domain/blog_item_model.dart';
import 'package:common/features/blogs/infrastructure/blog_repo.dart';
import 'package:common/features/video/domain/video_list_model.dart';
import 'package:common/features/video/infrastructure/video_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'blog_video_listing_state_notifier.g.dart';

List<BlogVideoTypeItem> typesList = [
  BlogVideoTypeItem(displayName: "All", keyName: ""),
  BlogVideoTypeItem(keyName: "nps", displayName: "NPS"),
  BlogVideoTypeItem(keyName: "mutual-funds", displayName: "Mutual Fund"),
  // "Mutual Funds"
];

@riverpod
class BlogVideoListingStateNotifier extends _$BlogVideoListingStateNotifier {
  String selectedType = "Blogs";
  late BlogVideoTypeItem selectedItem;
  int limit = 10;
  final PagingController<int, BlogItemData> blogPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, VideoItemData> videoPagingController =
      PagingController(firstPageKey: 1);
  String blogsUrl = "${Env.opsPanelBaseUrlFromEnv}api/blogs";
  String videosUrl = "${Env.opsPanelBaseUrlFromEnv}api/videos";

  @override
  dynamic build() {
    selectedType = "Blogs";
    selectedItem = typesList.first;
    blogPagingController.addPageRequestListener((pageKey) {
      fetchBlogsData(blogsUrl, pageKey);
    });
    //TODO: check url for video below
    videoPagingController.addPageRequestListener((pageKey) {
      fetchVideosData(videosUrl, pageKey);
    });
    return null;
  }

  Future<void> fetchBlogsData(String url, int page) async {
    // loading = true;
    // updateState();
    // state = const AsyncValue.loading();
    final blogsRepositoryInstance = ref.read(getBlogRepositoryProvider);
    final result = await blogsRepositoryInstance.fetchBlogPostsResponse(
        url + "/" + (selectedItem.keyName), limit, page);
    result.fold(
      (l) {
        //incase error
        // state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final isLastPage = (r.data?.data?.length ?? 0) < limit;

        //incase success
        if (isLastPage) {
          blogPagingController.appendLastPage(r.data?.data ?? []);
        } else {
          final nextPageKey = page + 1;
          blogPagingController.appendPage(r.data?.data ?? [], nextPageKey);
        }
        //updateState();
        // state = AsyncValue.data(r);
      },
    );
    // loading = false;
    // updateState();
  }

  Future<void> fetchVideosData(String url, int page) async {
    // state = const AsyncValue.loading();
    final videosRepositoryInstance = ref.read(getVideosRepositoryProvider);
    final result = await videosRepositoryInstance.fetchVideosResponse(
        url + "/" + (selectedItem.keyName), limit, page);
    result.fold(
      (l) {
        //incase error
        // state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final isLastPage = (r.data?.data?.length ?? 0) < limit;
        print("isLastPage = $isLastPage");
        //incase success
        if (isLastPage) {
          videoPagingController.appendLastPage(r.data?.data ?? []);
        } else {
          final nextPageKey = page + 1;
          videoPagingController.appendPage(r.data?.data ?? [], nextPageKey);
        }
      },
    );
  }

  updateState() {
    ref.notifyListeners();
  }

  onItemChange(BlogVideoTypeItem item) {
    if (selectedItem == item) return;
    selectedItem = item;
    updateState();
    if (selectedType == "Blogs") {
      blogPagingController.itemList?.clear();
      fetchBlogsData(blogsUrl, 1);
    } else {
      videoPagingController.itemList?.clear();
      fetchVideosData(videosUrl, 1);
    }
  }

  onTypeChange(String type) {
    selectedType = type;
    updateState();
  }
}
