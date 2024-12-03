import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Define a custom path to create a stylish clipped shape
    var path = Path();
    path.moveTo(0, size.height * 0.5);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(size.width * 0.8, 0);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HexagonShapeBox extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool showBorder;
  final double height;
  final double width;
  final Color? bgColor;
  final bool secondarygradient;
  const HexagonShapeBox(
      {super.key,
      this.subtitle,
      this.title,
      required this.height,
      required this.width,
      this.bgColor,
      this.secondarygradient = false,
      this.showBorder = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (showBorder)
          ClipPath(
            clipper: HexagonClipper(),
            child: Container(
              width: width * 1.12,
              height: height * 1.12,
              decoration: const BoxDecoration(
                // border: Border.all(color: Colors.red),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorUtilsV2.hex_7375FD,
                    ColorUtilsV2.hex_7375FD,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        if (showBorder)
          ClipPath(
            clipper: HexagonClipper(),
            child: Container(
              width: width * 1.09,
              height: height * 1.09,
              decoration: const BoxDecoration(
                color: ColorUtilsV2.purpleDark,
                // gradient: LinearGradient(
                //   begin: Alignment.bottomCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     ColorUtilsV2.purpleDark,
                //     Colors.transparent,
                //   ],
                // ),
              ),
            ),
          ),
        ClipPath(
          clipper: HexagonClipper(),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: showBorder
                  ? secondarygradient
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorUtilsV2.hex_7375FD,
                            ColorUtilsV2.hex_4E52F8,
                            ColorUtilsV2.hex_3C3EAC,
                          ],
                        )
                      : const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorUtilsV2.hex_4E52F8,
                            ColorUtilsV2.hex_3C3EAC,
                            ColorUtilsV2.purpleDark,
                          ],
                        )
                  : null,
              color: bgColor,
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null)
                  AppTextV2(
                    data: title ?? "",
                    fontSize: 13,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    fontColor: Colors.white,
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 7),
                  SizedBox(
                    width: 100,
                    child: AppTextV2(
                      data: subtitle ?? "",
                      fontSize: 11,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      fontColor: Colors.white,
                    ),
                  ),
                ],
              ],
            )),
          ),
        ),
      ],
    );
  }
}
