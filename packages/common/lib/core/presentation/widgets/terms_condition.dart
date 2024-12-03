import 'package:common/core/presentation/widgets/term_condition_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../extensions/toast_extension.dart';
import 'custom_checkbox.dart';

class TermAndConditionWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final ValueNotifier<bool> iAcceptOnboardTc;

  TermAndConditionWidget({
    required this.phoneController,
    required this.iAcceptOnboardTc,
    super.key,
  });
  final FToast toast = FToast();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Transform.scale(
              scale: 16 / 16,
              child: CustomCheckBox(onChanged: (value) {
                iAcceptOnboardTc.value = !iAcceptOnboardTc.value;
             /*   if (phoneController.text.length == 10) {
                  iAcceptOnboardTc.value = !iAcceptOnboardTc.value;
                } else {
                  showToastMsg(
                      "Please enter mobile number and accept T&C");
                }*/
              },value: iAcceptOnboardTc.value,)
          ),
          const TermAndConditionTextWidget()
        ],
      ),
    );
  }

  void showToastMsg(String message) {
    toast.showToast(
        child: customToastDesign(msg: message),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2));
  }
}