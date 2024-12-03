import 'package:common/core/presentation/components_v2/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

enum BillDeskStatusEnum {
  CANCELLED, //When user click on cancel button
  VERIFIED, // When redirect URL is triggered
  INTERNAL_ERROR,
  FAILED
}

class BillDeskOrderWebViewPage extends StatelessWidget {
  final String? billDeskUrl;
  final String redirectUrl;

  const BillDeskOrderWebViewPage({
    Key? key,
    this.billDeskUrl,
    required this.redirectUrl,
  }) : super(key: key);

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
                  onPressed: () => context.pop(BillDeskStatusEnum.CANCELLED)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InAppWebView(
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url;
                if (uri.toString().toLowerCase().startsWith(redirectUrl.toLowerCase())) {
                  context.pop([BillDeskStatusEnum.VERIFIED, uri]);
                  return NavigationActionPolicy.CANCEL;
                }
                return NavigationActionPolicy.ALLOW;
              },
              initialUrlRequest: URLRequest(url: WebUri(billDeskUrl!)),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
              )),
              onLoadStart: (controller, uri) {
                if (uri.toString().toLowerCase().startsWith(redirectUrl.toLowerCase())) {
                  context.pop([BillDeskStatusEnum.VERIFIED, uri]);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
