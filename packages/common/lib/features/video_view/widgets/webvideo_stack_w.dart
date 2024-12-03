import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/video_view/widgets/video_w.dart';
import 'package:flutter/material.dart';

class WebVideoStackW extends HookWidget {
  final VoidCallback? rebuild;
  final double width;
  final double height;
  const WebVideoStackW({
    super.key,
    this.rebuild,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final showLoading = useState(true);
    // late InAppWebViewController webViewController;
    return SizedBox(
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // WebVideoW(
          //   onLoadStop: (controller, url) async {
          //     showLoading.value = false;
          //     rebuild?.call();

          //     //           await controller.evaluateJavascript(source: """
          //     //   // Ensure that the document and video element are loaded
          //     //   const video = document.querySelector('video');
          //     //   if (video) {
          //     //     video.muted = !video.muted;  // Toggle mute state
          //     //   }
          //     // """);
          //   },
          //   onProgressChanged: (_, progress) {
          //     if (progress >= 99) {
          //       showLoading.value = false;
          //       rebuild?.call();
          //     }
          //   },
          //   onWebViewCreated: (controller) {
          //     // webViewController = controller;
          //     // controller.callAsyncJavaScript(
          //     //     functionBody:
          //     //         "document.querySelector('video').muted = !document.querySelector('video').muted;");
          //     // controller.callAsyncJavaScript(functionBody: functionBody)
          //   },
          //   initialUrlRequest: URLRequest(
          //       url: WebUri(
          //           "https://jump.saleassist.ai/jump/24cbc490-8a75-4c82-a462-86228facd24a")),
          // ),

          VideoW(
              url:
                  "https://client-static.saleassist.ai/753c6bcf-5464-4fb8-bfdf-5b106937aee4/tf_crf18.mp4",
              width: width,
              height: height),

          // GestureDetector(
          //   onTap: () async {
          //     print("webview tap");
          //     // await webViewController.evaluateJavascript(
          //     //     source:
          //     //         "document.querySelector('video').muted = !document.querySelector('video').muted;");

          //     // webViewController.addJavaScriptHandler(
          //     //     handlerName: "video",
          //     //     callback: (_) {
          //     //       return "document.querySelector('video').muted = !document.querySelector('video').muted;";
          //     //     });
          //   },
          //   child: Container(
          //     color: Colors.transparent,
          //     height: 240,
          //   ),
          // ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Container(
          //     color: Colors.white,
          //     height: 14,
          //   ),
          // )
          // if (showLoading.value)
          //   const CircularProgressIndicator(
          //     color: ColorUtils.blueishPurpleColor,
          //   ),
        ],
      ),
    );
  }
}
