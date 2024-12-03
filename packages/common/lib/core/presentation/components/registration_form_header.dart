import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

class RegisterFormHeader extends StatelessWidget {
  final String headerImg;
  final String bgImg;
  final String titleText;
  final String subTitleText;

  const RegisterFormHeader({
    Key? key,
    required this.headerImg,
    required this.bgImg,
    required this.subTitleText,
    required this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.screenHeight * 0.22,
      child: Stack(
        children: [
          ///dotted bg img
          Padding(
            padding: const EdgeInsets.only(
              left: 00.0,
              top: 0.0,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(bgImg,
                  height: 63, width: 164, package: "care100_pod"),
            ),
          ),

          Positioned(
            right: 0,
            top: -50,
            child: Image.asset(headerImg, package: "care100_pod"),
          ),

          /// title and subtitle text
          Positioned(
            top: 40,
            child: SizedBox(
              width: Sizes.screenWidth(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppText(
                            data: titleText,
                            fontSize: Sizes.textSize22,
                            fontWeight: FontWeight.w800,
                            textAlign: TextAlign.start,
                            height: 1.3,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppText(
                              data: subTitleText,
                              fontSize: Sizes.textSize12,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// login steps
        ],
      ),
    );
  }
}
