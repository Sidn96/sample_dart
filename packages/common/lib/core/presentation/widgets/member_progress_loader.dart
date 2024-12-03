import 'package:common/core/presentation/common_widgets/truepal_app_loader.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';

class MemberProgressLoader extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Color? txtcolor;
  final Animation<Color>? valueColor;

  const MemberProgressLoader({
    super.key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.black45,
    this.valueColor,
    this.txtcolor,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Stack(
        children: [
          ModalBarrier(dismissible: false, color: color),
          TrupalAppLoader(txtColor: txtcolor ?? ColorUtils.white),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
