import 'package:flutter/material.dart';

class CustomRoundedTabIndicator extends Decoration {
  CustomRoundedTabIndicator({
    Color color = Colors.white,
    double radius = 2.0,
    double width = 15.0,
    double height = 3.5,
    double bottomMargin = 10.0,
  }) : _painter = _RoundedRectanglePainter(
    color,
    width,
    height,
    radius,
    bottomMargin,
  );

  final BoxPainter _painter;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _RoundedRectanglePainter extends BoxPainter {
  _RoundedRectanglePainter(
      Color color,
      this.width,
      this.height,
      this.radius,
      this.bottomMargin,
      ) : _paint = Paint()
    ..color = color
    ..isAntiAlias = true;

  final Paint _paint;
  final double radius;
  final double width;
  final double height;
  final double bottomMargin;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final centerX = (cfg.size?.width ?? 0) / 2 + offset.dx;
    final bottom = (cfg.size?.height) ?? 0 - bottomMargin;
    final halfWidth = width / 2;
    canvas.drawRRect(
      RRect.fromLTRBR(
        centerX - halfWidth,
        bottom - height,
        centerX + halfWidth,
        bottom,
        Radius.circular(radius),
      ),
      _paint,
    );
  }
}