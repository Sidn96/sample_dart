import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalDisclaimerView extends StatelessWidget {
  final String htmlContent;
  const LegalDisclaimerView({super.key, required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(useHybridComposition: true),
          crossPlatform: InAppWebViewOptions(
              transparentBackground: true, useShouldOverrideUrlLoading: true)),
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        var uri = navigationAction.request.url;
        //debugPrint("the uri = $uri");
        if (uri != null) {
          if (await canLaunchUrl(uri)) {
            launchUrl(uri);
            return NavigationActionPolicy.CANCEL;
          }
        }

        return NavigationActionPolicy.ALLOW;
      },
      onWebViewCreated: (controller) {
        controller.loadData(data: """
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
         <style>
        body {
            font-family: 'Manrope', sans-serif;
        }
        </style>
        $htmlContent
        """);
      },
      onLoadStop: (controller, url) {
        controller.evaluateJavascript(source: '''
            document.body.style.paddingLeft = '20px';
            document.body.style.paddingRight = '20px';
          ''');
      },
    );
  }
}
