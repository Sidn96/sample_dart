import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/widgets/image_util.dart';
import 'package:flutter/material.dart';

class CommonPopUpMenuButton extends StatelessWidget {
  final dynamic initialValue;
  final List<dynamic> items;
  final Function(dynamic) callback;

  const CommonPopUpMenuButton({
    super.key,
    required this.initialValue,
    required this.items,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      onSelected: callback,
      itemBuilder: (BuildContext context) {
        return items
            .map((e) => PopupMenuItem(
                  height: 36,
                  value: e,
                  child: Text(e.toString()),
                ))
            .toList();
      },
      offset: const Offset(0, 18),
      child: ImageUtil.load(AssetUtils.iconMenu),
    );
  }
}