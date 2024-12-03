import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:flutter/material.dart';

class MemberPalAdultTcBody extends StatelessWidget {
  const MemberPalAdultTcBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      AppConstants.adult,
      style: TextStyle(
        fontSize: Sizes.textSize12,
        fontWeight: FontWeight.w400,
        color: ColorUtils.blackNeutralColor,
      ),
    );
  }
}
