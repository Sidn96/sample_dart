import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/features/refer_and_earn/data/dtos/partner_ref_messages_dto.dart';
import 'package:common/features/refer_and_earn/presentation/providers/refer_and_earn_provider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ReferalSocialCtas extends StatelessWidget {
  final PartnerRefMessagesDto? data;
  const ReferalSocialCtas({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final message =
        "${data?.data?.directMessage?.title} \n\n ${data?.data?.directMessage?.message}";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 30),
        // // facebook
        // socialIconButton(
        //   logoPath: AppImages.fblogo,
        //   onPressed: () {
        //     ShareToSocialHandel().shareToFacebook(
        //         text: message,
        //         imgurl:
        //             "https://assets.techrepublic.com/uploads/2020/04/new-microsoft365-logo-horiz-c-gray-rgb.jpg");
        //   },
        // ),
        // // instagram
        // socialIconButton(
        //   logoPath: AppImages.instalogo,
        //   onPressed: () {
        //     ShareToSocialHandel().shareToInstagram(
        //         message: message,
        //         imgurl:
        //             "https://assets.techrepublic.com/uploads/2020/04/new-microsoft365-logo-horiz-c-gray-rgb.jpg");
        //   },
        // ),
        // sms
        socialIconButton(
          logoPath: AppImages.mssglogo,
          onPressed: () {
            ShareToSocialHandel().share(source: "sms", message: message);
          },
        ),
        // normal share
        socialIconButton(
          logoPath: AppImages.sharelogo,
          onPressed: () async {
            await ShareToSocialHandel().share(source: "other", message: message);
          },
        ),
        const SizedBox(width: 30),
      ],
    );
  }

  IconButton socialIconButton({
    required String logoPath,
    Function()? onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(
        logoPath,
        package: "common",
        height: 36,
      ),
    );
  }
}
