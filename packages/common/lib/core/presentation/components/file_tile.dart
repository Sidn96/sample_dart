import 'package:common/core/presentation/components/file_type_icon.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final String fileExtension;
  final Widget action;
  const FileTile({
    super.key,
    required this.fileName,
    required this.fileSize,
    required this.fileExtension,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: ColorUtils.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: ColorUtils.darkGrayColor),
        ),
        child: Row(
          children: [
            FileTypeIcon(fileExtension: fileExtension),
            8.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: AppText(
                    data: fileName,
                    fontSize: 10,
                    fontColor: ColorUtilsV2.hex_717182,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.start,
                    letterSpacing: 0.024,
                    height: 1.3,
                  ),
                ),
                6.height,
                AppText(
                  data: "Size: $fileSize",
                  fontSize: 10,
                  fontColor: ColorUtilsV2.hex_717182,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.024,
                ),
              ],
            ),
            const Spacer(),
            action
          ],
        ),
      ),
    );
  }
}
