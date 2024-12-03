import 'package:common/core/consts/constant_app_strings.dart';
import 'package:common/core/presentation/common_widgets/circular_image_widget.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/service_recommendation_and_rating/domain/entities/member_angel_rating_details_entity.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/widgets/rating_stars_and_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceRecommendationAndRatingHeader extends StatelessWidget {
  final MemberAngelRatingDetailsEntity? detailsEntity;
  final Function(double)? onRatingUpdate;

  const ServiceRecommendationAndRatingHeader(
      {super.key, this.detailsEntity, this.onRatingUpdate});

  @override
  Widget build(BuildContext context) {
    const unit = 4;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border(bottom: BorderSide(color: ColorUtils.kbrown)),
        gradient: LinearGradient(
            colors: [
              ColorUtilsV2.hex_FFFAED,
              ColorUtilsV2.hex_FFFAED,
              ColorUtilsV2.hex_F3F4F6,
              //add more colors for gradient
            ],
            begin: Alignment.topCenter, //begin of the gradient color
            end: Alignment.bottomRight, //end of the gradient color
            stops: [0.0, 0.4, 0.8] //stops for individual color
            //set the stops number equal to numbers of color
            ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          detailsEntity?.profileUrl != null
              ? CircularImageW(
                  imagePath: detailsEntity!.profileUrl!,
                  width: 120,
                  height: 120,
                )
              : Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: ColorUtils.lightGrayColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorUtils.midGrey),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                        // unit is some relative part of the canvas width
                        offset: Offset(-unit / 2, -unit / 2),
                        blurRadius: 1.5 * unit,
                      ),
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(unit / 2, unit / 2),
                        blurRadius: 1.5 * unit,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(48), // Image radius
                        child: SvgPicture.asset(
                          (detailsEntity?.gender?.toLowerCase().contains("f") ??
                                  false)
                              ? AssetUtils.oldWomen
                              : AssetUtils.oldMan,
                          fit: BoxFit.contain,
                          package: "common",
                        ),
                      ),
                    ),
                  ),
                ),
          20.height,
          const AppText(
            data: AppStrings.rateyourexperiencewith,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          10.height,
          AppText(
            data: detailsEntity?.name ?? "",
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          20.height,
          RatingStarsAndStatus(
            onRatingUpdate: onRatingUpdate,
          ),
        ],
      ),
    );
  }
}
