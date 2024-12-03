import 'package:common/core/presentation/components_v2/app_snackbar.dart';
import 'package:common/core/presentation/widgets/api_error_widget.dart';
import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:common/core/presentation/widgets/platform_widgets/platform_based_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/reverse_penny_drop/presentation/providers/reverse_penny_drop_provider.dart';
import 'package:common/features/reverse_penny_drop/presentation/widgets/upi_cta_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RpdWidet extends ConsumerWidget {
  final Function? callPaymentStatus;
  const RpdWidet({super.key, this.callPaymentStatus});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rpd = ref.watch(reversePennyDropProvider);
    return rpd.when(
      data: (data) {
        return PlatformBasedWidget(
          android: _androidRPDWidget(context, ref),
          ios: _iosRPDWidget(context, ref),
          other: _iosRPDWidget(context, ref),
        );
      },
      error: (error, stackTrace) => ApiErrorWidget(
        onSuccessHandler: () => ref.invalidate(reversePennyDropProvider),
      ),
      loading: () => const Center(child: CommonTrueFinLoader()),
    );
  }

  void errorToast(BuildContext context) {
    AppSnackBar.show(
        context: context,
        message: "Something went wrong. try another payment mode");
  }

  void initiateRpdPayment(
      BuildContext context, WidgetRef ref, String mode) async {
    try {
      final rdp = ref.read(reversePennyDropProvider.notifier);
      final String? url = rdp.getPaymentLinks(mode);
      if (url != null) {
        callPaymentStatus?.call();
        await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
        // launchURL(url: url, isNewTab: true);
      } else {
        errorToast(context);
      }
    } catch (e) {
      if (context.mounted) errorToast(context);
    }
  }

  UpiCtaWidget _androidRPDWidget(BuildContext context, WidgetRef ref) {
    return UpiCtaWidget(
      iconPath: AssetUtils.bhim,
      label: "UPI apps",
      subTitle: "GooglePay, PhonePe, Paytm and more",
      onTap: () {
        // generalUpiPay
        initiateRpdPayment(context, ref, "generalUpiPay");
      },
    );
  }

  Column _iosRPDWidget(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        UpiCtaWidget(
          iconPath: AssetUtils.phonepe,
          label: "Verify via PhonePay",
          onTap: () {
            // generalUpiPay  phonePe
            initiateRpdPayment(context, ref, "phonePe");
          },
        ),
        const SizedBox(height: 20),
        UpiCtaWidget(
          iconPath: AssetUtils.gpay,
          label: "Verify via GooglePay",
          onTap: () {
            initiateRpdPayment(context, ref, "googlePay");
          },
        ),
        const SizedBox(height: 20),
        UpiCtaWidget(
          iconPath: AssetUtils.paytm,
          label: "Verify via Paytm",
          onTap: () {
            initiateRpdPayment(context, ref, "paytm");
          },
        ),
        const SizedBox(height: 20),
        UpiCtaWidget(
          iconPath: AssetUtils.bhim,
          label: "Verify via bhim",
          onTap: () {
            initiateRpdPayment(context, ref, "bhim");
          },
        ),
      ],
    );
  }
}


  // TextFieldLightGreyBorder(
          //   enableBorderColor: ColorUtilsV2.hex_E5E7EB,
          //   hintText: "Add new UPI ID",
          //   prefixIcon: Padding(
          //     padding: const EdgeInsets.symmetric(
          //         horizontal: 18, vertical: 10),
          //     child: NpsImageUtil.assetImage(
          //         name: NpsAssetUtils.bhim, height: 40, width: 40),
          //   ),
          //   contentPadding:
          //       const EdgeInsets.only(bottom: 10, top: 10, left: 50),
          // ),