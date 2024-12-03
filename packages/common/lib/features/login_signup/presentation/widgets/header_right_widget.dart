import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class HeaderRightWidget extends StatelessWidget {
  const HeaderRightWidget({super.key, this.imagePath, this.package});

  final String? imagePath;
  final String? package;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath ?? AssetUtils.signUpHeader,
      package: package ?? "common",
    );
  }
}
