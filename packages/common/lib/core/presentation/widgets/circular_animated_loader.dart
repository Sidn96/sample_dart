import 'package:common/core/presentation/styles/color_utils.dart';

import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CircularAnimatedLoader extends StatefulHookConsumerWidget {
  final String? headerMessage;
  final String? subHeaderMessage;
  final String? loadingMessage;

  const CircularAnimatedLoader(
      {Key? key,
      this.headerMessage,
      this.subHeaderMessage,
      this.loadingMessage})
      : super(key: key);

  @override
  ConsumerState<CircularAnimatedLoader> createState() =>
      _CircularAnimatedLoaderState();
}

class _CircularAnimatedLoaderState
    extends ConsumerState<CircularAnimatedLoader> {
  @override
  Widget build(BuildContext context) {
    ///animation controller
    final controller = useAnimationController(
      duration: const Duration(seconds: 2),
    );
    controller.repeat();
    return const Material(
      // type: MaterialType.transparency,
      child: Dialog.fullscreen(
          backgroundColor: ColorUtils.white,
          child:
              CommonTrueFinLoaderWithBlur() /*Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextV2(
                        data: widget.headerMessage ?? "",
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    const SizedBox(height: 15),
                    AppTextV2(
                      data: widget.subHeaderMessage ?? "",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 5),
                    AppTextV2(
                        data: widget.loadingMessage ?? "",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 57),
                    AnimatedBuilder(
                      animation: controller,
                      builder: (_, child) {
                        return Transform.rotate(
                          angle: controller.value * 2 * math.pi,
                          child: child,
                        );
                      },
                      child: const AppImage(
                        package: "common",
                        imgPath: AssetUtils.subtractImage,
                        isSvg: false,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),*/
          ),
    );
  }
}
