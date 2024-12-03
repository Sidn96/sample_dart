import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/widgets/cross_close_button.dart';
import 'package:common/core/presentation/widgets/retire100_images_asset_widget.dart';
import 'package:common/features/member_pal_login/presentation/components/login_component.dart';
import 'package:common/features/member_pal_login/presentation/components/name_component.dart';
import 'package:common/features/member_pal_login/presentation/widgets/member_login_cta_button.dart';
import 'package:common/features/member_pal_login/presentation/widgets/member_proceed_cta_button.dart';
import 'package:flutter/material.dart';

ValueNotifier<bool> askName = ValueNotifier<bool>(false);

class MemberLoginRegisterPage extends StatelessWidget {
  final LoginFormEnum? commingFrom;
  final Function()? onResendPressed;
  final Function()? onSendOtpPressed;
  final Function(String)? onSubmit;
  final Function() onProceed;

  const MemberLoginRegisterPage({
    super.key,
    required this.commingFrom,
    this.onResendPressed,
    this.onSendOtpPressed,
    this.onSubmit,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: askName,
            builder: (BuildContext context, bool shouldAskName, Widget? child) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 330,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 310,
                                  width: double.infinity,
                                  child: Retire100ImageAssetWidget(
                                    path: commingFrom == LoginFormEnum.eldercare
                                        ? AppImages.maskgroup
                                        : AppImages.loginMaskGroup,
                                    fit: BoxFit.fill,
                                    package: "common",
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 290),
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  alignment: Alignment.centerRight,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: (shouldAskName)
                                      ? const SizedBox.shrink()
                                      : const CloseButtonWidget(),
                                ),
                              ],
                            ),
                          ),
                          shouldAskName
                              ? MemberNameComponent(commingFrom: commingFrom)
                              : MemberLoginComponent(
                                  commingFrom: commingFrom,
                                  onResendPressed: onResendPressed,
                                  onComplete: onSubmit,
                                ),
                        ],
                      ),
                    ),
                  ),
                  20.height,
                  shouldAskName
                      ? MemberProceedCtaButton(
                          onProceed: onProceed,
                        )
                      : MemberLoginCtaButton(
                          onSendOtpPressed: onSendOtpPressed,
                          onSubmit: onSubmit,
                        ),
                  20.height,
                ],
              );
            }),
      ),
    );
  }
}
