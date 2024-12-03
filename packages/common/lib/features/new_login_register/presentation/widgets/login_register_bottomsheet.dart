import 'package:common/core/presentation/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

Future<dynamic> loginRegisterBottomSheet(BuildContext context, Widget child) {
  return showModalBottomSheet<dynamic>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: false,
    useSafeArea: true,
    elevation: 0,
    backgroundColor: Colors.black12,
    builder: (BuildContext context) {
      return LayoutBuilder(
        builder: (context, boxConstraints) {
          return LoaderOverlay(
            useDefaultLoading: false,
            overlayColor: Colors.black.withOpacity(0.75),
            overlayWidgetBuilder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            child: Center(
              child: SizedBox(
                  width: boxConstraints.maxWidth.clamp(200, 450),
                  child: PopUpBackground(child: child)),
            ),
          );
        },
      );
    },
  );
}


class PopUpBackground extends StatelessWidget {
  final Widget child;
  const PopUpBackground({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: double.infinity,
      height: SizeConfig.screenHeight,
      // padding: const EdgeInsets.only(left: 19, right: 19),
      // decoration: BoxDecoration(
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(20),
      //     topRight: Radius.circular(20),
      //   ),
      //   color: backgroundColor,
      // ),
        color: backgroundColor,
      child: SafeArea(child: child),
    );
  }
}