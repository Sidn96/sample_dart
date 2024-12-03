import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/ui_manager.dart';
import 'package:flutter/material.dart';

import '../widgets/space.dart';
import 'app_text_v2.dart';
import 'color_utils_v2.dart';
import 'package:dotted_border/dotted_border.dart';

class StepperTimeline extends StatelessWidget {
  const StepperTimeline(
      {super.key,
      required this.totalCount,
      required this.selectedIndex,
      required this.selectedIndexTitle,
      this.edgeInsets})
      : assert(selectedIndex > 0 && selectedIndex <= totalCount,
            'selectedIndex [$selectedIndex] should be > 0 and <= totalCount [$totalCount]');

  final int totalCount;
  final int selectedIndex;
  final String selectedIndexTitle;
  final EdgeInsets? edgeInsets;

  @override
  Widget build(BuildContext context) {
    List<int> newList = [];

    for (int i = selectedIndex; i <= totalCount - 1; i++) {
      newList.add(i);
    }

    return Container(
      height: 70,
      width: UiManager.width(context),
      color: ColorUtilsV2.specialBackground50,
      padding: edgeInsets,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (selectedIndex != 1)
            CustomPaint(
              size: const Size(33, 0),
              painter: DashedLinePainter(ColorUtilsV2.specialNeutral700),
            ),

          const Space(
            width: 7,
          ),
          DottedBorder(
            color: ColorUtilsV2.specialWarning500,
            borderType: BorderType.Circle,
            strokeWidth: 1,
            strokeCap: StrokeCap.round,
            dashPattern: const [2],
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: AppTextV2(
                data: '$selectedIndex'.padLeft(2, '0'),
                fontColor: ColorUtilsV2.specialWarning500,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 0,
              )),
            ),
          ),
          const Space(
            width: 8,
          ),

          Container(
            constraints: const BoxConstraints(
              maxWidth: 150,
            ),
            child: AppTextV2(
              data: selectedIndexTitle,
              fontColor: ColorUtilsV2.specialWarning500,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              height: 0,
            ),
          ),
          const Space(
            width: 8,
          ),
          if (selectedIndex != totalCount)
            Expanded(
              child: CustomPaint(
                size: const Size(100, 0),
                painter: DashedLinePainter(
                  ColorUtilsV2.specialWarning500,
                ),
              ),
            ),

          // const Space(width: 10,),
          Expanded(
            flex: totalCount > 3 ? 2 : 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: newList.map((e) {
                  return Container(
                    margin: const EdgeInsets.only(left: 13.0),
                    padding: const EdgeInsets.all(2.0),
                    child: DottedBorder(
                      color: ColorUtilsV2.specialBackground300,
                      borderType: BorderType.Oval,
                      strokeWidth: 1,
                      strokeCap: StrokeCap.round,
                      // dashPattern: const [2],
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: AppTextV2(
                          data: '${e + 1}'.padLeft(2, '0'),
                          fontColor: ColorUtilsV2.specialBackground300,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        )),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 3;
    const double dashSpace = 2;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

ScrollController? stepperScrollController;
scrollToTitle(String title, {bool isFromPorting = false}) {
//  print("title = $title");
  double offset = 0;
  switch (title) {
    case "Login":
      offset = 50.0;
      break;
    case "KYC":
      offset = 50.0;
      break;
    case "Proposer Details":
      offset = 180.0;
      break;
    case "Member Details":
      offset = 400.0;
      break;
    case "Health Details":
      offset = 600.0;
      break;
    case "Portability":
      offset = 770.0;
      break;
    case "Nominee Details":
      offset = isFromPorting ? 950.0 : 770.0;
      break;
    case "Summary & Pay":
      offset = isFromPorting ? 1100: 865.0;
      break;
  }
  stepperScrollController?.animateTo(offset,
      duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
}

class StepperTimelineV2 extends HookWidget {
  const StepperTimelineV2(
      {super.key,
      required this.totalCount,
      required this.selectedIndex,
      required this.titlesList,
      required this.onIndexTap,
      this.edgeInsets})
      : assert(selectedIndex > 0 && selectedIndex <= totalCount,
            'selectedIndex [$selectedIndex] should be > 0 and <= totalCount [$totalCount]');

  final int totalCount;
  final int selectedIndex;
  final EdgeInsets? edgeInsets;
  final List<String> titlesList;
  final Function(int) onIndexTap;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      stepperScrollController = ScrollController();
      return () {
        stepperScrollController?.dispose();
      };
    }, []);
    // print("sel index = $selectedIndex");
    return Container(
        height: 70,
        width: UiManager.width(context),
        color: ColorUtilsV2.specialBackground50,
        padding: edgeInsets,
        child: ListView.separated(
            controller: stepperScrollController,
            padding: const EdgeInsets.only(left: 8.0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  InkWell(
                    onTap: () => onIndexTap(index+1),
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      child: (index + 1) == selectedIndex
                          ? DottedBorder(
                              color: ColorUtilsV2.specialWarning500,
                              borderType: BorderType.Circle,
                              strokeWidth: 1,
                              strokeCap: StrokeCap.round,
                              dashPattern: const [2],
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: AppTextV2(
                                  data: '$selectedIndex'.padLeft(2, '0'),
                                  fontColor: ColorUtilsV2.specialWarning500,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                )),
                              ),
                            )
                          : DottedBorder(
                              color: ColorUtilsV2.specialBackground300,
                              borderType: BorderType.Oval,
                              strokeWidth: 1,
                              strokeCap: StrokeCap.round,
                              // dashPattern: const [2],
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: AppTextV2(
                                  data: '${index + 1}'.padLeft(2, '0'),
                                  fontColor: ColorUtilsV2.specialBackground300,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                )),
                              ),
                            ),
                    ),
                  ),
                  6.width,
                  InkWell(
                    onTap:()=> onIndexTap(index+1),
                    child: AppTextV2(
                      data: titlesList[index],
                      fontColor: index + 1 == selectedIndex
                          ? ColorUtilsV2.specialWarning500
                          : ColorUtilsV2.specialBackground300,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      height: 0,
                    ),
                  ),
                  6.width,
                  if (index != titlesList.length - 1)
                    CustomPaint(
                      size: const Size(60, 0),
                      painter: DashedLinePainter(
                        index + 1 == selectedIndex
                            ? ColorUtilsV2.specialWarning500
                            : ColorUtilsV2.specialBackground300,
                      ),
                    )
                ],
              );
            },
            separatorBuilder: (context, index) => 8.width,
            itemCount: titlesList.length));

    /* Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Space(
          width: 7,
        ),
        DottedBorder(
          color: ColorUtilsV2.specialWarning500,
          borderType: BorderType.Circle,
          strokeWidth: 1,
          strokeCap: StrokeCap.round,
          dashPattern: const [2],
          child: Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
                child: AppTextV2(
                  data: '$selectedIndex'.padLeft(2, '0'),
                  fontColor: ColorUtilsV2.specialWarning500,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 0,
                )),
          ),
        ),
        const Space(
          width: 8,
        ),

        Container(
          constraints: const BoxConstraints(
            maxWidth: 150,
          ),
          child: AppTextV2(
            data: selectedIndexTitle,
            fontColor: ColorUtilsV2.specialWarning500,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            height: 0,
          ),
        ),
        const Space(
          width: 8,
        ),
        if (selectedIndex != totalCount)
          Expanded(
            child: CustomPaint(
              size: const Size(100, 0),
              painter: DashedLinePainter(
                ColorUtilsV2.specialWarning500,
              ),
            ),
          ),

        // const Space(width: 10,),
        Expanded(
          flex: totalCount > 3 ? 2 : 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: newList.map((e) {
                ;
              }).toList(),
            ),
          ),
        ),
      ],
    ),);*/
  }
}
