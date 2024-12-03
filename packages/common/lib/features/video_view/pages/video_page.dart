import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.offWhite,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SizedBox(
        height: 1000,
        child: InAppWebView(
          initialSettings: InAppWebViewSettings(
            useHybridComposition: true,
            useShouldOverrideUrlLoading: true,
            mediaPlaybackRequiresUserGesture: false,
            allowsInlineMediaPlayback: true,
          ),
          initialUrlRequest: URLRequest(
            url: WebUri(
                "https://jump.saleassist.ai/jump/24cbc490-8a75-4c82-a462-86228facd24a"),
          ),
        ),
        // child: WebViewWidget(
        //     controller: WebViewController()
        //       ..setJavaScriptMode(JavaScriptMode.unrestricted)
        //       ..setBackgroundColor(const Color(0x00000000))
        //       ..loadRequest(Uri.parse(
        //           "https://jump.saleassist.ai/jump/24cbc490-8a75-4c82-a462-86228facd24a"))),
      ),
      // body: SizedBox(
      //   height: MediaQuery.sizeOf(context).height,
      //   child: VideoW(
      //     url:
      //         "https://client-static.saleassist.ai/753c6bcf-5464-4fb8-bfdf-5b106937aee4/tf_crf18.mp4",
      //     width: MediaQuery.sizeOf(context).width,
      //     height: MediaQuery.sizeOf(context).height,
      //     showBackButton: true,
      //   ),
      // ),
    );
  }
}
