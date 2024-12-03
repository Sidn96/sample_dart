import 'dart:math';

import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/features/new_login_register/domain/entities/user_feedback_quotes_entity.dart';
import 'package:common/features/new_login_register/presentation/notifiers/login_register_user_feedback_quotes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginRegisterUserFeedbackQuotesComponent extends StatelessWidget {
  final LoginFormEnum source;
  const LoginRegisterUserFeedbackQuotesComponent(
      {super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    final List<UserFeedbackQuotesEntity> feedbackQuotesList =
        getLoginRegisterUserFeedbackQuotes(source);
    final randomIndex = getRandomIndex(feedbackQuotesList);
    return feedbackQuotesList.isNotEmpty
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(27),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: ColorUtilsV2.hex_F5F5FF),
              color: ColorUtilsV2.hex_F9FAFB,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AppImages.leftCot,
                    width: 10, package: "common"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: AppText(
                    data: feedbackQuotesList[randomIndex].quotes,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    textAlign: TextAlign.start,
                    fontColor: ColorUtilsV2.hex_717182,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(AppImages.rightCot,
                      width: 10, package: "common"),
                ),
                16.height,
                AppText(
                  data: feedbackQuotesList[randomIndex].author,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  textAlign: TextAlign.start,
                  fontColor: ColorUtilsV2.hex_5D5D70,
                ),
                AppText(
                  data: feedbackQuotesList[randomIndex].authorDesignation,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                  textAlign: TextAlign.start,
                  fontColor: ColorUtilsV2.hex_717182,
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  int getRandomIndex(List list) {
    final random = Random();
    return list.isEmpty ? 0 : random.nextInt(list.length);
  }
}
