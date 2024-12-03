import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/extensions/number_format_extension.dart';
import 'package:flutter/material.dart';

class AppSlider extends StatelessWidget {
  final int sliderValue;
  final int minSliderValue;
  final int maxSliderValue;
  final void Function(int) onChanged;
  final int divisions;
  final Color sliderThumbColor;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final int sliderThumbRadiusSize;
  final bool displayMinMaxBelow;
  final bool displayAmountWithMinMax;
  final Color minMaxLabelColor;

  const AppSlider({
    Key? key,
    required this.sliderValue,
    required this.minSliderValue,
    required this.maxSliderValue,
    required this.onChanged,
    this.divisions =
        AppConstants.defaultDivisionsForSlider, // if min is 1 and max is 1000
    this.sliderThumbColor = ColorUtils.white,
    this.activeTrackColor = ColorUtils.kSliderActiveColor,
    this.inactiveTrackColor = ColorUtils.taxdarkGray,
    this.sliderThumbRadiusSize = FontSizes.sliderThumbRadiusSize,
    this.displayMinMaxBelow = true,
    required this.displayAmountWithMinMax,
    this.minMaxLabelColor = ColorUtilsV2.genericWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbColor: sliderThumbColor,
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            inactiveTickMarkColor: Colors.transparent,
            activeTickMarkColor: Colors.transparent,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: sliderThumbRadiusSize.toDouble(),
            ),
          ),
          child: Slider(
            value: sliderValue.toDouble(),
            onChanged: (value) {
              onChanged.call(value.toInt());
            },
            min: minSliderValue.toDouble(),
            max: maxSliderValue.toDouble(),
            divisions: divisions,
          ),
        ),
        Visibility(
          visible: displayMinMaxBelow,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextV2(
                  textStyle: TextStyle(
                    color: minMaxLabelColor,
                    fontWeight: FontWeight.w400,
                  ),
                  data: displayAmountWithMinMax
                      ? 'Min ${AppConstants.rupeeSymbol}${minSliderValue.formatToIndianHumanReadable()}'
                      : '${AppConstants.rupeeSymbol}${minSliderValue.formatToIndianHumanReadable()}',
                  fontSize: 14,
                ),
                AppTextV2(
                  data: displayAmountWithMinMax
                      ? 'Max ${AppConstants.rupeeSymbol}${maxSliderValue.formatToIndianHumanReadable()}'
                      : '${AppConstants.rupeeSymbol}${maxSliderValue.formatToIndianHumanReadable()}',
                  textStyle: TextStyle(
                    color: minMaxLabelColor,
                    fontWeight: FontWeight.w400,
                  ),
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
