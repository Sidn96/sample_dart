import 'package:common/core/presentation/utils/debouncer.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/bottom_navbar/presentation/providers/bottom_nav_bar_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Debouncer scrollDeBouncer = Debouncer(milliseconds: 200);

class AutomaticHideBottomNavOnScrollWrapper extends ConsumerWidget {
  final Widget child;
  const AutomaticHideBottomNavOnScrollWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.axis == Axis.horizontal) return false;
          if (scrollNotification is ScrollStartNotification) {
          } else if (scrollNotification is ScrollUpdateNotification) {
           /*  scrollDeBouncer.run(() { */
              if (scrollNotification.scrollDelta != null &&
                  scrollNotification.scrollDelta! < 0) {
                //scroll up
                ref
                    .read(bottomNavBarStateNotifierProvider.notifier)
                    .checkAndShowNavBar();
              } else if (scrollNotification.scrollDelta != null &&
                  scrollNotification.scrollDelta! > 0) {
                //scroll down
                /* scrollDeBouncer.run(() { */
                  ref
                      .read(bottomNavBarStateNotifierProvider.notifier)
                      .checkAndHideNavBar();
              /*   }); */
              }
         /*    }); */
          } else if (scrollNotification is ScrollEndNotification) {}
          return true;
        },
        child: child);
  }
}
