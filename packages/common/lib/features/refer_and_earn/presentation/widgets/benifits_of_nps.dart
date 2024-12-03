import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/hexagon_shape_box.dart';
import 'package:flutter/material.dart';

class BenifitsOfNps extends StatelessWidget {
  const BenifitsOfNps({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppTextV2(
          data: "Benefits of NPS",
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontColor: Colors.white,
        ),
        const SizedBox(height: 10),
        Container(
          height: 500,
          constraints: const BoxConstraints(maxWidth: 413),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxHeight = constraints.heightConstraints().maxHeight;
              final maxWidth = constraints.widthConstraints().maxWidth;
              return Stack(
                children: [
                  // ==== top box ====
                  Positioned(
                    top: maxHeight - 380,
                    left: maxWidth * 0.06,
                    child: HexagonShapeBox(
                      width: maxWidth * 0.10,
                      height: maxHeight * 0.07,
                      bgColor: ColorUtilsV2.hex_D9D9D9.withOpacity(0.1),
                    ),
                  ),
                  Positioned(
                    top: maxHeight - 450,
                    left: maxWidth * 0.30,
                    child: HexagonShapeBox(
                      width: maxWidth * 0.20,
                      height: maxHeight * 0.14,
                      bgColor: ColorUtilsV2.hex_D9D9D9.withOpacity(0.1),
                    ),
                  ),
                  Positioned(
                    top: maxHeight - 430,
                    left: maxWidth * 0.505,
                    child: HexagonShapeBox(
                      title: "Tax Benefits",
                      subtitle:
                          "Save upto 2 lacs in taxes with NPS contribution",
                      showBorder: true,
                      width: maxWidth * 0.32,
                      height: maxHeight * 0.23,
                    ),
                  ),
                  Positioned(
                    top: maxHeight - 415,
                    right: maxWidth * 0.03,
                    child: HexagonShapeBox(
                      width: maxWidth * 0.10,
                      height: maxHeight * 0.07,
                      bgColor: ColorUtilsV2.hex_D9D9D9.withOpacity(0.1),
                    ),
                  ),
                  // === middle boxes ===
                  Positioned(
                    top: maxHeight - 275,
                    left: -(maxWidth * 0.20),
                    child: HexagonShapeBox(
                      width: maxWidth * 0.32,
                      height: maxHeight * 0.23,
                      showBorder: true,
                      bgColor: ColorUtilsV2.hex_D9D9D9.withOpacity(0.1),
                    ),
                  ),
                  Positioned(
                    top: maxHeight - 360,
                    left: maxWidth * 0.15,
                    child: HexagonShapeBox(
                      title: "Simple & Easy",
                      subtitle: "Hassle free investing through SIPs",
                      secondarygradient: true,
                      showBorder: true,
                      width: maxWidth * 0.32,
                      height: maxHeight * 0.23,
                    ),
                  ),
                  Positioned(
                    top: maxHeight - 280,
                    left: maxWidth * 0.505,
                    child: HexagonShapeBox(
                      title: "Flexibility",
                      subtitle:
                          "Align your portfolio with your risk preferences.",
                      showBorder: true,
                      width: maxWidth * 0.32,
                      height: maxHeight * 0.23,
                    ),
                  ),
                  Positioned(
                    top: maxHeight - 350,
                    right: -(maxWidth * 0.23),
                    child: HexagonShapeBox(
                      showBorder: true,
                      width: maxWidth * 0.32,
                      height: maxHeight * 0.23,
                      bgColor: ColorUtilsV2.hex_D9D9D9.withOpacity(0.1),
                    ),
                  ),
                  // == bottom boxes ===
                  Positioned(
                    top: maxHeight - 210,
                    left: maxWidth * 0.15,
                    child: HexagonShapeBox(
                      title: "Safety &\nSecurity",
                      subtitle: "Government Oversight and Regulation",
                      secondarygradient: true,
                      showBorder: true,
                      width: maxWidth * 0.32,
                      height: maxHeight * 0.23,
                    ),
                  ),
                  Positioned(
                    top: maxHeight - 120,
                    left: maxWidth * 0.06,
                    child: HexagonShapeBox(
                      width: maxWidth * 0.10,
                      height: maxHeight * 0.07,
                      bgColor: ColorUtilsV2.hex_D9D9D9.withOpacity(0.1),
                    ),
                  ),
                  Positioned(
                    top: maxHeight - 140,
                    right: maxWidth * 0.160,
                    child: HexagonShapeBox(
                      width: maxWidth * 0.19,
                      height: maxHeight * 0.14,
                      bgColor: ColorUtilsV2.hex_D9D9D9.withOpacity(0.1),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
