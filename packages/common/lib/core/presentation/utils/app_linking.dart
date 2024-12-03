import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_linking.g.dart';

@Riverpod(keepAlive: true)
class AppLinking extends _$AppLinking {
  @override
  String build() {
    return "";
  }

  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;
  StreamSubscription<Uri>? _sub;

  final AppLinks _appLinks = AppLinks();

  void initialize() {
    _handleIncomingLinks();
    _handleInitialUri();
  }

  void dispose() {
    _sub?.cancel();
  }

  Uri? get getInitialAppLinkingUri => _initialUri;
  Uri? get getLatestAppLinkingUri => _latestUri;
  Object? get getAppLinkingError => _err;

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = _appLinks.uriLinkStream.listen((Uri? uri) {
        print('got uri: $uri');
        _latestUri = uri;
        state = uri.toString();
        _err = null;
      }, onError: (Object err) {
        print('got err: $err');
        _latestUri = null;
        _err = err is FormatException ? err : null;
      });
    }
  }

  Future<void> _handleInitialUri() async {
    try {
      final uri = await _appLinks.getInitialLink();
      _initialUri = uri;
      state = uri.toString();
    } catch (err) {
      if (err is PlatformException) {
        print('failed to get initial uri');
      } else if (err is FormatException) {
        print('malformed initial uri');
        _err = err;
      }
    }
  }
}
