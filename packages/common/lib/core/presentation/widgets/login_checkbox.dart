import 'package:common/core/domain/checkbox_value_enum.dart';
import 'package:common/core/presentation/providers/notifiers/login_notifiers.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:common/core/presentation/widgets/checkbox.dart';

class LoginCheckBoxMolecule extends HookConsumerWidget {
  const LoginCheckBoxMolecule({super.key,this.isRemembered = true});
final bool isRemembered;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              AppCheckBox(
                  // checkboxTextAlignment: CrossAxisAlignment.center,
                  onChange: (value) {
                    ref
                        .read(checkTermsAndConditionNotifierProvider.notifier)
                        .changeCheckBoxValue(value);
                  },
                  isNormalText: false,
                  checkBoxValue: CheckboxValue.termsAndCondition,
                  changedValue:
                  ref.watch(checkTermsAndConditionNotifierProvider)
              ),
              //    SizedBox(height: 2),
              AppCheckBox(
                // checkboxTextAlignment: CrossAxisAlignment.center,
                onChange: (value) {
                  ref
                      .read(checkWhatsAppNotifierProvider.notifier)
                      .changeCheckBoxValue(value);
                },
                isNormalText: false,
                checkBoxValue: CheckboxValue.whatsApp,
                changedValue:
                ref.watch(checkWhatsAppNotifierProvider),
              ),
              //   SizedBox(height: 2),
              Visibility(
                visible: isRemembered,
                child: AppCheckBox(
                  onChange: (value) {
                    ref
                        .read(checkRememberMeNotifierProvider.notifier)
                        .changeCheckBoxValue(value);
                  },
                  isNormalText: true,
                  normalText: AppConstants.rememberMe,

                  changedValue: ref.watch(checkRememberMeNotifierProvider),
                ),
              ),
            ],
          ),
        );

  }
}
