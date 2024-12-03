import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/widgets.dart';

class LoginRegisterHeaderRowWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String commonAssetImgName;
  const LoginRegisterHeaderRowWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.commonAssetImgName,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Dotted Image
        Positioned(
          top: -20,
          left: -48,
          child: Image.asset(AssetUtils.dottedPattern,
              package: "common", height: 63.39, width: 164),
        ),
        //Left Text Title and Sub Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 22, bottom: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: title,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.start,
                      height: 1.1,
                      letterSpacing: -0.44,
                    ),
                    const SizedBox(height: 6),
                    AppText(
                      data: subTitle,
                      textAlign: TextAlign.start,
                      height: 1.3,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    )
                  ],
                ),
              ),
            ),
            //Right Image
            SizedBox(
              // height: 174,
              width: 164,
              child: Image.asset(
                commonAssetImgName,
                package: "common",
              ),
            )
          ],
        ),
      ],
    );
  }
}