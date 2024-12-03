import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class PaymentSuccessHeaderSection extends StatelessWidget {
  bool isShowView;

  PaymentSuccessHeaderSection({Key? key, this.isShowView = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isShowView,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: const BoxDecoration(
          color: ColorUtils.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AssetUtils.checkMarkIcon,
              package: "common",
              width: 60,
              height: 60,
            ),
            const SizedBox(
              width: 15,
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: AppConstants.paymentSuccess,
                    fontSize: Sizes.textSize14,
                    fontWeight: FontWeight.w800,
                    textAlign: TextAlign.start,
                    fontColor: ColorUtils.blackColor,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Expanded(
                    child: AppText(
                      data: AppConstants.initialContributionNPS,
                      fontSize: Sizes.textSize10,
                      fontWeight: FontWeight.w600,
                      fontColor: ColorUtils.kGreyDarkColor,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
