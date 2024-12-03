import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';

part 'snackbar_message.g.dart';

@Riverpod(keepAlive: true)
SnackBarMessage getSnackBarObject(GetSnackBarObjectRef ref) {
  return SnackBarMessage();
}

class SnackBarMessage {
  void showSuccessSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ));
  }

  void showErrorSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent,
    ));
  }
}
