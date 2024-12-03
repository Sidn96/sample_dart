import 'package:common/core/presentation/common_widgets/hide_bottom_nav_on_scroll_wrapper.dart';
import 'package:common/core/presentation/common_widgets/truefin_appbar.dart';
import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:common/features/blogs/domain/blog_item_model.dart';
import 'package:common/features/blogs/presentation/providers/blog_cards_provider.dart';
import 'package:common/features/blogs/presentation/providers/blog_video_listing_state_notifier.dart';
import 'package:common/features/blogs/presentation/widgets/blog_widget_variant1.dart';
import 'package:common/features/blogs/presentation/widgets/blog_widget_variant2.dart';
import 'package:common/features/video/domain/video_list_model.dart';
import 'package:common/features/video/presentation/widgets/video_card_item.dart';
import 'package:common/features/video/presentation/widgets/video_player_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BlogsListViewWidget extends ConsumerWidget {
  const BlogsListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(blogVideoListingStateNotifierProvider);
    final notifier = ref.read(blogVideoListingStateNotifierProvider.notifier);
    return PagedListView.separated(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      //physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 20.0);
      },
      pagingController: notifier.blogPagingController,
      builderDelegate: PagedChildBuilderDelegate<BlogItemData>(
        firstPageProgressIndicatorBuilder: (context) {
          return const CommonTrueFinLoader();
        },
        noItemsFoundIndicatorBuilder: (context) {
          return const Center(
              child: AppTextV2(data: "No Data Found", fontSize: 12.0));
        },
        animateTransitions: true,
        itemBuilder: (context, blogItem, index) {
          // print("index got is $index");
          if (index % 2 == 1) {
            return BlogWidgetVariant2(
              blogItemData: blogItem,
              onTap: () {
                ref
                    .read(blogCardsStateNotifierProvider.notifier)
                    .addBlogItemToViewedList(blogItem.id ?? "");
                context.pushNamed("/blog-details", extra: blogItem);
              },
            );
          } else {
            return BlogWidgetVariant1(
                onTap: () {
                  ref
                      .read(blogCardsStateNotifierProvider.notifier)
                      .addBlogItemToViewedList(blogItem.id ?? "");
                  context.pushNamed("/blog-details", extra: blogItem);
                },
                blogItemData: blogItem);
          }
        },
      ),
    );
  }
}

class BlogVideosListingAppView extends HookConsumerWidget {
  final Map<String, dynamic>? params;

  const BlogVideosListingAppView({super.key, this.params});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(blogVideoListingStateNotifierProvider.notifier);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (params?['showVideos'] == true) {
          ref
              .read(blogVideoListingStateNotifierProvider.notifier)
              .onTypeChange("Videos");
        } else {
          if (notifier.selectedType == "Videos") {
            ref
                .read(blogVideoListingStateNotifierProvider.notifier)
                .onTypeChange("Blogs");
          }
        }
      });
      return null;
    }, [params]);

    useEffect(() {
       MoEngageService().trackEvent(eventName: MoEngageEventsConsts.horizontalEventsValue.truefincontenthomescreenviewed, 
        product: ProductEvent.truefin, properties: {"source": (notifier.selectedType == "Videos") ? "Videos" :"Blogs" });
      return null;
     },[notifier.selectedType]);

    ref.watch(blogVideoListingStateNotifierProvider);
    return Scaffold(
        backgroundColor: ColorUtilsV2.hex_FFFFFF,
        // appBar: const CommonTrueFinSliverAppBar(
        //     backGroundColor: ColorUtilsV2.hex_FFFFFF),
        // appBar: AppBarV2(
        //   toolbarHeight: kToolbarHeight,
        //   actionWidgets: const [SizedBox()],
        //   backgroundColor: ColorUtilsV2.hex_F5F5FF,
        //   title: notifier.selectedType,
        //   centerTitle: true,
        //   onLeadingTap: null,
        // ),
        body: SafeArea(
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const CommonTrueFinSliverAppBar(
                  backGroundColor: ColorUtilsV2.hex_FFFFFF)
            ],
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 61.0,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            padding: const EdgeInsets.only(left: 20.0),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Center(
                                child: InkWell(
                                  onTap: () =>
                                      notifier.onItemChange(typesList[index]),
                                  child: AppChipWidgetV2(
                                      borderRadius: 20.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10.0),
                                      textForDisplay:
                                          typesList[index].displayName,
                                      textColor: ColorUtilsV2.hex_35354D,
                                      chipColor: notifier.selectedItem ==
                                              typesList[index]
                                          ? ColorUtilsV2.hex_86EFAC
                                          : ColorUtilsV2.hex_E1E1FE,
                                      textHeight: 19.12 / 14.0,
                                      textSize: 14.0),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 10.0);
                            },
                            itemCount: typesList.length),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                            width: 114.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                left: BorderSide(
                                  color: ColorUtilsV2.hex_D9D9D9,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                value: notifier.selectedType,
                                isExpanded: true,
                                dropdownStyleData: DropdownStyleData(
                                    offset: const Offset(0, -10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                                onChanged: (value) {
                                  notifier.onTypeChange(value ?? "");
                                },
                                customButton: Center(
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 21.0),
                                      AppTextV2(
                                        data: notifier.selectedType ?? "",
                                        fontSize: 14.0,
                                        fontColor: ColorUtilsV2.hex_35354D,
                                      ),
                                      const SizedBox(width: 6.0),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                                items: [
                                  DropdownMenuItem(
                                      value: "Blogs",
                                      child: AppTextV2(
                                        data: "Blogs",
                                        fontSize: 12.0,
                                        fontWeight:
                                            notifier.selectedType == "Blogs"
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                      )),
                                  DropdownMenuItem(
                                    value: "Videos",
                                    child: AppTextV2(
                                      data: "Videos",
                                      fontSize: 12.0,
                                      fontWeight:
                                          notifier.selectedType == "Videos"
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1.0,
                  color: ColorUtilsV2.hex_E5E7EB,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: [
                          const AppTextV2(
                              data: "Latest",
                              fontSize: 26.0,
                              fontWeight: FontWeight.w400,
                              height: 35.52 / 26.0),
                          const SizedBox(width: 8.0),
                          AppTextV2(
                              fontWeight: FontWeight.w600,
                              height: 35.52 / 26.0,
                              data: notifier.selectedType == "Blogs"
                                  ? "Articles"
                                  : "Videos",
                              fontSize: 26.0)
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                    child: AutomaticHideBottomNavOnScrollWrapper(
                  child: notifier.selectedType == "Blogs"
                      ? const BlogsListViewWidget()
                      : const VideosListViewWidget(),
                )),
              ],
            ),
          ),
        ));
  }
}

class VideosListViewWidget extends ConsumerWidget {
  const VideosListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(blogVideoListingStateNotifierProvider);
    final notifier = ref.read(blogVideoListingStateNotifierProvider.notifier);
    return PagedListView<int, VideoItemData>.separated(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      //physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 20.0);
      },
      pagingController: notifier.videoPagingController,
      builderDelegate: PagedChildBuilderDelegate<VideoItemData>(
        firstPageProgressIndicatorBuilder: (context) {
          return const CommonTrueFinLoader();
        },
        noItemsFoundIndicatorBuilder: (context) {
          return const Center(
              child: AppTextV2(data: "No Data Found", fontSize: 12.0));
        },
        animateTransitions: true,
        itemBuilder: (context, videoItem, index) {
          return VideoCardItemWidget2(
            onTap: () {
              showDialog(
                useRootNavigator: false,
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.9),
                context: context,
                builder: (context) {
                  return VideoPlayerWidget(
                    videoUrl: videoItem.videoUrl ?? "",
                  );
                },
              );
              // }
            },
            videoItem: videoItem,
          );
          // print("index got is $index");
        },
      ),
    );
    /* return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          const AppTextV2(
              data: "Latest videos",
              fontSize: 26.0,
              fontWeight: FontWeight.w400,
              height: 35.52 / 26.0),
          const SizedBox(height: 30.0),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: videoDataList.length,
            itemBuilder: (context, index) {
              return VideoCardItemWidget(
                onTap: () {
                  showDialog(
                    useRootNavigator: true,
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.9),
                    context: context,
                    builder: (context) {
                      return VideoPlayerWidget(
                        videoUrl: videoDataList[index].videoUrl ?? "",
                      );
                    },
                  );
                  // }
                },
                videoItem: videoDataList[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20.0);
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );*/
  }
}
