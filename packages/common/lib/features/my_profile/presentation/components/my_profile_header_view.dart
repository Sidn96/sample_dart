import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:common/features/my_profile/presentation/providers/get_account_details_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyProfileHeaderView extends HookConsumerWidget {
  const MyProfileHeaderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountDetails = ref.watch(accountDetailsDataProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: Sizes.screenHeight * 0.42,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(200.0),
              bottomRight: Radius.circular(200.0)),
          child: Container(
            color: ColorUtils.blueishPurpleColor,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  top: 12,
                  left: 0,
                  child: Row(
                    children: [
                      IconButton(
                          padding: const EdgeInsets.only(left: 21),
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios, size: 15),
                          color: ColorUtils.white),
                      const SizedBox(
                        width: 10,
                      ),
                      const AppText(
                        data: AppConstants.back,
                        fontSize: Sizes.textSize16,
                        fontColor: ColorUtils.white,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: -20,
                    right: -20,
                    child: Transform.scale(
                      scaleX: 0.9,
                      child: const AppImage(
                        imgPath: AssetUtils.eclipse,
                        iconColor: ColorUtils.curiousBlueColor,
                      ),
                    )),
                Positioned(
                  top: 50,
                  child: Column(
                    children: [
                        //     AppImage(
                        //   isSvg: false,
                        //   imgPath: AssetUtils.planner,
                        // ),
                        // child: CachedNetworkImage(
                        //   imageUrl: accountDetails?.profilePic ?? '',
                        //   placeholder: (context, url) =>
                        //       const CircularProgressIndicator(
                        //           color: ColorUtils.transparent),
                        //   errorWidget: (context, url, error) =>
                        //       const CircularProgressIndicator(color: ColorUtils.transparent),
                        // ),
                    //  ),
                    accountDetails?.profilePic != null ?
                    Stack(
                        clipBehavior: Clip.none,
                        children: [
                         Positioned(
                           right: -3,top: -4,
                           child: Image.asset(AssetUtils.blueCircle,package: "common",width: 120.0,
                             height: 128.0,),
                         ),
                         Positioned(
                           left: -3,bottom: -4,
                           child: Image.asset(AssetUtils.greenCircle,package: "common",width: 120.0,
                             height: 128.0,),
                         ),
                          CachedNetworkImage(
                            imageUrl: accountDetails?.profilePic ?? '',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 120.0,
                              height: 128.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorUtils.unselectedTextColor,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.fill),
                              ),
                            ),
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Container(color: ColorUtils.transparent),
                          ),
                        ],
                      ) : const CircularProgressIndicator(),
                      const SizedBox(
                        height: 18,
                      ),
                      AppText(
                        data: accountDetails?.fullName ?? '-',
                        fontSize: Sizes.textSize24,
                        fontColor: ColorUtils.white,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      AppText(
                        data: accountDetails?.location ?? '-',
                        fontSize: Sizes.textSize16,
                        fontColor: ColorUtils.white,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
