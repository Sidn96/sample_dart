import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

import 'color_utils_v2.dart';

/// Directly get the type of Icon without need to pass iconPath in [AppIconButton]
enum AppIconButtonTypeEnum {
  CANCEL, EDIT, OPTION, NONE
}

class AppIconButton extends StatelessWidget {

  final String iconPath;
  final VoidCallback? onPressed;
  final double iconSize;
  final EdgeInsets padding;
  final Color? iconColor;
  final AppIconButtonTypeEnum iconButtonType;

  const AppIconButton({
    super.key,
    required this.onPressed,
    this.iconPath = '',
    this.iconSize = 16,
    this.padding = const EdgeInsets.all(8),
    this.iconColor = ColorUtilsV2.specialNeutral700,
    this.iconButtonType = AppIconButtonTypeEnum.NONE,
  });

  factory AppIconButton.cancel({VoidCallback? onPressed, double? iconSize}) {
    return AppIconButton(
        iconButtonType: AppIconButtonTypeEnum.CANCEL,
        onPressed: onPressed,
        iconSize: iconSize ?? 24);
  }

  factory AppIconButton.edit({VoidCallback? onPressed}) {
    return AppIconButton(
        iconButtonType: AppIconButtonTypeEnum.EDIT, onPressed: onPressed);
  }

  @override
  Widget build(BuildContext context) {
    if (iconButtonType == AppIconButtonTypeEnum.NONE && !iconPath.endsWith('.svg')) {
      throw Exception('AppIconButton requires iconPath to be a .svg file');
    }
    var tIconPath = _svgPath();

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: AppImage(
          imgPath: tIconPath,
          isSvg: true,
          iconColor: iconColor,
          height: iconSize,
          width: iconSize,
        ),
      ),
    );
  }

  String _svgPath() {
    var map = <AppIconButtonTypeEnum, String>{
      AppIconButtonTypeEnum.CANCEL: AssetUtils.closeV2,
      AppIconButtonTypeEnum.EDIT: AssetUtils.editIndigo,
      AppIconButtonTypeEnum.OPTION: AssetUtils.option,
      AppIconButtonTypeEnum.NONE: iconPath,
    };

    var result = map[iconButtonType];
    if (result.isNullOrEmpty()) {
      throw Exception('$iconButtonType is not configured');
    }
    return result!;
  }
}
