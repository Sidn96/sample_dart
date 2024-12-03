import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void popUntilPath(BuildContext context, String routePath, {dynamic extra}) {
  final router = GoRouter.of(context);
  final routerState = GoRouterState.of(context);
  while (routerState.uri.toString() != routePath) {
    if (!router.canPop()) {
      return;
    }

    debugPrint('Popping ${routerState.uri.toString()}');
    Navigator.pop(context, extra);
  }
}

void popUntilPathV1(BuildContext context, String routePath,) {
  final router = GoRouter.of(context);
  var currentRoute = getCurrentRoute(context);
  while (currentRoute != routePath) {
    if (!router.canPop()) {
      return;
    }

    debugPrint('Popping Route: $currentRoute');
    context.pop();
    currentRoute = getCurrentRoute(context);
  }
}

void pushNamedAndRemoveUntil(BuildContext context, String name) {
  final router = GoRouter.of(context);
  while (router.canPop()) {
    router.pop();
  }
  router.replaceNamed(name);
}

void removeAndPushNamed(BuildContext context, String name) {
  final router = GoRouter.of(context);
  while (router.canPop()) {
    router.pop();
  }
  router.pushNamed(name);
}

void removeAndPushReplacementNamed(BuildContext context, String name) {
  final router = GoRouter.of(context);
  while (router.canPop()) {
    router.pop();
  }
  router.pushReplacementNamed(name);
}

String getCurrentRoute(BuildContext context) {
  final router = GoRouter.of(context);

  final RouteMatch lastMatch = router.routerDelegate.currentConfiguration.last;
  final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
      ? lastMatch.matches
      : router.routerDelegate.currentConfiguration;
  final String currentPage = matchList.uri.toString();
  return currentPage;
}
