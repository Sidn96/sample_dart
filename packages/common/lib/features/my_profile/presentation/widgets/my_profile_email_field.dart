import 'package:common/core/domain/usecase_error.dart';
import 'package:common/core/infrastructure/dtos/user_info_request_dto.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/widgets/app_text_formfiled.dart';
import 'package:common/features/login_signup/presentation/providers/validator.dart';
import 'package:common/features/my_profile/infrastructure/repo/my_profile_repo.dart';
import 'package:common/features/my_profile/presentation/providers/get_account_details_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyProfileEmailField extends HookConsumerWidget {
  final String? previousEmailId;

  const MyProfileEmailField(this.previousEmailId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isFieldReadOnly = useState(true);
    var isValidEmail = useState(false);
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: AppTextFormFiled(
            autoValidateMode: AutovalidateMode.onUserInteraction,
            controller: ref
                .watch(getAccountDetailsApiNotifierProvider.notifier)
                .emailTextController,
            readOnly: isFieldReadOnly.value,
            onChanged: (textOnChange) {
              isValidEmail.value = Validator.validateEmail(textOnChange);
            },
            validator: (text) {
              if (text != null && text.isNotEmpty && !isValidEmail.value) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  isValidEmail.value = Validator.validateEmail(text);
                });

                return AppUseCasesErrors.enterValidEmail;
              }
              return null;
            },
            maxLength: 50,
            inputDecoration: const InputDecoration(
              counterText: '',
              labelText: AppConstants.email,
              border: UnderlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
            labelStyle: FontStyles.interStyle(
                height: 0.2,
                fontWeight: FontWeight.w400,
                fontSize: Sizes.textSize14,
                textColor: ColorUtils.kGreyLightColor),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 10,
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () async {
              if (isFieldReadOnly.value) {
                isFieldReadOnly.value = false;
              } else {
                isFieldReadOnly.value = true;
                if (isValidEmail.value) {
                  final bool result = await ref
                      .read(myProfileRepoProvider)
                      .updateProfileRepo(UserInfoRequestDto(
                          personalEmail: ref
                              .watch(
                                  getAccountDetailsApiNotifierProvider.notifier)
                              .emailTextController
                              .text));
                  if (!result) {
                    ref
                        .read(getAccountDetailsApiNotifierProvider.notifier)
                        .emailTextController
                        .text = previousEmailId ?? '';
                  }
                }
              }
            },
            child: isFieldReadOnly.value
                ? const Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: ColorUtils.kBlueColor,
                        size: 16,
                      ),
                      AppText(
                        data: AppConstants.edit,
                        fontSize: Sizes.textSize12,
                        fontWeight: FontWeight.w500,
                        fontColor: ColorUtils.kBlueColor,
                      )
                    ],
                  )
                : isValidEmail.value? const Icon(Icons.check, color: ColorUtils.kBlueColor):Container() ,
          ),
        )
        //emailSuffix(isFieldReadOnly.value, isValidEmail.value)
      ],
    );
  }
}
