import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:common/features/refer_and_earn/presentation/providers/refer_and_earn_provider.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/generate_refer_link_body_widget.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/glow_button_widget.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/social_media_ctas.dart';
import 'package:flutter/material.dart';

class ReferAndShareCta extends HookConsumerWidget {
  final ScrollController? scrollControl;
  const ReferAndShareCta({super.key, this.scrollControl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socialMessages = ref.watch(getpartnerRefMessagesProvider);

    // if user not logged in then show social button but when user press on social buttons show login page
    // and make user logged in then check he has generated the email or not
    // if email is geneated then show social buttons
    // if email is not generated then show generate button

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (ref.read(loginStatusProvider).value == false) {
            ref.read(showSocialCtaNotifierProvider.notifier).changeState(true);
          }
        });
        return null;
      },
    );

    return ref.read(loginStatusProvider).value == false
        ? SocailMediaCtas(onLoginSucess: () => scrollControl?.jumpTo(0.0))
        : socialMessages.when(
            data: (data) {
              if (data.success == false) {
                return GlowButtonWidget(
                  title: "Generate Referral Link",
                  primaryColor: ColorUtilsV2.hex_7375FD,
                  onTap: () {
                    generateReferLinkBottomSheet(context);
                  },
                );
              } else {
                return SocailMediaCtas(data: data);
              }
            },
            error: (error, stackTrace) => const SizedBox.shrink(),
            loading: () => const CircularProgressIndicator(
                backgroundColor: ColorUtilsV2.hex_4E52F8),
          );
  }

  generateReferLinkBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: ColorUtilsV2.purpleDark,
      isScrollControlled: true,
      builder: (context) {
        return const GenerateRefereLinkBodyWidget();
      },
    );
  }
}
