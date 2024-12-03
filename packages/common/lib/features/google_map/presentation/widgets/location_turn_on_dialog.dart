import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class LocationPremisesDialog extends StatelessWidget {
  final VoidCallback? onSettingPressed;
  final VoidCallback? onCancel;
  const LocationPremisesDialog({
    super.key,
    this.onSettingPressed,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.transparent,
      child: LocationPremisesDialogBody(
        onSettingPressed: onSettingPressed,
        onCancel: onCancel,
      ),
    );
  }
}

class LocationPremisesDialogBody extends StatelessWidget {
  final VoidCallback? onSettingPressed;
  final VoidCallback? onCancel;
  const LocationPremisesDialogBody({
    super.key,
    this.onSettingPressed,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            heightFactor: 0.76,
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => onCancel?.call(),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(26, 26),
                  backgroundColor: ColorUtils.midGrey),
              child: const Icon(
                Icons.close,
                color: ColorUtils.midLightGrey,
                size: 19,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const AppText(
                  data: "Turn On Location Permission",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                8.height,
                const AppText(
                  data:
                      "Please go to Settings -> Location to turn on Location permission",
                  fontSize: 14,
                  textAlign: TextAlign.start,
                  height: 1.3,
                  fontWeight: FontWeight.w400,
                ),
                30.height,
                Row(
                  children: [
                    Expanded(
                      child: MemberAngelAppButton(
                        label: "Cancel",
                        bgColor: ColorUtils.kTabSwitchColor,
                        onSuccessHandler: () => onCancel?.call(),
                      ),
                    ),
                    14.width,
                    Expanded(
                      child: MemberAngelAppButton(
                        label: "Settings",
                        onSuccessHandler: () => onSettingPressed?.call(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          17.height,
        ],
      ),
    );
  }
}
