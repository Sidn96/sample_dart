import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

showProgressBar(ref) {
  ref.read(loadingProvider.notifier).state = true;
}

hideProgressBar(ref) {
  ref.read(loadingProvider.notifier).state = false;
}

final loadingProvider = StateProvider<bool>((ref) => false);

class GlobalLoadingIndicator extends ConsumerStatefulWidget {
  final Widget child;
  final Widget? loadingWidget;
  final Color? overlayColor;

  const GlobalLoadingIndicator(
      {Key? key, required this.child, this.loadingWidget, this.overlayColor})
      : super(key: key);

  @override
  ConsumerState createState() => _GlobalLoadingIndicatorState();
}

class _GlobalLoadingIndicatorState
    extends ConsumerState<GlobalLoadingIndicator> {
  //We need to cache the overlay entries we are showing as part of the indicator in order to remove them when the indicator is hidden.
  final List<OverlayEntry> _entries = [];

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(loadingProvider, (previous, next) {
      // We just want to make changes if the states are different
      if (previous == next) return;
      if (next) {
        // Add a modal barrier so the user cannot interact with the app while the loading indicator is visible
        _entries.add(OverlayEntry(
            builder: (_) => ModalBarrier(
                dismissible: true,
                color: widget.overlayColor ?? const Color(0x4d9CA3AF))));
        _entries.add(OverlayEntry(
            builder: (_) => Center(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: widget.loadingWidget ??
                        const CircularProgressIndicator()))));
        // Insert the overlay entries into the overlay to actually show the loading indicator
        Overlay.of(context).insertAll(_entries);
      } else {
        // Remove the overlay entries from the overlay to hide the loading indicator
        _entries.forEach((e) => e.remove());
        // Remove the cached overlay entries from the widget state
        _entries.clear();
      }
    });
    return widget.child;
  }
}
