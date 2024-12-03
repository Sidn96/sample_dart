import 'package:flutter/material.dart';


//Created an KeepAlivePageView widget to make page-view page alive if we needed
//so that it will not dispose and rebuild the pages again
class KeepAlivePageView extends StatefulWidget {
  final Widget childWidget;

  const KeepAlivePageView({super.key, required this.childWidget});

  @override
  State<KeepAlivePageView> createState() => _KeepAlivePageViewState();
}

class _KeepAlivePageViewState extends State<KeepAlivePageView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.childWidget;
  }

  @override
  bool get wantKeepAlive => true;
}