import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/features/my_profile/presentation/providers/get_account_details_api_provider.dart';
import 'package:common/features/my_profile/presentation/widgets/my_profile_email_field.dart';
import 'package:common/features/my_profile/presentation/widgets/my_profile_fields_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyProfileAccountDetails extends HookConsumerWidget {
  const MyProfileAccountDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountDetails = ref.watch(accountDetailsDataProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          data: AppConstants.accountDetails,
          fontSize: Sizes.textSize18,
          fontWeight: FontWeight.w600,
          fontColor: ColorUtils.darkestBlue,
        ),
        const SizedBox(
          height: 20,
        ),
        accountDetails?.isKycVerified ?? false ? Row(
          children: [
             const AppText(
              data: AppConstants.kycVerificationStatus,
              fontSize: Sizes.textSize14,
              fontWeight: FontWeight.w500,
              fontColor: ColorUtils.darkestBlue,
            ),
            const SizedBox(width: 20),
            Container(
              width: 81,
              height: 24,
              decoration: ShapeDecoration(
                color: ColorUtils.greyTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(AssetUtils.kyc,package:"common", width: 15.90, height: 15.74,),
                  const AppText(data: 'Verified', fontSize: 12,fontWeight:FontWeight.w500,fontColor: ColorUtils.kGreenLightColor,)
                ],
              )
            )
          ],
        ) : Container(),
        const SizedBox(
          height: 30,
        ),
        MyProfileFieldsWidget(
            headerText: AppConstants.nameAsOnPan,
            valueText: accountDetails?.fullName),
        const SizedBox(
          height: 30,
        ),
        MyProfileFieldsWidget(
            headerText: AppConstants.panNumber, valueText: accountDetails?.pan),
        const SizedBox(
          height: 30,
        ),
        MyProfileFieldsWidget(
            headerText: AppConstants.mobileNumber,
            valueText: accountDetails?.contactNo),
        const SizedBox(
          height: 30,
        ),
        MyProfileFieldsWidget(
            headerText: AppConstants.dateOfBirth,
            valueText: accountDetails?.dob),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
            height: 70,
            child: MyProfileEmailField(accountDetails?.personalEmail)),
        const SizedBox(
          height: 30,
        ),
        MyProfileFieldsWidget(
            headerText: AppConstants.gender, valueText: accountDetails?.gender),
        const SizedBox(
          height: 30,
        ),
        MyProfileFieldsWidget(
            headerText: AppConstants.maritalStatus,
            valueText: accountDetails?.maritalStatus),
      ],
    );
  }
}
