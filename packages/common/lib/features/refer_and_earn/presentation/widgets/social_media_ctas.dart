import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:common/features/new_login_register/presentation/components/login_register_component.dart';
import 'package:common/features/new_login_register/presentation/components/truefin_welcome_header.dart';
import 'package:common/features/refer_and_earn/data/dtos/partner_ref_messages_dto.dart';
import 'package:common/features/refer_and_earn/presentation/providers/refer_and_earn_provider.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/glow_button_widget.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/referal_social_ctas.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/utils/login_enums.dart';

class SocailMediaCtas extends ConsumerWidget {
  final PartnerRefMessagesDto? data;
  final Function? onLoginSucess;

  const SocailMediaCtas({super.key, this.data, this.onLoginSucess});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSocial = ref.watch(showSocialCtaNotifierProvider);
    return Stack(
      children: [
        Column(
          children: [
            GlowButtonWidget(
              title: "Share Via Whatsapp",
              iconPath: AppImages.whatsapplogo,
              primaryColor: ColorUtilsV2.hex_4DCA4E,
              onTap: () {
                ShareToSocialHandel().share(
                    source: "whatsapp",
                    message:
                        "*${data?.data?.directMessage?.title}* \n\n ${data?.data?.directMessage?.message}");
              },
            ),
            if (showSocial) ...[
              20.height,
              ReferalSocialCtas(data: data),
            ] else
              20.height,
          ],
        ),
        if (ref.read(loginStatusProvider).value == false)
          Positioned(
            left: 0,
            right: 0,
            child: InkWell(
                onTap: () async {
                  final hasLogged = await getLoginForm(context, ref);
                  if (hasLogged) {
                    ref.refresh(getpartnerRefMessagesProvider);
                  }
                },
                child: const SizedBox(height: 200, width: 300)),
          )
      ],
    );
  }

  Future<bool> getLoginForm(BuildContext context, WidgetRef ref) async {
    bool isLoggedIn = false;
    await showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      backgroundColor: ColorUtilsV2.hex_FFFFFF,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          children: [
            const Align(alignment: Alignment.centerRight, child: CloseButton()),
            const TruefinWelcomeHeaderWidget(
                comingFrom: CommonRouteString.referAndEarnScreen),
            Expanded(
              child: LoginRegisterComponent(
                // height: MediaQuery.of(context).size.height * .7,
                showFeedbackQuotes: true,
                source: LoginFormEnum.truefin,
                comingFrom: CommonRouteString.referAndEarnScreen,
                eventCaller: () {},
                successHandler: () {
                  context.pop();
                  onLoginSucess?.call();
                  isLoggedIn = true;
                },
              ),
            ),
          ],
        );
      },
    );
    return isLoggedIn;
  }
}
