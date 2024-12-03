import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

class LoginCheckBoxWithTitle extends StatelessWidget {
  final void Function(bool?)? onChanged;
  final bool value;
  final Widget body;
  final bool showError;
  const LoginCheckBoxWithTitle({
    super.key,
    required this.onChanged,
    required this.value,
    required this.body,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 30.0,
              width: 30.0,
              child: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: showError
                      ? ColorUtils.errorColor
                      : ColorUtils.blackBluish,
                  checkboxTheme: CheckboxThemeData(
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    checkColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                      return ColorUtils.snackbarBlack;
                    }),
                    fillColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.disabled)) {
                        return null;
                      }
                      if (states.contains(WidgetState.selected)) {
                        return ColorUtils.kGreenBrightColor;
                      }
                      return null;
                    }),
                  ),
                ),
                child: Checkbox(
                  value: value,
                  onChanged: onChanged,
                ),
              ),
            ),
            body,
          ],
        ),
        if (showError)
          const Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: AppText(
              data: AppConstants.mandatoryCheckBoxSelection,
              fontSize: Sizes.defaultTextSize,
              fontWeight: FontWeight.w400,
              maxLines: 2,
              textAlign: TextAlign.start,
              fontColor: ColorUtils.errorColor,
            ),
          ),
      ],
    );
  }
}
