import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/features/member_pal_login/presentation/widgets/member_name_form_w.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class MemberNameComponent extends StatelessWidget {
  const MemberNameComponent({
    super.key,
    required this.commingFrom,
  });

  final LoginFormEnum? commingFrom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: AppConstants.addName,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.24,
                fontColor: ColorUtils.blackNeutralColor,
              ),
            ],
          ),
          24.height,
          MemberNameFormW(
            commingFrom: commingFrom,
          ),
          20.height,
        ],
      ),
    );
  }
}
