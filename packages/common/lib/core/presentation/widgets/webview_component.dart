import 'package:common/core/presentation/components/custom_app_bar.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<void> viewFile(BuildContext context, {required String url}) async {
  try {
    await showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        },
        pageBuilder: (context, p1, p2) {
          return WebViewComponent(url: url);
        });
  } catch (_) {}
}

class WebViewComponent extends ConsumerWidget {
  final String url;
  final String? title;
  const WebViewComponent({
    Key? key,
    required this.url,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // bool webLoadingShown = false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: title ?? "",
        backgroundColor: ColorUtils.offWhite,
        leadingIconColor: ColorUtils.blackBluish,
        onLeadingTap: () {
          Navigator.pop(context);
        },
      ),
      body: InAppWebView(
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          return NavigationActionPolicy.ALLOW;
        },
        initialUrlRequest: URLRequest(url: WebUri(url)),
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
        )),
        onLoadStart: (controller, uri) {},
      ),
    );
  }
}
