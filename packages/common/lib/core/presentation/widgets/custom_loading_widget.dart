import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  final Color color;

  const CustomLoadingWidget({Key? key, this.color = ColorUtils.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
