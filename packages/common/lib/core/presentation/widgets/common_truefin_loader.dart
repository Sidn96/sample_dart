import 'dart:ui';

import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonTrueFinLoader extends StatelessWidget {
  const CommonTrueFinLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(AssetUtils.loaderLottie,width: 50.0,fit: BoxFit.fitWidth),
    );
  }
}


class CommonTrueFinLoaderWithBlur extends StatelessWidget {
  final double? height;
  const CommonTrueFinLoaderWithBlur({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Container(
        color: Colors.white.withOpacity(0.5),
        // height: height ?? MediaQuery.sizeOf(context).height * 0.75,
        height: height,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Center(
            child: Lottie.asset(AssetUtils.loaderLottie,
                width: 70.0, fit: BoxFit.fitWidth),
          ),
        ),
      ),
    );
  }
}
