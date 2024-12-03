import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonHtmlView extends StatelessWidget {
  final String htmlContent;
  const CommonHtmlView({super.key, required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(useShouldOverrideUrlLoading: true)),
      onWebViewCreated: (controller) {
        controller.loadData(data: htmlContent);
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        var uri = navigationAction.request.url;
        // debugPrint("the uri = $uri");
        if (uri != null) {
          if (await canLaunchUrl(uri)) {
            launchUrl(uri);
            return NavigationActionPolicy.CANCEL;
          }
        }

        return NavigationActionPolicy.ALLOW;
      },
      onLoadStop: (controller, url) {
        // controller.evaluateJavascript(source: '''
        //     document.body.style.paddingLeft = '20px';
        //     document.body.style.paddingRight = '20px';
        //   ''');
      },
    );
  }
}
