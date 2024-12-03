import 'package:common/core/presentation/widgets/whatsapp_term_text_widget.dart';
import 'package:flutter/material.dart';

import 'custom_checkbox.dart';

class WhatsAppTermsWidget extends StatelessWidget {
  const WhatsAppTermsWidget({
    super.key,
    required this.agreeOnboardWhatsApp,
  });

  final ValueNotifier<bool> agreeOnboardWhatsApp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Transform.scale(
              scale: 16 / 16,
              child: CustomCheckBox(
                onChanged: (value) {
                  agreeOnboardWhatsApp.value = !agreeOnboardWhatsApp.value;
                },
                value: agreeOnboardWhatsApp.value,
              )
          ),
          const WhatsAppTermTextWidget(),
        ],
      ),
    );
  }
}