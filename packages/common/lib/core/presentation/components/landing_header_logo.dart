import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles/app_assets.dart';
import '../styles/color_utils.dart';
import '../styles/sizes.dart';
import '../utils/app_string_constants.dart';
import '../widgets/app_image.dart';

class LandingFooterLogo extends StatelessWidget {
  final String? footerLogo;
  final String? emailId;
  final String? phoneNumber;
  final bool? isLogoSvg;
  final bool? showCallUsWidget;
  final double width;
  final AlignmentGeometry? connectUsAlignment;

  final double defaultPadding = 20;
  const LandingFooterLogo(
      {Key? key,
      this.footerLogo,
      this.isLogoSvg,
      this.showCallUsWidget,
      this.emailId,
      required this.width,
      this.phoneNumber,
      this.connectUsAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(
          isSvg: isLogoSvg ?? true,
          imgPath: footerLogo ?? AssetUtils.retireNhdfcSvg,
          package: "common",
          showColorFilter: false,
          width: width,
        ),
        const SizedBox(width: 50.0),
        Expanded(
          child: Align(
            alignment: connectUsAlignment ?? Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.connectWithUs,
                  style: FontStyles.poppinsStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Sizes.defaultTextSize,
                    textColor: ColorUtils.kOffWhiteColor,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppConstants.eDashMail,
                      style: FontStyles.interStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Sizes.defaultTextSize,
                        textColor: ColorUtils.kTabDisabledTextColor,
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(
                            "mailto:${emailId ?? AppConstants.formattedEmail}"));
                      },
                      child: Text(
                        emailId ?? AppConstants.supportMailId,
                        style: FontStyles.interStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          textColor: ColorUtils.kGreyLightColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Visibility(
                  visible: showCallUsWidget ?? true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppConstants.callCentreSupport,
                        style: FontStyles.interStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Sizes.defaultTextSize,
                          textColor: ColorUtils.kTabDisabledTextColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                                "tel:${phoneNumber ?? AppConstants.callCentreSupportNo}"),
                          );
                        },
                        child: Text(
                          phoneNumber ?? AppConstants.callCentreSupportNo,
                          style: FontStyles.interStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            textColor: ColorUtils.kGreyLightColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
