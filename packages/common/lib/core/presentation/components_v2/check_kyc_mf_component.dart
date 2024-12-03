import 'package:common/core/presentation/components_v2/app_button_v2.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckKycMfComponent extends StatelessWidget {
  const CheckKycMfComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 28),
      color: ColorUtilsV2.hex_2A2A3D,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const AppTextV2(
              data: 'Check Your Mutual Fund\nKYC Status In 3 Easy Steps',
              fontSize: Sizes.textSize22,
              textAlign: TextAlign.center,
              fontColor: ColorUtilsV2.specialBackground200,
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PrimaryAppButtonV2(label: 'Check Now', onTap: () {
                context.pushNamed('check-mutual-fund-kyc-status'); //kyc_status_landing
              }),
            )
          ],
        ),
      ),
    );
  }
}
