import 'package:common/core/presentation/components_v2/digilocker_widget.dart';
import 'package:flutter/material.dart';

class DiGiLockerEntryPoint extends StatelessWidget {
  //to show verified indication in place of Proceed button after successful digi-locker journey
  // final bool isDiGiVerified;

  //
  final Function onProceedBtn;
  final DigilockerStatusEnum digilockerStatusEnum;

  const DiGiLockerEntryPoint({
    super.key,
    // this.isDiGiVerified = false,
    required this.onProceedBtn,
    required this.digilockerStatusEnum,
  });

  @override
  Widget build(BuildContext context) {
    return DigiLockerWidget(
      // isVerified: isDiGiVerified,
      digilockerStatusEnum: digilockerStatusEnum,
      onTap: () async {
        onProceedBtn.call();
      },
    );
  }
}
