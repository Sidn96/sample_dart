import 'package:carousel_slider/carousel_slider.dart';
import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/providers/small_state_providers.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/custom_loading_widget.dart';
import 'package:common/features/blogs/domain/blog_item_model.dart';
import 'package:common/features/blogs/presentation/providers/blog_cards_provider.dart';
import 'package:common/features/blogs/presentation/providers/mo_engage_page_events.dart';
import 'package:common/features/blogs/presentation/widgets/blog_widget_variant1.dart';
import 'package:common/features/blogs/presentation/widgets/blog_widget_variant2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//pass the url for blogs endpoint
class BlogCardsListViewWidget extends HookConsumerWidget
    with MoEngagePageEvents {
  final String blogsUrl;
  final String? category;
  final String? title;

  const BlogCardsListViewWidget(
      {super.key,
      required this.blogsUrl,
      this.category,
      this.title = "Financial Insights"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blogsProviderState = ref.watch(blogCardsStateNotifierProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref
            .read(blogCardsStateNotifierProvider.notifier)
            .callAndSetResponse(blogsUrl, category: category);
      });
      return null;
    }, []);

    return blogsProviderState.when(
      data: (blogsResponseData) {
        List<BlogItemData> blogItems = blogsResponseData.data?.data ?? [];
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorUtilsV2.hex_E9F0FF.withOpacity(0.0),
                // ColorUtilsV2.hex_E9F0FF.withOpacity(0.3),
                ColorUtilsV2.hex_F3F7FF
              ],
            ),
          ),
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: [
              AppTextV2(
                  data: title ?? "",
                  fontSize: 26.0,
                  fontColor: ColorUtilsV2.hex_35354D),
              const SizedBox(height: 20.0),
              SizedBox(
                child: CarouselSlider.builder(
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: 0.9,
                      height: 299.0,
                      aspectRatio: 16 / 9,
                      onPageChanged: (index, reason) {
                        ref.read(blogCardsIndexStateNotifier.notifier).state =
                            index;
                      },
                    ),
                    itemBuilder: (context, index, _) {
                      return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: (index % 2 == 1)
                              ? BlogWidgetVariant1(
                                  onTap: () {
                                    ref
                                        .read(blogCardsStateNotifierProvider
                                            .notifier)
                                        .addBlogItemToViewedList(
                                            blogItems[index].id ?? "");
                                    onBlogCarousalWidgetTap(
                                        ref, blogItems[index], context);
                                  },
                                  blogItemData: blogItems[index],
                                )
                              : BlogWidgetVariant2(
                                  onTap: () {
                                    ref
                                        .read(blogCardsStateNotifierProvider
                                            .notifier)
                                        .addBlogItemToViewedList(
                                            blogItems[index].id ?? "");
                                    onBlogCarousalWidgetTap(
                                        ref, blogItems[index], context);
                                  },
                                  blogItemData: blogItems[index]));
                    },
                    itemCount: blogItems.length),
              ),
              // const SizedBox(height: 20.0),
              Consumer(builder: (context, ref, _) {
                int activeCardIndex = ref.watch(blogCardsIndexStateNotifier);
                return AnimatedSmoothIndicator(
                  activeIndex: activeCardIndex,
                  count: blogItems.length,
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
                  exploreMoreBlogsEventCall(category ?? '-');
                  MoEngageService().trackEvent(
                      eventName: MoEngageEventsConsts
                          .eventsNames.truefinhomepageexploremorectaclicked,
                      product: ProductEvent.truefin,
                      properties: {"selection": "blogs", "source": category});
                  context
                      .go("/blog-videos-listing", extra: {"showVideos": false});
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
              const SizedBox(height: 30.0),
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
  onBlogCarousalWidgetTap(
      WidgetRef ref, BlogItemData itemData, BuildContext context) {
    ref.read(clearMoodCardsSelectionProvider.notifier).state =
        !ref.read(clearMoodCardsSelectionProvider.notifier).state;
    context.push("/blog-details", extra: itemData);
  }
}
