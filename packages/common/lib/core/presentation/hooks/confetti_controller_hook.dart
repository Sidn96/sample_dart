import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

ConfettiController useConfettiController() {
  return use(const _ConfettiController());
}

class _ConfettiController extends Hook<ConfettiController> {
  const _ConfettiController();

  @override
  _ConfettiControllerState createState() => _ConfettiControllerState();
}

class _ConfettiControllerState
    extends HookState<ConfettiController, _ConfettiController> {
  final _controller = ConfettiController(duration: const Duration(seconds: 1));

  @override
  ConfettiController build(BuildContext context) => _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
