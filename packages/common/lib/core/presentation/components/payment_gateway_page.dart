import 'package:common/core/infrastructure/dtos/initiate_razorpay_dto.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class PaymentGatewayPage extends StatelessWidget {
  const PaymentGatewayPage({super.key, required this.details});

  final CheckoutDetails details;

  @override
  Widget build(BuildContext context) {
    // final optionData = details.toJson();

    // FIXME: NEED TO PASS DATA THROUGHT OBJECT NOT AS QUERY PARAMS
    // 'packages/common/assets/assets/payment_gateway_razorpay/payment_gateway_razorpay.html',
    final String uri =
        "assets/packages/common/assets/payment_gateway_razorpay/payment_gateway_razorpay.html${details.toUrlParamString()}";

    _launchUrl(uri.toString());
    return Container();
  }

  Future<void> _launchUrl(String url) async {
    if (!await url_launcher.launchUrl(Uri.parse(url),
        mode: url_launcher.LaunchMode.platformDefault,
        webOnlyWindowName: '_self')) {
      throw Exception('Could not launch $url');
    }
  }
}
