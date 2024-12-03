import 'package:common/core/infrastructure/dtos/initiate_razorpay_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_razorpay_web/flutter_razorpay_web.dart';
import 'package:go_router/go_router.dart';
//import 'package:razorpay_web/razorpay_web.dart';

class PaymentGatewayNativePage extends StatefulWidget {
  final Map<String, dynamic> podDetails;

  const PaymentGatewayNativePage({super.key, required this.podDetails});

  @override
  State<PaymentGatewayNativePage> createState() => PaymentGateNativeState();
}

class PaymentGateNativeState extends State<PaymentGatewayNativePage> {
  //late Razorpay _razorpay;
  late RazorpayWeb _razorpayWeb;
  late CheckoutDetails details;
  late String callBackRouteName;

  @override
  void initState() {
    super.initState();
    details = widget.podDetails['checkoutDetails'];
    callBackRouteName = widget.podDetails['callbackRoute'];

    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _razorpayWeb = RazorpayWeb(
      onSuccess: _onSuccess,
      onCancel: _onCancel,
      onFailed: _onFailed,
    );

    openCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
    //_razorpay.clear();
    _razorpayWeb.clear();
  }

  void openCheckout() async {
    var options = {
      'key': details.key,
      'amount': details.amount,
      'currency': details.currency,
      'name': details.name,
      'image': details.image,
      'order_id': details.orderId,
      'callback_url': details.callbackUrl,
      'prefill': {
        'contact': details.prefill.contact,
        'email': null,
        'name': details.prefill.name
      },
      'notes': {'txnNo': details.notes.txnNo},
      'theme': {'color': details.theme.color}
    };

    try {
      // _razorpay.open(options);

      _razorpayWeb.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  // Following methods to call for razorpay_web package
  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   print('Success Response: $response');
  //   //Fluttertoast.showToast(msg: "SUCCESS: ${response.paymentId!}", toastLength: Toast.LENGTH_SHORT);
  // }
  //
  // void _handlePaymentError(PaymentFailureResponse response) {
  //   print('Error Response: $response');
  //   context
  //     ..pop()
  //     ..goNamed(callBackRouteName);
  // }
  //
  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   print('External SDK Response: $response');
  //   // Fluttertoast.showToast(msg: "EXTERNAL_WALLET: ${response.walletName!}", toastLength: Toast.LENGTH_SHORT);
  // }

  void _onSuccess(RpaySuccessResponse response) {}

  void _onCancel(RpayCancelResponse response) {
    print('Error Response -> _onCancel: $response');
    context /*..pop().*/ .goNamed(callBackRouteName);
  }

  void _onFailed(RpayFailedResponse response) {}
}
