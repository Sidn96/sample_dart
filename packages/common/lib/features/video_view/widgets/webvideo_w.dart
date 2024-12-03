import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebVideoW extends HookWidget {
  final URLRequest? initialUrlRequest;
  final Function(InAppWebViewController, WebUri?)? onLoadStop;
  final Function(InAppWebViewController, int)? onProgressChanged;
  final Function(InAppWebViewController)? onWebViewCreated;

  const WebVideoW({
    super.key,
    this.initialUrlRequest,
    this.onLoadStop,
    this.onProgressChanged,
    this.onWebViewCreated,
  });

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      onLoadStop: onLoadStop,
      onProgressChanged: onProgressChanged,
      onWebViewCreated: onWebViewCreated,
      initialUrlRequest: initialUrlRequest,
    );
  }
}
