import 'package:common/core/presentation/components_v2/app_button_v2.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/verified_widget.dart';
import 'package:flutter/material.dart';
import '../styles/app_assets.dart';
import '../styles/color_utils.dart';
import '../styles/sizes.dart';
import '../utils/app_string_constants.dart';
import '../widgets/image_util.dart';
import '../widgets/space.dart';
import 'color_utils_v2.dart';

//hotfix
enum DigilockerStatusEnum {
  NOT_NEEDED,
  SHOW_VIEW,
  VERIFIED,
  PAN_MISSMATCH,
  OTHER_ERROR;

  /// Represents that the API has been called for Verification and Error Received from Server
  bool get hasError => (this == DigilockerStatusEnum.OTHER_ERROR || this == DigilockerStatusEnum.PAN_MISSMATCH);

  bool get hasErrorOrVerified => (hasError) || this == DigilockerStatusEnum.VERIFIED;

  bool get showView => this != DigilockerStatusEnum.NOT_NEEDED;

  bool get isVerified => this == DigilockerStatusEnum.VERIFIED;
}

class DigiLockerWidget extends StatelessWidget {
  // final bool isVerified;
  final Function()? onTap;
  final DigilockerStatusEnum digilockerStatusEnum;

  const DigiLockerWidget({
    super.key,
    this.onTap,
    // required this.isVerified,
    required this.digilockerStatusEnum,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 10, 15),
          decoration: BoxDecoration(
              color: ColorUtils.midgray,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: digilockerStatusEnum.hasError ? ColorUtilsV2.specialDestructive400 : Colors.transparent)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageUtil.load(
                      AssetUtils.logoDigiLocker,
                      fit: BoxFit.fitWidth,
                      height: 16,
                    ),
                    const Space(height: 7,),
                    AppTextV2(
                      //TODO msg logic
                      // data: isVerified ? AppConstants.kycAndAccount : AppConstants.verificationNeeded,
                      data: digilockerStatusEnum.hasErrorOrVerified ? AppConstants.kycAndAccount : AppConstants.verificationNeeded,
                      fontSize: Sizes.textSize12,
                      fontColor: ColorUtilsV2.specialNeutral600,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                      height: 0,
                    ),
                  ],
                ),
              ),
              const Space(width: 9),
              (digilockerStatusEnum == DigilockerStatusEnum.VERIFIED)
                  ? const VerifiedWidget()
                  : AppSecondaryButton(
                    title: 'Proceed',
                    onTap: () => onTap?.call(),
              ),
            ],
          ),
        ),
        if (digilockerStatusEnum.hasError)
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: AppTextV2(
              data: AppConstants.aadharNotMatch,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontColor: ColorUtilsV2.specialDestructive400,
            ),
          )
      ],
    );
  }
}