import 'package:common/core/presentation/components/dotted_line.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final double lineWidth = 5.0;
  final List<Map<String, dynamic>> steps;
  const CustomStepper({
    Key? key,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _iconViews()),
        ),
        const SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _titleViews()),
      ],
    );
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    steps.asMap().forEach((i, icon) {
      list.add(
        Container(
          width: 25.0,
          height: 25.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorUtilsV2.hex_4ADE80),
            color: Colors.transparent,
          ),
          child: Center(
              child: AppText(
            data: "${(i + 1)}",
            fontSize: 12,
            fontColor: ColorUtilsV2.hex_FFFFFF,
          )),
        ),
      );
      if (i != steps.length - 1) {
        list.add(
          const Expanded(
            child: DottedLine(
                dashColor: ColorUtilsV2.hex_FFFFFF, dashGapLength: 2),
          ),
        );
      }
    });

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    steps.asMap().forEach((i, text) {
      list.add(Expanded(
        child: Row(
          children: [
            Expanded(
                child: AppTextV2(
              data: text["title"],
              fontSize: 11,
              height: 1.3,
              fontWeight: FontWeight.w400,
              fontColor: ColorUtilsV2.hex_FFFFFF,
              textAlign: TextAlign.center,
            )),
            if (i != steps.length - 1) const SizedBox(width: 10),
          ],
        ),
      ));
    });
    return list;
  }
}

class ReferAndEarnHowItsWork extends StatelessWidget {
  const ReferAndEarnHowItsWork({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const AppTextV2(
            data: "How it works?",
            fontSize: 20,
            height: 1.4,
            fontWeight: FontWeight.w300,
            fontColor: Colors.white,
          ),
          20.height,
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorUtilsV2.hex_2E2E49,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const CustomStepper(
              steps: [
                {"title": "Invite friends with unique link"},
                {"title": "Friend opens a new NPS account"},
                {"title": "You receive amazon voucher on email"}
              ],
            ),
          )
        ],
      ),
    );
  }
}
