import 'package:common/core/presentation/components_v2/app_icon_button.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

Future<void> openRazorpayInBottomSheet(
  BuildContext context, {
  required Map<String, dynamic> checkoutDetails,
  Function(PaymentSuccessResponse)? successCallback,
  Function(PaymentFailureResponse)? errorCallback,
  VoidCallback? cancelCallback,
}) async {
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    enableDrag: false,
    useRootNavigator: false,
    isScrollControlled: true,
    barrierColor: Colors.black.withOpacity(0.8),
    builder: (dialogContext) {
      return AppBottomSheet(
        topLeftRadius: 0.0,
        topRightRadius: 0.0,
        childWidget: Column(
          children: [
            SizedBox(
              height: kToolbarHeight * 1.2,
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: AppIconButton.cancel(onPressed: () {
                    cancelCallback?.call();
                    context.pop();
                  }),
                ),
              ),
            ),
            CommonRazorPayWidget(
                checkoutDetails: checkoutDetails,
                successCallback: (successResponse) {
                  debugPrint("**SUCCESS**");
                  successCallback?.call(successResponse);
                  if (context.canPop()) context.pop();
                },
                errorCallback: (errorResponse) {
                  debugPrint("**ERROR**");
                  errorCallback?.call(errorResponse);
                  if (context.canPop()) context.pop();
                }),
          ],
        ),
      );
    },
  );
}

class CommonRazorPayWidget extends HookWidget {
  final Map<String, dynamic> checkoutDetails;
  final Function(PaymentSuccessResponse)? successCallback;
  final Function(PaymentFailureResponse)? errorCallback;

  const CommonRazorPayWidget({
    super.key,
    required this.checkoutDetails,
    this.successCallback,
    this.errorCallback,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("CommonRazorPayWidget");
    var razorpayValueNotifier = useValueNotifier<Razorpay?>(null);

    useEffect(() {
      razorpayValueNotifier.value = Razorpay();

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _startPaymentFlow(razorpayValueNotifier.value!);
      });

      return () => razorpayValueNotifier.value?.clear();
    }, []);

    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Lottie.asset(AssetUtils.loaderLottie,
              width: 50.0, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }

  _startPaymentFlow(Razorpay razorpay) {
    try {
      checkoutDetails.remove("callback_url");
      razorpay.open(checkoutDetails);
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) => successCallback?.call(response));
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) => errorCallback?.call(response));
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
          (ExternalWalletResponse response) => {});
    } catch (error) {
      debugPrint("Razorpay Error: $error");
    }
  }
}
