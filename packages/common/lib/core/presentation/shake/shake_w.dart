import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShakeWController {
  late void Function() shake;
}

ShakeWController useShakeController(AnimationController controller) {
  // Custom hook to return a controller that can trigger the shake
  final shakeController = useMemoized(() {
    return ShakeWController();
  });

  // Function to shake the widget
  void shake() {
    controller.forward(from: 0.0);
  }

  // Connect shake function to controller
  shakeController.shake = shake;

  // Return the controller
  return shakeController;
}

class ShakeW extends HookWidget {
  final Widget child;
  final Duration duration;
  final ShakeWController controller;

  const ShakeW({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create animation controller using hooks
    final animationController = useAnimationController(duration: duration);
    
    // Create shake animation
    final animation = useMemoized(() {
      return Tween<double>(begin: 0.0, end: 20.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease),
      );
    }, [animationController]);

    // Set up status listener to reverse animation after completion
    useEffect(() {
      animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });
      return null;
    }, [animationController]);

    // Connect the controller to shake function
    controller.shake = () {
      animationController.forward(from: 0.0);
    };

    // Build the widget with animation
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(animation.value, 0),
          child: this.child,
        );
      },
      child: child,
    );
  }
}
