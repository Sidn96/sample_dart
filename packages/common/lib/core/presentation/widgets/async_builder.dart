import 'package:flutter/material.dart';

class AsyncBuilder extends StatelessWidget {
  bool unableLoader;
  bool isSuccess;
  Widget successWidget;
  Widget? failureWidget;

  AsyncBuilder({super.key, 
    required this.isSuccess,
    this.unableLoader = false,
    required this.successWidget,
    this.failureWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (unableLoader) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (isSuccess) {
      return successWidget;
    } else {
      return failureWidget ?? Container();
    }
  }
}

///used when we need to show Loader above Stack widget
class StackAsyncBuilder extends StatelessWidget {
  bool isLoader;
  Widget parentWidget;
  Widget loaderWidget;

  StackAsyncBuilder(
      {super.key, required this.isLoader,
        required this.parentWidget,
        this.loaderWidget = const Center(
          child: CircularProgressIndicator(),
        )});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: isLoader,
          child: parentWidget,
        ),
        isLoader
            ? loaderWidget
            : const SizedBox.shrink(),
      ],
    );
  }
}
