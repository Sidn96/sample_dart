import 'package:common/core/presentation/components_v2/app_chip_widget.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/models/app_chip_model.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class AppChipGroupWidget extends HookWidget {

  final List<AppChipModel> models;
  final Function(AppChipModel model) onSelected;
  final Color activeColor;
  final Color disabledColor;
  final Color? borderColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final double spacingBetween;
  final double runSpacing;
  ///Show list of widget with Wrap or ListView
  final bool wrap;
  final double? width;
  final double? height;
  final EdgeInsets contentPadding;

  const AppChipGroupWidget({
    Key? key,
    required this.models,
    required this.onSelected,
    this.activeColor = ColorUtilsV2.specialSuccess300,
    this.disabledColor = ColorUtilsV2.neutral100,
    this.activeTextColor = ColorUtilsV2.specialNeutral700,
    this.inactiveTextColor = ColorUtilsV2.specialNeutral700,
    this.borderColor,
    this.spacingBetween = 8.0,
    this.runSpacing = 8.0,
    this.wrap = false,
    this.width,
    this.height = 35,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 17)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedModelNotifier = useState<AppChipModel?>(null);
    
    List<Widget> widgets = models.map((model) {
      final isSelectedModel =
          (selectedModelNotifier.value?.value == model.value);

      return AppChipWidget(
        width: 80,
        height: height,
        model: model,
        onSelected: () {
          selectedModelNotifier.value = model;
          onSelected(model);
        },
        activeChipBgColor: activeColor,
        disabledColor: disabledColor,
        isSelected: isSelectedModel,
        activeTextColor: activeTextColor,
        inactiveTextColor: inactiveTextColor,
      );
    }).toList();

    if (wrap) {
      return Wrap(
          runSpacing: runSpacing, spacing: spacingBetween, children: widgets);
    } else {
      return SizedBox(
        height: 35,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return widgets[index];
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: spacingBetween);
          },
          itemCount: models.length,
        ),
      );
    }
  }
}