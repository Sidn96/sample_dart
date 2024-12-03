import 'package:common/core/presentation/components_v2/app_chip_widget.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/utils/date_utils/date_utils.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:common/env/env.dart';
import 'package:common/features/blogs/domain/blog_item_model.dart';
import 'package:common/features/blogs/presentation/providers/blog_cards_provider.dart';
import 'package:common/features/blogs/presentation/providers/blog_details_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/presentation/components_v2/app_bar_v2.dart';
import '../../../../../core/presentation/components_v2/color_utils_v2.dart';
import '../../../../../core/presentation/styles/app_assets.dart';

class BlogDetailViewWidget extends HookConsumerWidget {
  final BlogItemData blogItem;

  const BlogDetailViewWidget({super.key, required this.blogItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref
            .read(blogDetailViewStateNotifierProvider.notifier)
            .fetchBlogDetails(blogItem, context);
      });
      return null;
    }, []);
    return LoaderOverlay(
      overlayColor: Colors.transparent,
      overlayWidgetBuilder: (_) => const CommonTrueFinLoaderWithBlur(),
      useDefaultLoading: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarV2(
            toolbarHeight: kToolbarHeight,
            actionWidgets: const [SizedBox()],
            backgroundColor: ColorUtilsV2.hex_F5F5FF,
            title: blogItem.categories?[0].categoryName ?? "",
            //TODO: check what to show here
            centerTitle: true,
            onLeadingTap: null),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: blogItem.id ?? "",
                child: SizedBox(
                  height: 269.0,
                  width: MediaQuery.sizeOf(context).width,
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(blogItem.imageUrl ?? ""),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorUtilsV2.hex_35354D.withOpacity(0.0),
                            ColorUtilsV2.hex_35354D.withOpacity(0.5),
                            ColorUtilsV2.hex_1F1F2E.withOpacity(0.9),
                            ColorUtilsV2.hex_1F1F2E
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.0, 1.2),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            AppTextV2(
                              data: blogItem.title ?? "",
                              textAlign: TextAlign.left,
                              fontSize: 28.0,
                              height: 38.25 / 28.0,
                              fontWeight: FontWeight.w600,
                              fontColor: ColorUtilsV2.hex_F9FAFB,
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 16.0),
                  //chips
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: MediaQuery.sizeOf(context).width,
                    child: Wrap(
                      runSpacing: 12.0,
                      spacing: 12.0,
                      children: [
                        for (int i = 0; i < blogItem.categories!.length; i++)
                          Builder(builder: (context) {
                            final item = blogItem.categories![i];
                            return AppChipWidgetV2(
                                borderRadius: 20.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                textForDisplay: item.categoryName ?? "",
                                textColor: ColorUtilsV2.hex_35354D,
                                chipColor: ColorUtilsV2.hex_F3F4F6,
                                textHeight: 16.39 / 12.0,
                                textSize: 12.0);
                          }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    AppTextV2(
                                      data: AppDateUtils().getFormattedDate(
                                          blogItem.publishDate ?? ""),
                                      fontSize: 12.0,
                                      fontColor: ColorUtilsV2.hex_5D5D70,
                                      fontWeight: FontWeight.w500,
                                      height: 16.39 / 12.0,
                                    ),
                                    const SizedBox(width: 8.0),
                                    const CircleAvatar(
                                      radius: 2.5,
                                      backgroundColor: ColorUtilsV2.hex_5D5D70,
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    AppTextV2(
                                      data:
                                          "${blogItem.readingTime ?? "0"} min read",
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      height: 16.39 / 12.0,
                                      fontColor: ColorUtilsV2.hex_5D5D70,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12.0),
                                Consumer(builder: (context, ref, child) {
                                  ref.watch(blogToggleStateProvider);
                                  bool isBlogLiked = ref
                                      .read(blogCardsStateNotifierProvider
                                          .notifier)
                                      .checkIfBlogItemIsLiked(
                                          blogItem.id ?? "");
                                  bool isBlogViewed = ref
                                      .read(blogCardsStateNotifierProvider
                                          .notifier)
                                      .checkIfBlogItemIsViewed(
                                          blogItem.id ?? "");
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(AssetUtils.icView,
                                          height: 12.0,
                                          color: ColorUtilsV2.hex_35354D),
                                      const SizedBox(width: 8.0),
                                      AppTextV2(
                                          data: isBlogViewed
                                              ? ((blogItem.views ?? 0) + 1)
                                                  .toString()
                                              : (blogItem.views).toString(),
                                          fontSize: 14.0,
                                          fontColor: ColorUtilsV2.hex_35354D),
                                      const SizedBox(width: 15.0),
                                      InkWell(
                                        onTap: () async {
                                          ref
                                              .read(
                                                  blogCardsStateNotifierProvider
                                                      .notifier)
                                              .onLikeIconClick(
                                                  blogItem.id ?? "");
                                        },
                                        child: SvgPicture.asset(
                                            isBlogLiked
                                                ? AssetUtils.icLikeActive
                                                : AssetUtils.icLike,
                                            color: isBlogLiked
                                                ? null
                                                : ColorUtilsV2.hex_35354D),
                                      ),
                                      const SizedBox(width: 8.0),
                                      AppTextV2(
                                          data: isBlogLiked
                                              ? ((blogItem.likes ?? 0) + 1)
                                                  .toString()
                                              : (blogItem.likes).toString(),
                                          fontSize: 14.0,
                                          fontColor: ColorUtilsV2.hex_35354D),
                                      const Spacer(),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Share.share(
                                  "${blogItem.title}.${Env.contentfulBaseUrlFromEnv}blogs/${blogItem.categories?.isNotEmpty == true ? (blogItem.categories?[0].slug) : ""}/${blogItem.slug}");
                            },
                            child: CircleAvatar(
                              backgroundColor: ColorUtilsV2.hex_4E52F8,
                              radius: 18.0,
                              child: Center(
                                child:
                                    SvgPicture.asset(AssetUtils.icShareWhite),
                              ),
                            ),
                          )
                        ]),
                  ),
                  //date

                  //icons

                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: double.infinity,
                    color: ColorUtilsV2.hex_E5E7EB,
                    height: 1.0,
                  ),
                  const SizedBox(height: 8.0),
                  //blog content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Consumer(builder: (context, ref, child) {
                      double contentHeight =
                          ref.watch(blogDetailViewStateNotifierProvider);
                      return Stack(
                        children: [
                          SizedBox(
                            height: contentHeight,
                            width: MediaQuery.sizeOf(context).width,
                            child: InAppWebView(
                              shouldOverrideUrlLoading:
                                  (controller, navigationAction) async {
                                var uri = navigationAction.request.url;
                                debugPrint("the uri = $uri");
                                if (uri != null) {
                                  if (await canLaunchUrl(uri)) {
                                    print("canLaunchUrl true");
                                    launchUrl(uri);
                                    return NavigationActionPolicy.CANCEL;
                                  }
                                }

                                return NavigationActionPolicy.ALLOW;
                              },
                              initialOptions: InAppWebViewGroupOptions(
                                  android: AndroidInAppWebViewOptions(
                                      useHybridComposition: true),
                                  crossPlatform: InAppWebViewOptions(
                                      transparentBackground: true,
                                      useShouldOverrideUrlLoading: true)),
                              /*  initialSettings: InAppWebViewSettings(
                                forceDark: ForceDark.OFF,
                                transparentBackground: true
                              ), */
                              onWebViewCreated: (controller) {
                                ref
                                    .read(blogDetailViewStateNotifierProvider
                                        .notifier)
                                    .inAppWebViewController = controller;
                                //
                                // ref
                                //     .read(blogDetailViewStateNotifierProvider.notifier)
                                //     .setContent(blogItem.content ?? "");
                              },
                              onLoadStop: (controller, url) async {
                                controller
                                    .evaluateJavascript(
                                        source: "document.body.scrollHeight;")
                                    .then((value) {
                                  ref
                                      .read(blogDetailViewStateNotifierProvider
                                          .notifier)
                                      .setContentHeight(
                                          value.toDouble() + 20.0);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
