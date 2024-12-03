library ripple_wave_animation;

import 'package:flutter/material.dart';
import 'dart:math' as math show sin, pi, sqrt;

class RippleWaveAnimation extends StatefulWidget {
  const RippleWaveAnimation({
    Key? key,
    this.color = Colors.teal,
    this.duration = const Duration(milliseconds: 1500),
    this.repeat = true,
    required this.child,
    required this.minRadius,
    this.childTween,
    this.animationController,
    this.rippleCount = 1,
  }) : super(key: key);

  ///Color of the ripple
  final Color color;

  ///Widget inside the ripple
  final Widget child;

  /// [double] minimum radius of the animation
  final double minRadius;

  /// Tween effect of the child widget
  final Tween<double>? childTween;

  ///Duration of the animation
  final Duration duration;

  ///Repeat the animation. True by default
  final bool repeat;

  ///optional animation controller to manually start or stop the animation
  final AnimationController? animationController;

  /// handles the animation ripple count
  final int rippleCount;

  @override
  RippleWaveAnimationState createState() => RippleWaveAnimationState();
}

class RippleWaveAnimationState extends State<RippleWaveAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.animationController ??
        AnimationController(duration: widget.duration, vsync: this);
    if (widget.repeat) {
      _controller.repeat();
    } else if (widget.animationController == null) {
      _controller.forward();
      Future.delayed(widget.duration).then((value) => _controller.stop());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomPaint(
      painter: _RipplePainter(_controller,
          rippleCount: widget.rippleCount,
          color: widget.color,
          minRadius: widget.minRadius),
      child: Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: RadialGradient(colors: <Color>[
                    widget.color,
                    Colors.transparent,
                  ])),
                  child: ScaleTransition(
                      scale: widget.childTween != null
                          ? widget.childTween!.animate(CurvedAnimation(
                              parent: _controller, curve: _CurveWave()))
                          : Tween(begin: 0.9, end: 1.0).animate(CurvedAnimation(
                              parent: _controller, curve: _CurveWave())),
                      child: widget.child)))));
}

class _CurveWave extends Curve {
  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return t;
    }
    return math.sin(t * math.pi);
  }
}

class _RipplePainter extends CustomPainter {
  _RipplePainter(this.animation,
      {required this.color, required this.minRadius, required this.rippleCount})
      : super(repaint: animation);

  ///[Color] of the painter
  final Color color;

  ///[double] minimum radius of the painter
  final double minRadius;

  ///[int] number of wave count in the animation
  final int rippleCount;
  final Animation<double> animation;

  /// animating the opacity according to min radius and waves count.
  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color newColor = color.withOpacity(opacity);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 8);
    final Paint paint = Paint()..color = newColor;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 0; wave <= rippleCount; wave++) {
      circle(canvas, rect, wave + animation.value);
    }
  }

  @override
  bool shouldRepaint(_RipplePainter oldDelegate) => true;
}
