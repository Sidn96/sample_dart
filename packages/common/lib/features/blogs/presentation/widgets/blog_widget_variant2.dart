import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/utils/date_utils/date_utils.dart';
import 'package:common/core/presentation/utils/input_formatter/input_formatter.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/env/env.dart';
import 'package:common/features/blogs/domain/blog_item_model.dart';
import 'package:common/features/blogs/presentation/providers/blog_cards_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class BlogWidgetVariant2 extends ConsumerWidget {
  final BlogItemData blogItemData;
  final VoidCallback onTap;

  const BlogWidgetVariant2(
      {super.key, required this.blogItemData, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 269.0,
        child: GestureDetector(
          onTap: () {
            onTap.call();
          },
          child: Stack(
            children: [
              Hero(
                tag: blogItemData.id ?? "",
                child: Container(
                  height: 269.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: ColorUtilsV2.hex_1E3A8A.withOpacity(0.2),
                        blurRadius: 8.0,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child:  CachedNetworkImage(
                      imageUrl: blogItemData.imageUrl ?? "",
                      height: 140.0,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      placeholder: (context, url) => Image.asset('assets/images/placeholder.png', fit: BoxFit.fill),
                      errorWidget: (context, url, error) => Image.asset('assets/images/placeholder.png',fit: BoxFit.fill),
                    )
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    colors: [
                      ColorUtilsV2.hex_35354D.withOpacity(0.0),
                      ColorUtilsV2.hex_35354D.withOpacity(0.5),
                      ColorUtilsV2.hex_1F1F2E.withOpacity(0.9),
                      ColorUtilsV2.hex_1F1F2E,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.2),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      AppTextV2(
                        data: blogItemData.title ?? "",
                        textAlign: TextAlign.left,
                        fontSize: 18.0,
                        height: 24.59 / 18.0,
                        fontWeight: FontWeight.w500,
                        fontColor: ColorUtilsV2.hex_F9FAFB,
                      ),
                      const SizedBox(height: 15.0),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          AppTextV2(
                            data: AppDateUtils().getFormattedDate(blogItemData.publishDate ?? ""),
                            fontSize: 12.0,
                            fontColor: ColorUtilsV2.hex_E5E7EB,
                            fontWeight: FontWeight.w500,
                            height: 16.39 / 12.0,
                          ),
                          const SizedBox(width: 8.0),
                          const CircleAvatar(
                            radius: 2.5,
                            backgroundColor: ColorUtilsV2.hex_E5E7EB,
                          ),
                          const SizedBox(width: 8.0),
                          AppTextV2(
                            data: "${blogItemData.readingTime ?? "0"} min read",
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            height: 16.39 / 12.0,
                            fontColor: ColorUtilsV2.hex_E5E7EB,
                          ),
                          const SizedBox(width: 8.0),
                          for (int i = 0; i < blogItemData.categories!.length; i++)
                            Builder(builder: (context) {
                              final item = blogItemData.categories![i];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CircleAvatar(
                                    radius: 2.5,
                                    backgroundColor: ColorUtilsV2.hex_E5E7EB,
                                  ),
                                  const SizedBox(width: 8.0),
                                  AppTextV2(
                                    data: item.categoryName ?? "",
                                    fontSize: 12.0,
                                    height: 16.39 / 12.0,
                                    fontWeight: FontWeight.w500,
                                    fontColor: ColorUtilsV2.hex_BBF7D0,
                                  ),
                                  const SizedBox(width: 8.0),
                                ],
                              );
                            }),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Consumer(builder: (context, ref, _) {
                        ref.watch(blogToggleStateProvider);
                        bool isBlogLiked = ref.read(blogCardsStateNotifierProvider.notifier).checkIfBlogItemIsLiked(blogItemData.id ?? "");
                        bool isBlogViewed = ref.read(blogCardsStateNotifierProvider.notifier).checkIfBlogItemIsViewed(blogItemData.id ?? "");
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AssetUtils.icView, height: 12.0),
                            const SizedBox(width: 8.0),
                            AppTextV2(
                                data: isBlogViewed
                                    ? ((blogItemData.views ?? 0) + 1).toString()
                                    : (blogItemData.views).toString(),
                                fontSize: 14.0,
                                fontColor: Colors.white),
                            const SizedBox(width: 15.0),
                            SvgPicture.asset(isBlogLiked ? AssetUtils.icLikeActive : AssetUtils.icLike),
                            const SizedBox(width: 8.0),
                            AppTextV2(
                                data: isBlogLiked
                                    ? ((blogItemData.likes ?? 0) + 1).toString()
                                    : blogItemData.likes.toString() ?? "0",
                                fontSize: 14.0,
                                fontColor: Colors.white),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Share.share("${blogItemData.title}.\n${Env.contentfulBaseUrlFromEnv}blog/${blogItemData.categories?.isNotEmpty==true? (blogItemData.categories?[0].slug):""}/${blogItemData.slug}");
                              },
                              child: CircleAvatar(
                                backgroundColor: ColorUtilsV2.hex_E1E1FE,
                                radius: 18.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: SvgPicture.asset(AssetUtils.icShareBlue),
                                ),
                              ),
                            )
                          ],
                        );
                      })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
