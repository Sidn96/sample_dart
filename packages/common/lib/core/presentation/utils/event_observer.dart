import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class CommonEventClass {}

class MemberLogoutEvent extends CommonEventClass {}
class AngelLogoutEvent extends CommonEventClass {}
class TrueFinLogoutEvent extends CommonEventClass {}

class AuthEventObserver {
  AuthEventObserver._internal();

  static final AuthEventObserver _instance = AuthEventObserver._internal();
  factory AuthEventObserver() => _instance;

  final StreamController<CommonEventClass> _controller =
  StreamController<CommonEventClass>.broadcast();

  void addEvent(CommonEventClass event){
    _controller.add(event);
  }

  void listen(Function(CommonEventClass event) listener){
    _controller.stream.listen(listener);
  }
  

  void disposeManually() {
    debugPrint("EventObserver dispose called");
    _controller.close();
  }
}
