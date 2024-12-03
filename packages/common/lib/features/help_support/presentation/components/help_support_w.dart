import 'package:common/core/domain/common_functions.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/utils/enums/app_type.dart';
import 'package:common/core/presentation/widgets/user_journey_app_bar_widget.dart';
import 'package:common/features/help_support/presentation/providers/help_support_provider.dart';
import 'package:common/features/help_support/presentation/widgets/help_support_tile_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class HelpSupportWidget extends ConsumerWidget {
  final AppType appType;
  const HelpSupportWidget({super.key, required this.appType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.read(helpSupportProvider);
    return Scaffold(
      appBar: const UserJourneyAppBarWidget(title: "Help & Support"),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                data: "Account Help",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 30),
              HelpSupportTilesWidget(
                label: "Reach us",
                description: "Speak to our friendly team",
                imgPath: AppImages.menua,
                metaData: data.email ?? "",
                onMetaDataPressed: () {
                  callAction("mailto:${data.email ?? ""}");
                },
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              HelpSupportTilesWidget(
                label: "Call us",
                description: (appType == AppType.member)
                    ? data.memberTiming ?? ""
                    : data.palTiming ?? "",
                // description: "Anyday from 7:00 am to 8:00 pm",
                imgPath: AppImages.menucallus,
                metaData: (appType == AppType.member)
                    ? data.memberPhoneNumber1 ?? ""
                    : data.partnerPhoneNumber1 ?? "",
                metaData2: (appType == AppType.member)
                    ? data.memberPhoneNumber2
                    : data.partnerPhoneNumber2,
                onMetaDataPressed: () {
                  callAction(
                      "tel:+91${(appType == AppType.member) ? data.memberPhoneNumber1 : data.partnerPhoneNumber1}");
                },
                onMetaData2Pressed: () {
                  callAction(
                      "tel:+91${(appType == AppType.member) ? data.memberPhoneNumber2 : data.partnerPhoneNumber2}");
                },
              ),
              const SizedBox(height: 10),
              // const Divider(),
              // const SizedBox(height: 10),
              // HelpSupportTilesWidget(
              //   label: "Create a Ticket",
              //   description:
              //       "Our support staff will reply in next working hours",
              //   imgPath: UserJourneyAssetsUtils.menuhelp,
              //   metaData: "Raise a new query",
              //   onPressed: () {
              //     callAction(
              //         "https://support.retire100.com/portal/en/newticket?departmentId=94551000000010772&layoutId=94551000000011350");
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void callAction(String action) {
    CommonFunctions commonFunctions = CommonFunctions();
    commonFunctions.navigateToAnyURL(action);
  }
}
