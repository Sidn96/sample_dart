import 'package:common/core/presentation/components_v2/app_icon_button.dart';
import 'package:common/core/presentation/utils/enums/common_digilocker_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class DiGiLockerWebView extends StatelessWidget {
  final String? diGiLockerUrl;
  final String redirectUrl;

  const DiGiLockerWebView({
    super.key,
    this.diGiLockerUrl,
    required this.redirectUrl,
  });

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
                  onPressed: () =>
                      context.pop(CommonDiGiLockerStatusEnum.CANCELLED)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InAppWebView(
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url;
                if (uri.toString().toLowerCase() == redirectUrl.toLowerCase()) {
                  context.pop(CommonDiGiLockerStatusEnum.VERIFIED);
                  return NavigationActionPolicy.CANCEL;
                }
                return NavigationActionPolicy.ALLOW;
              },
              initialUrlRequest: URLRequest(url: WebUri(diGiLockerUrl!)),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                userAgent: 'random',
                useShouldOverrideUrlLoading: true,
              )),
              onLoadStart: (controller, uri) {
                if (uri.toString().toLowerCase() == redirectUrl.toLowerCase()) {
                  context.pop(CommonDiGiLockerStatusEnum.VERIFIED);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
