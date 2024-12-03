import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/core/presentation/widgets/retire100_images_asset_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../providers/location_permission_handler_provider.dart';

class NoLocationPermissionWidget extends ConsumerWidget {
  final bool forPermenentDenied;

  const NoLocationPermissionWidget(
      {super.key, this.forPermenentDenied = false});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Retire100ImageAssetWidget(
                path: AppImages.nopermissionLogo,
                width: Sizes.screenWidth() * 0.5,
              ),
              const AppText(
                data: "Location Permission Denied",
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              10.height,
              const SizedBox(
                width: 320,
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: TextStyle(
                      color: ColorUtils.midLightGrey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                          text:
                              'Oops! Permission denied again. To fix this, Tap on\n'),
                      TextSpan(
                        text: 'Go to Settings ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                          text:
                              'and allow precise location for\nTruePal app, it will help our Pal find you easily. You can also manually search and set the location pin.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MemberAngelAppButton(
            bttnEnabled: !kIsWeb,
            label: "Go to Settings",
            onSuccessHandler: () {
              if (forPermenentDenied) {
                openAppSettings();
              } else {
                ref
                    .read(locationPermissionHandlerProvider.notifier)
                    .requestLocationPermission();
              }
            },
          ),
          30.height,
        ],
      ),
    );
  }
}
