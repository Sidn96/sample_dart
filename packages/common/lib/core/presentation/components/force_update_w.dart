import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../consts/constant_app_strings.dart';
import '../widgets/member_app_button.dart';

class ForceUpdateWidget extends StatelessWidget {
  final String? header;
  final String? description;
  final VoidCallback onButtonClick;

  const ForceUpdateWidget(
      {super.key,
      required this.header,
      required this.description,
      required this.onButtonClick});

  @override
  Widget build(BuildContext context) => Container(
      color: ColorUtils.blackNeutralColor,
      padding: const EdgeInsets.fromLTRB(22.0, 20.0, 22.0, 40.0),
      child: Column(children: [
        const Spacer(),
        SvgPicture.asset(
          AppImages.isolationMode,
          height: 150,
          width: 150,
          package: "common",
        ),
        const SizedBox(height: 30),
        AppText(
            data: header ?? AppStrings.appUpdateHeader,
            textAlign: TextAlign.center,
            fontColor: ColorUtils.specialWarning,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.44),
        const SizedBox(height: 10),
        AppText(
            data: description ?? AppStrings.appUpdateDescription,
            textAlign: TextAlign.center,
            fontColor: ColorUtils.warningCircle,
            fontSize: 14,
            height: 1.4,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.28),
        const Spacer(),
        MemberAngelAppButton(
            bgColor: Theme.of(context).primaryColor,
            onSuccessHandler: onButtonClick,
            label: AppStrings.forceUpdateCTAName)
      ]));
}
