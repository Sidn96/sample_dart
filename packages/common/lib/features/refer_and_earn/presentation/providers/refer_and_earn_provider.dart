import 'dart:io';

import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/is_login_sign_status.dart';
import 'package:common/features/refer_and_earn/data/dtos/partner_ref_messages_dto.dart';
import 'package:common/features/refer_and_earn/domain/repos/refer_and_earn_repo.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

part 'refer_and_earn_provider.g.dart';

@riverpod
Future<PartnerRefMessagesDto> getpartnerRefMessages(Ref ref) async {
  final isLoggedIn = await ref.read(loginStatusProvider.future);
  if (isLoggedIn) {
    final referRepo = ref.read(referAndEarnRepoProvider);
    final result = await referRepo.getpartnerRefMessages();
    if (result.success == true) {
      ref.read(showSocialCtaNotifierProvider.notifier).changeState(true);
    } else {
      ref.read(showSocialCtaNotifierProvider.notifier).changeState(false);
    }
    MoEngageService().trackEvent(
        eventName: MoEngageEventsConsts
            .eventsNames.truefinreferralhomepagescreenviewed,
        product: ProductEvent.truefin,
        properties: {
          "source": "truefin homepage",
          // "registered_email_available": (result.success ?? false) ? 1 : 0,
          "referral_email_available": (result.success ?? false) ? 1 : 0,
        });
    return result;
  } else {
    return const PartnerRefMessagesDto();
  }
}

@riverpod
Future<bool> sendpartnerRefEmail(Ref ref, {required String emailId}) async {
  final referRepo = ref.read(referAndEarnRepoProvider);
  return await referRepo.sendpartnerRefEmail(emailId: emailId);
}

class ShareToSocialHandel {
  static ShareToSocialHandel instance = ShareToSocialHandel._();
  factory ShareToSocialHandel() => instance;

  ShareToSocialHandel._();

  Future<void> share({required String source, required String message}) async {
    MoEngageService().trackEvent(
        eventName: MoEngageEventsConsts.eventsNames.truefinreferralctaclicked,
        product: ProductEvent.truefin,
        properties: {"selection": "Share on $source"});
    switch (source) {
      case "whatsapp":
        shareTowhatsapp(data: message);
        break;
      case "sms":
        shareToSMS(data: message);
        break;
      case "other":
        await Share.share(message);
        break;
    }
  }

  Future<void> shareToFacebook({required String text, String? imgurl}) async {
    Uri facebookUrl = Uri.parse(
        "https://www.facebook.com/dialog/share?app_id=297762900089261&display=popup&link=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2F&redirect_uri=https://developers.facebook.com/tools/explorer"
        // 'https://www.facebook.com/sharer/sharer.php?u=$imgurl&quote=$text',
        );

    if (await canLaunchUrl(facebookUrl)) {
      await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }

  Future<void> shareToInstagram(
      {required String? message, String? imgurl}) async {
    final Uri instagramUri;
    if (Platform.isAndroid) {
      instagramUri =
          Uri.parse('instagram://stories/share?source=story&url=$imgurl');
    } else if (Platform.isIOS) {
      instagramUri =
          Uri.parse('instagram-stories://share?source=story&url=$imgurl');
    } else {
      throw 'This platform is not supported';
    }

    if (await canLaunchUrl(instagramUri)) {
      await launchUrl(instagramUri);
    } else {
      throw 'Could not launch $instagramUri';
    }
  }

  Future<void> shareToSMS({String? data}) async {
    Uri smsappURl = Uri.parse("sms:?body=$data");
    if (await canLaunchUrl(smsappURl)) {
      await launchUrl(smsappURl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch SMS';
    }
  }

  Future<void> shareTowhatsapp({String? data}) async {
    Uri whatsappURl =
        Uri.parse("https://api.whatsapp.com/send?text=${data ?? ""}");
    if (await canLaunchUrl(whatsappURl)) {
      await launchUrl(whatsappURl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch whatsapp';
    }
  }
}

@riverpod
class ShowSocialCtaNotifier extends _$ShowSocialCtaNotifier {
  @override
  bool build() {
    return false;
  }

  changeState(bool value) => state = value;
}
