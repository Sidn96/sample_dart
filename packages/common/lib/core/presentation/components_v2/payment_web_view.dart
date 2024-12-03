import 'package:common/core/presentation/components_v2/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String? paymentUrl;
  final String redirectUrlKeyword;

  const PaymentWebView({
    Key? key,
    this.paymentUrl,
    required this.redirectUrlKeyword,
  }) : super(key: key);

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {

  late WebViewController myController;

  @override
  void initState() {
    myController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            var uri = request.url;
            debugPrint("got uri = $uri");
            if (uri.toString().toLowerCase().contains(widget.redirectUrlKeyword)) {
              context.pop("verified");
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl ??""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: kToolbarHeight * 1.2,
          child: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Align(
              alignment: Alignment.bottomRight,
              child: AppIconButton.cancel(
                  onPressed: () => context.pop("cancelled")),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: WebViewWidget(
              controller: myController,
              /*shouldOverrideUrlLoading: (controller, navigationAction) async {
                // var uri = navigationAction.request.url;
                // debugPrint("got uri = $uri");
                // if (uri.toString().toLowerCase() == redirectUrl.toLowerCase()) {
                //   context.pop("verified");
                //   return NavigationActionPolicy.CANCEL;
                // }
                return NavigationActionPolicy.ALLOW;
              },
              initialUrlRequest: URLRequest(url: Uri.parse(widget.paymentUrl!)),
              initialOptions: InAppWebViewGroupOptions(
                android: AndroidInAppWebViewOptions(
                  useHybridComposition: false,
                  useWideViewPort: true,

                ),
                  crossPlatform: InAppWebViewOptions(
                    preferredContentMode: UserPreferredContentMode.RECOMMENDED,
                    userAgent: 'random',
                    useShouldOverrideUrlLoading: true,
                  )),
              onLoadStart: (controller, uri) {
                if (uri.toString().toLowerCase() == widget.redirectUrl.toLowerCase()) {
                  context.pop("verified");
                }
              },*/
            ),
          ),
        ),
      ],
    );
  }
}
