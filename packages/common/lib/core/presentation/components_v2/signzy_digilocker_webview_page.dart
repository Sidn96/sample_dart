import 'package:common/core/presentation/components_v2/app_icon_button.dart';
// import 'package:common/core/presentation/utils/enums/common_digilocker_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

enum SignzyDigilockerStatusEnum {
  CANCELLED, //When user click on cancel button
  VERIFIED, // When redirect URL is triggered
  INTERNAL_ERROR
}

class SignzyDigiLockerWebView extends StatelessWidget {
  final String? signzyDigilockerUrl;
  final String redirectUrl;

  const SignzyDigiLockerWebView({
    Key? key,
    this.signzyDigilockerUrl,
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
                  onPressed: () =>
                      context.pop(SignzyDigilockerStatusEnum.CANCELLED)),
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
                  context.pop(SignzyDigilockerStatusEnum.VERIFIED);
                  return NavigationActionPolicy.CANCEL;
                }
                return NavigationActionPolicy.ALLOW;
              },
              initialUrlRequest: URLRequest(url: WebUri(signzyDigilockerUrl!)),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                userAgent: 'random',
                useShouldOverrideUrlLoading: true,
              )),
              onLoadStart: (controller, uri) {
                if (uri.toString().toLowerCase().startsWith(redirectUrl.toLowerCase())) {
                  context.pop(SignzyDigilockerStatusEnum.VERIFIED);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
