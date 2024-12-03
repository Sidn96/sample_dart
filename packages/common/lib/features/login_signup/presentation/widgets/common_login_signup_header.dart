import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/widgets/app_image.dart';
import 'package:common/features/login_signup/presentation/widgets/header_left_widget.dart';
import 'package:common/features/login_signup/presentation/widgets/header_right_widget.dart';
import 'package:flutter/material.dart';

class CommonLoginSignUpHeader extends StatelessWidget {
  const CommonLoginSignUpHeader({
    super.key,
    this.title,
    this.subTitle,
    this.imagePath,
    this.package,
    this.showStepper = true,
  });

  final String? title;
  final String? subTitle;
  final String? imagePath;
  final String? package;
  final bool showStepper;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -20,
          left: -70,
          child: Image.asset(AssetUtils.dottedPattern,
              package: "common", height: 63.39, width: 164),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeaderLeftWidget(
              showStepper: showStepper,
              title: title,
              subTitle: subTitle,
            ),
            HeaderRightWidget(imagePath: imagePath, package: package),
          ],
        ),
      ],
    );
  }
}
