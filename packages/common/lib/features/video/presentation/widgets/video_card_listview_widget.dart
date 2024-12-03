import 'package:carousel_slider/carousel_slider.dart';
import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/providers/small_state_providers.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/custom_loading_widget.dart';
import 'package:common/features/blogs/presentation/providers/mo_engage_page_events.dart';
import 'package:common/features/video/domain/video_list_model.dart';
import 'package:common/features/video/presentation/providers/video_card_listview_state_provider.dart';
import 'package:common/features/video/presentation/widgets/video_card_item.dart';
import 'package:common/features/video/presentation/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//pass the url for blogs endpoint
class VideoCardsListViewWidget extends HookConsumerWidget
    with MoEngagePageEvents {
  final String url;
  final String? category;
  final double bottomPad;

  const VideoCardsListViewWidget({
    super.key,
    required this.url,
    this.category,
    this.bottomPad = 80.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosProviderState =
        ref.watch(videoCardsListViewStateNotifierProvider);

    useEffect(() {
      print("useEffect called");
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref
            .read(videoCardsListViewStateNotifierProvider.notifier)
            .callAndSetResponse(url, category: category);
        ref.read(videoCardsIndexStateNotifier.notifier).state = 0;
      });
      return null;
    }, []);

    return videosProviderState.when(
      data: (videosResponseData) {
        List<VideoItemData> videoItems = videosResponseData.data?.data ?? [];
        return Container(
          margin: EdgeInsets.only(bottom: bottomPad),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                ColorUtilsV2.hex_FFF8EC,
              ],
            ),
          ),
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              // AppTextV2(
              //     data: videosResponseData.posts?[0].heading ?? "",
              //     fontSize: 26.0,
              //     fontColor: ColorUtilsV2.hex_35354D),
              // const SizedBox(height: 20.0),
              SizedBox(
                child: CarouselSlider.builder(
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction:
                          (260.0 + 20.0) / MediaQuery.of(context).size.width,
                      height: 210.0,
                      padEnds: false,
                      aspectRatio: 16 / 9,
                      onPageChanged: (index, reason) {
                        ref.read(videoCardsIndexStateNotifier.notifier).state =
                            index;
                      },
                    ),
                    itemBuilder: (context, index, _) {
                      if (index == videoItems.length) return const SizedBox();
                      return Padding(
                        padding:
                            EdgeInsets.only(left: index == 0 ? 20.0 : 15.0),
                        child: VideoCardItemWidget(
                          onTap: () {
                            /*   if (kIsWeb) {
                              context.push("/video-player",
                                  extra: videoItems[index].videoUrl ?? "");
                            } else {*/
                            showDialog(
                              useRootNavigator: false,
                              barrierDismissible: true,
                              barrierColor: Colors.black.withOpacity(0.9),
                              context: context,
                              builder: (context) {
                                return VideoPlayerWidget(
                                  videoUrl: videoItems[index].videoUrl ?? "",
                                );
                              },
                            );
                            // }
                          },
                          videoItem: videoItems[index],
                        ),
                      );
                    },
                    itemCount: videoItems.length + 1),
              ),
              const SizedBox(height: 20.0),
              Consumer(builder: (context, ref, _) {
                int activeCardIndex = ref.watch(videoCardsIndexStateNotifier);
                return AnimatedSmoothIndicator(
                  activeIndex: activeCardIndex,
                  count: videoItems.length,
                  effect: const ExpandingDotsEffect(
                      dotHeight: 4,
                      dotWidth: 4,
                      expansionFactor: 4,
                      radius: 5.0,
                      spacing: 5.0,
                      activeDotColor: ColorUtilsV2.hex_35354D,
                      dotColor: ColorUtilsV2.hex_9CA3AF),
                );
              }),
              const SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  exploreMoreVideoEventCall(category ?? '-');
                  MoEngageService().trackEvent(
                      eventName: MoEngageEventsConsts
                          .eventsNames.truefinhomepageexploremorectaclicked,
                      product: ProductEvent.truefin,
                      properties: {"selection": "videos", "source": category});
                  context
                      .go("/blog-videos-listing", extra: {"showVideos": true});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 13.5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorUtilsV2.hex_4E52F8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextV2(
                        data: "Explore More",
                        fontSize: 14.0,
                        height: 9.12 / 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: ColorUtilsV2.hex_4E52F8,
                      ),
                      SizedBox(width: 13.0),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: ColorUtilsV2.hex_4E52F8,
                        size: 15.0,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30.0)
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return const SizedBox(); //TODO : check later
      },
      loading: () {
        return const CustomLoadingWidget();
      },
    );
  }

  //resets the mood selection cards and gos to blog details screen
  onVideoCarousalWidgetTap(
      WidgetRef ref, VideoItemData itemData, BuildContext context) {
    ref.read(clearMoodCardsSelectionProvider.notifier).state =
        !ref.read(clearMoodCardsSelectionProvider.notifier).state;
    context.push("/blog-details", extra: itemData);
  }
}
