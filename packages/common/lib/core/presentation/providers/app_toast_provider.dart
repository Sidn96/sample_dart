import 'package:common/core/presentation/extensions/toast_extension.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'app_toast_provider.g.dart';

@Riverpod(keepAlive: true)
FToast getToastObject(GetToastObjectRef ref, BuildContext context) {
  return FToast().init(context);
}

@riverpod
showToast(ShowToastRef ref,
    {required String toastMsg,
    required BuildContext context,
    Widget? child,
    int? second}) {
  final toast = ref.watch(getToastObjectProvider(context));
  return toast.showToast(
      child: child ?? customToastDesign(msg: toastMsg),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: second ?? 2));
}
