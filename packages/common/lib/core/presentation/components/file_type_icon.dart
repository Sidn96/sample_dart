import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FileTypeIcon extends StatelessWidget {
  const FileTypeIcon({
    super.key,
    required this.fileExtension,
  });

  final String fileExtension;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorUtils.specialWarning,
        border: Border.all(color: ColorUtils.warningCircle),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 7.0),
      child: SvgPicture.asset(
        (fileExtension.toUpperCase().contains("JPG"))
            ? AssetUtils.fileJPG
            : (fileExtension.toUpperCase().contains("JPEG"))
                ? AssetUtils.fileJPEG
                : (fileExtension.toUpperCase().contains("PNG"))
                    ? AssetUtils.filePNG
                    : AssetUtils.filePDF,
        height: 18,
        width: 14,
        package: "common",
      ),
    );
  }
}
