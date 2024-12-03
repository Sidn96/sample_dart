import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/video/domain/video_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class VideoCardItemWidget extends StatelessWidget {
  final VideoItemData videoItem;
  final VoidCallback onTap;
  final double videoItemWidth;
  final double bottomPadding;
  final double imageHeight;

  const VideoCardItemWidget(
      {super.key,
      required this.videoItem,
      required this.onTap,
      this.videoItemWidth = 260.0,
      this.bottomPadding = 0.0,
      this.imageHeight = 140.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: videoItemWidth,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: ColorUtilsV2.hex_FEF3C7),
              borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    child: CachedNetworkImage(
                      imageUrl: videoItem.thumbnailUrl ?? "",
                      height: imageHeight,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      placeholder: (context, url) => Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.fill),
                      errorWidget: (context, url, error) => Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.fill),
                    )),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      gradient: LinearGradient(
                        colors: [
                          ColorUtilsV2.hex_35354D.withOpacity(0.0),
                          ColorUtilsV2.hex_35354D.withOpacity(0.2),
                          ColorUtilsV2.hex_1F1F2E.withOpacity(0.5),
                          ColorUtilsV2.hex_1F1F2E
                        ],
                        begin: const FractionalOffset(0.0, 1.2),
                        end: const FractionalOffset(0.0, 0.0),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: SvgPicture.asset(AssetUtils.icPlayVideo),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppTextV2(
                      data: videoItem.title ?? "",
                      fontSize: 14.0,
                      maxLines: 2,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.left,
                      height: 19.12 / 14.0,
                      fontColor: ColorUtilsV2.hex_35354D,
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  InkWell(
                      onTap: () {
                        Share.share(
                            "${videoItem.title}. ${videoItem.videoUrl}");
                      },
                      child: CircleAvatar(
                          backgroundColor: ColorUtilsV2.hex_E1E1FE,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: SvgPicture.asset(AssetUtils.icShareBlue),
                          ))))
                ],
              ),
            ),
            SizedBox(height: bottomPadding)
          ],
        ),
      ),
    );
  }
}

class VideoCardItemWidget2 extends StatelessWidget {
  final VideoItemData videoItem;
  final VoidCallback onTap;
  final double videoItemWidth;

  const VideoCardItemWidget2({
    super.key,
    required this.videoItem,
    required this.onTap,
    this.videoItemWidth = 260.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: videoItemWidth,
        decoration: ShapeDecoration(
          color: ColorUtilsV2.hex_F5F5FF,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    child: CachedNetworkImage(
                      imageUrl: videoItem.thumbnailUrl ?? "",
                      height: 210.0,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      placeholder: (context, url) => Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.fill),
                      errorWidget: (context, url, error) => Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.fill),
                    )),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      gradient: LinearGradient(
                        colors: [
                          ColorUtilsV2.hex_35354D.withOpacity(0.0),
                          ColorUtilsV2.hex_35354D.withOpacity(0.2),
                          ColorUtilsV2.hex_1F1F2E.withOpacity(0.5),
                          ColorUtilsV2.hex_1F1F2E
                        ],
                        begin: const FractionalOffset(0.0, 1.2),
                        end: const FractionalOffset(0.0, 0.0),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: SvgPicture.asset(AssetUtils.icPlayVideo),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Wrap(
                spacing: 6.0,
                children: [
                  for (int i = 0; i < videoItem.categories!.length; i++)
                    Builder(builder: (context) {
                     final item = videoItem.categories![i];
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            radius: 2.5,
                            backgroundColor: ColorUtilsV2.hex_35354D,
                          ),
                          const SizedBox(width: 8.0),
                          AppTextV2(
                            data:item.categoryName??"",
                            fontSize: 12.0,
                            height: 16.39 / 12.0,
                            fontWeight: FontWeight.w500,
                            fontColor: ColorUtilsV2.hex_35354D,
                          ),
                          const SizedBox(width: 8.0),
                        ],
                      );
                    }),
                ],
              ),
            ),
            const SizedBox(height: 6.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppTextV2(
                      data: videoItem.title ?? "",
                      fontSize: 16.0,
                      maxLines: 2,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.left,
                      height: 19.12 / 14.0,
                      fontColor: ColorUtilsV2.hex_35354D,
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  InkWell(
                    onTap: () {
                      Share.share("${videoItem.title}. ${videoItem.videoUrl}");
                    },
                    child: CircleAvatar(
                      backgroundColor: ColorUtilsV2.hex_E1E1FE,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: SvgPicture.asset(AssetUtils.icShareBlue),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 14.0)
          ],
        ),
      ),
    );
  }
}
