import 'package:common/features/video/domain/video_list_model.dart';
import 'package:common/features/video/infrastructure/video_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_card_listview_state_provider.g.dart';

const double videoItemWidth=260.0;
@riverpod
class VideoCardsListViewStateNotifier extends _$VideoCardsListViewStateNotifier {
  @override
  AsyncValue<VideosListResponse> build() {
    scrollController= ScrollController();
    scrollController.addListener(() {
      final index = (scrollController.offset / videoItemWidth).round(); // Assuming each ListTile is 56 pixels in height
      //print('Currently scrolled to item $index');
          ref.read(videoCardsIndexStateNotifier.notifier).state =
              index;
    });
    ref.onDispose(() {
      print("disposing video scroll controller");
      scrollController.dispose();
    });
    return const AsyncValue.loading();
  }

  late ScrollController scrollController ;

  Future<void> callAndSetResponse(String url, {String? category}) async {
    state = const AsyncValue.loading();
    final videosRepositoryInstance = ref.read(getVideosRepositoryProvider);
    final result = await videosRepositoryInstance.fetchVideosResponse(url,10,1);
    result.fold(
      (l) {
        //incase error
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        //incase success
        state = AsyncValue.data(r);
      },
    );
  }
}

StateProvider<int> videoCardsIndexStateNotifier = StateProvider((ref) => 0);
