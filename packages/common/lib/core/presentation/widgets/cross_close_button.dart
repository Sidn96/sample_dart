import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CloseButtonWidget extends HookConsumerWidget {
  final double? iconSize;
  const CloseButtonWidget({super.key, this.iconSize});

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () => context.pop(),
      child: Icon(Icons.close,
          color: ColorUtils.kGreyBorderColor, size: iconSize ?? 30),
    );
  }
}
