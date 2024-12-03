import 'package:common/core/infrastructure/api_result.dart';
import 'package:common/core/infrastructure/dtos/faq_response.dart';
import 'package:common/core/infrastructure/repos/faq_v2_repo.dart';
import 'package:common/core/presentation/components_v2/app_expansion_tile_V2.dart';
import 'package:common/core/presentation/components_v2/faq_v2_view_all_screen.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'faq_v2_provider.g.dart';

@riverpod
class FaqV2DataProvider extends _$FaqV2DataProvider {
  List<AppExpansionTileData> cache = [];

  @override
  Future<List<AppExpansionTileData>> build() async {
    return [];
  }

  Future<void> fetchFaq(
      {int limit = 5, int page = 1, String category = "truefin"}) async {
    state = const AsyncValue.loading();
    var response = await ref
        .read(faqV2RepoProvider)
        .getFaq(category: category, limit: limit, page: page);
    if (response is Success) {
      var data = (response.data as FaqResponse).data?.data ?? [];
      var newState = <AppExpansionTileData>[];
      for (var i = 0; i < data.length; i++) {
        newState.add(AppExpansionTileData(
          index: i + 1,
          title: data[i].question ?? "",
          children: data[i].answer ?? "",
          category: category,
        ));
      }
      state = AsyncValue.data(newState);
      cache = [...?state.value];
    } else {
      //Failure of Error Response Received
      state = AsyncValue.error('', StackTrace.current);
      cache = [];
    }
  }
}

@riverpod
class FaqViewAllDataProvider extends _$FaqViewAllDataProvider {
  final PagingController<int, AppExpansionTileData> faqPagingController =
      PagingController(firstPageKey: 1);
  String? selectedCategory = "truefin";

  @override
  Future<List<AppExpansionTileData>> build() async {
    faqPagingController.addPageRequestListener((pageKey) {
      fetchFaq(page: pageKey, category: selectedCategory ?? "");
    });
    return [];
  }

  Future<void> fetchFaq(
      {int limit = 10, int page = 1, String category = "truefin"}) async {
    selectedCategory = category;
    //state = const AsyncValue.loading();
    var response = await ref
        .read(faqV2RepoProvider)
        .getFaq(category: category, limit: limit, page: page);
    if (response is Success) {
      var data = (response.data as FaqResponse).data?.data ?? [];
      var newState = <AppExpansionTileData>[];
      for (var i = 0; i < data.length; i++) {
        newState.add(AppExpansionTileData(
          index: i + 1,
          title: data[i].question ?? "",
          children: data[i].answer ?? "",
          category: "category",
        ));
      }
      final isLastPage = newState.length < limit;

      //incase success
      if (isLastPage) {
        faqPagingController.appendLastPage(newState);
      } else {
        final nextPageKey = page + 1;
        faqPagingController.appendPage(newState, nextPageKey);
      }
      //  state = AsyncValue.data(newState);
    } else {
      //Failure of Error Response Received
      //  state = AsyncValue.error('', StackTrace.current);
    }
  }

  onCategoryChange(String category) {
    MoEngageService().trackEvent(
        eventName:
            MoEngageEventsConsts.horizontalEventsValue.truefinfaqscreenviewed,
        product: ProductEvent.truefin,
        properties: {"tab_selected": category});

    if (selectedCategory == category) return;
    selectedCategory = category;
    selectedIndex.value = -1;
    faqPagingController.itemList?.clear();
    fetchFaq(category: category, page: 1);
    ref.notifyListeners();
  }

  setCategory(String value) {
    print("setCategory called with value=$value");
    selectedCategory = value;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.notifyListeners();
    });
  }
}
