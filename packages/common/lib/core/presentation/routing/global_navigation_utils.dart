import 'package:common/core/presentation/utils/event_observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GlobalNavigationUtils {
  GlobalNavigationUtils._();

  static final GlobalKey<NavigatorState> care100NavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> rootAppNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> angelNavigatorKey =
      GlobalKey<NavigatorState>();

  static bool isRootAppRunning() {
    return rootAppNavigatorKey.currentContext != null;
  }

  static bool isAngelAppRunning() {
    return angelNavigatorKey.currentContext != null;
  }

  static bool isMemberAppRunning() {
    return care100NavigatorKey.currentContext != null;
  }

  static String getWebAppCurrentPath() {
    return GoRouterState.of(rootAppNavigatorKey.currentContext!).uri.toString();
  }

  static void logoutCurrentApp() {
    if (isMemberAppRunning()) {
      //incase member app running
      AuthEventObserver().addEvent(MemberLogoutEvent());
    } else if (isAngelAppRunning()) {
      //incase angel app running
      AuthEventObserver().addEvent(AngelLogoutEvent());
    } else {
      //for root app
      AuthEventObserver().addEvent(TrueFinLogoutEvent());
    }
  }

/*  static bool isCurrentRouteNPS() {
   //TODO:
  }

  static bool isCurrentRouteInsurance() {
  //TODO:
  }

  static bool isCurrentRouteRC() {
 //TODO:
  }*/
}
