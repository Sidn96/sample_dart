import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GoToTrueFinStoreLinkComponent extends StatelessWidget {
  const GoToTrueFinStoreLinkComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? Container(
      width: Sizes.screenWidth(),
      decoration: const BoxDecoration(
          color: ColorUtilsV2.hex_1F1F2E,
          image: DecorationImage(
            fit: BoxFit.contain,
              image: AssetImage(
                AppImages.polkaDotsDark,
                package: "common",
          ))),

      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 28,vertical: 20),
        color: ColorUtilsV2.hex_2A2A3D,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: 24.0, right: 24, left: 24, top: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: AppTextV2(
                      data: 'To Download The App\nScan The QR Code',
                      fontSize: Sizes.textSize16,
                      textAlign: TextAlign.start,
                      height: 1.4,
                      fontColor: ColorUtilsV2.hex_C2C2C9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Material(
                    elevation: 4,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                    color: ColorUtilsV2.specialNeutral700,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(AppImages.qrCodeSample,
                          height: 40, package: "common",),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        redirectToStore(
                            Uri.http('play.google.com', '/store/apps/details',
                                {'id': 'com.thetruefin.mobile'}));
                      },
                      child: Image.asset(
                        height: 40,
                        AppImages.playStoreImg,
                        package: "common",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        redirectToStore(Uri.http('apps.apple.com',
                                  '/app/truefin-nps-mutual-funds/id6478929485'));
                            },
                      child: Image.asset(
                        height: 40,
                        AppImages.appStoreImg,
                        package: "common",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ) : const SizedBox.shrink();
  }

  void redirectToStore(Uri uri) {
    launchUrl(uri);
  }
}
