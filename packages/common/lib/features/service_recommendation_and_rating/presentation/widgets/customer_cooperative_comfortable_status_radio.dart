import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class StatusSelectionRadio extends HookConsumerWidget {
  final Function(int? value) selectedChoice;
  const StatusSelectionRadio({super.key, required this.selectedChoice});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = useState<int?>(null);

    void handleRadioValueChange(int? value) {
      selectedChoice(value);
      selectedValue.value = value ?? -1;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              visualDensity:
                  const VisualDensity(horizontal: VisualDensity.minimumDensity),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: WidgetStateProperty.resolveWith(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return ColorUtilsV2.hex_000000;
                  }
                  return ColorUtilsV2.hex_AEAEB7;
                },
              ),
              value: 0,
              groupValue: selectedValue.value,
              onChanged: handleRadioValueChange,
            ),
            const SizedBox(width: 12),
            const AppText(
                data: "Yes", fontSize: 14, fontWeight: FontWeight.w500),
          ],
        ),
        const SizedBox(width: 30), // Space between the radio buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              visualDensity:
                  const VisualDensity(horizontal: VisualDensity.minimumDensity),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: WidgetStateProperty.resolveWith(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return ColorUtilsV2.hex_000000;
                  }
                  return ColorUtilsV2.hex_AEAEB7;
                },
              ),
              value: 1,
              groupValue: selectedValue.value,
              onChanged: handleRadioValueChange,
            ),
            const SizedBox(width: 12),
            const AppText(data: "No", fontSize: 14, fontWeight: FontWeight.w500)
          ],
        ),
      ],
    );
  }
}
