import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/widgets.dart';

class TransformedSquareSpotWidget extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  const TransformedSquareSpotWidget(
      {super.key, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(0),
      child: Transform.rotate(
          angle: 180,
          child: Container(
              width: width ?? 3,
              height: height ?? 3,
              decoration:
                  BoxDecoration(color: color ?? ColorUtils.kGreyLightColor))));
}
