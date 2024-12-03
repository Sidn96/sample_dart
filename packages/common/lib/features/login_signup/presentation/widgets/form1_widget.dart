import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/widgets/app_text_formfiled.dart';
import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/login_signup/presentation/providers/login_provider.dart';
import 'package:common/features/login_signup/presentation/widgets/app_date_formatter.dart';
import 'package:common/features/login_signup/presentation/widgets/date_picker.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../providers/notifiers/login_signup_notifier.dart';

class Form1Widget extends ConsumerWidget {
  const Form1Widget({
    super.key,
    required this.dobController,
    required this.fullNameController,
  });

  final TextEditingController fullNameController;
  final TextEditingController dobController;

  @override
  Widget build(BuildContext context, ref) {
    final dobValidationNotifier =
        ref.watch(dOBValidationNotifierProvider.notifier);

    final namevalidText = ref.watch(getFullNameErrorMsgProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFormFiled(
          controller: fullNameController,
          labelStyle: _getLableStyle(),
          labelText: AppConstants.loginFullName,
          contentPadding:
              const EdgeInsets.only(left: 2, top: 10, bottom: 10, right: 8),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
          ],
          hintText: '',
          hintHeight: 1.3,
          onChanged: (value) {
            ref
                .read(fullNameValidateNotifierProvider.notifier)
                .validateFullName(value);

            if (value.length > 3 &&
                dobController.text.isNotEmpty &&
                (ref.read(getDOBErrorMsgProvider) == "")) {
              ref
                  .read(enableCtaButtonProvider.notifier)
                  .changeActiveState(true);
            } else {
              ref
                  .read(enableCtaButtonProvider.notifier)
                  .changeActiveState(false);
            }
          },
          enableBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
          ),
          focusBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
          ),
          inputType: TextInputType.name,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppText(
            data: namevalidText,
            fontSize: Sizes.textSize12,
            fontColor: ColorUtils.errorColor,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 40),

        ///dob
        AppTextFormFiled(
          controller: dobController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          labelText: AppConstants.dobLabel,
          hintText: AppConstants.dobHintText,
          inputType: TextInputType.number,
          hintFontWeight: FontWeight.w400,
          inputFormatters: [
            DateTextFormatter(),
            FilteringTextInputFormatter.allow(RegExp('[0-9.,//]'))
          ],
          labelStyle: _getLableStyle(),
          hintHeight: 1.3,
          contentPadding: const EdgeInsets.only(top: 8),
          enableBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
          ),
          focusBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
          ),
          maxLength: 10,
          
          onChanged: (value) {
            dobValidationNotifier.validateDateOfBirth(value);
            if (value.isNotEmpty &&
                fullNameController.text.isNotEmpty &&
                (ref.read(getDOBErrorMsgProvider) == "")) {
              ref
                  .read(enableCtaButtonProvider.notifier)
                  .changeActiveState(true);
            } else {
              ref
                  .read(enableCtaButtonProvider.notifier)
                  .changeActiveState(false);
            }
          },
          suffixIcon: InkWell(
            child: Container(
              padding: const EdgeInsets.only(top: 16, right: 8, bottom: 8),
              child: SvgPicture.asset(
                AssetUtils.iconCalendar,
                package: "common",
              ),
            ),
            onTap: () async {
              var datePicked = await PickDate.selectDate(
                context: context,
                initialDate:
                    DateTime.now().subtract(const Duration(days: (30 * 365))),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (datePicked != null) {
                dobController.text = PickDate.getDateOfString(datePicked) ?? "";
                dobValidationNotifier.validateDateOfBirth(dobController.text);
                if (fullNameController.text.isNotEmpty &&
                    ref.watch(getDOBErrorMsgProvider) == "") {
                  ref
                      .read(enableCtaButtonProvider.notifier)
                      .changeActiveState(true);
                } else {
                  ref
                      .read(enableCtaButtonProvider.notifier)
                      .changeActiveState(false);
                }
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppText(
            data: ref.watch(getDOBErrorMsgProvider),
            fontSize: Sizes.textSize12,
            fontColor: ColorUtils.errorColor,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 20),
        // AppTextFormFiled(
        //   labelText: AppConstants.lpa,
        //   controller: annualController,
        //   labelStyle: FontStyles.interStyle(
        //       height: 0.2,
        //       fontWeight: FontWeight.w400,
        //       fontSize: Sizes.textSize12,
        //       textColor: ColorUtils.kGreyLightColor),
        //   inputFormatters: [
        //     FilteringTextInputFormatter.allow(RegExp('[0-9.,//]'))
        //   ],
        //   enableBorder: const UnderlineInputBorder(
        //     borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
        //   ),
        //   focusBorder: const UnderlineInputBorder(
        //     borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
        //   ),
        // ),
      ],
    );
  }

  _getLableStyle() {
    return FontStyles.interStyle(
      height: 0.2,
      fontWeight: FontWeight.w400,
      fontSize: Sizes.textSize14,
      textColor: ColorUtils.kGreyLightColor,
    );
  }
}
/*  AppTextFormFiled(
          controller: dobController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          labelText: AppConstants.dobLabel,
          hintText: AppConstants.dobHintText,
          inputType: TextInputType.number,
          inputFormatters: [
            DateTextFormatter(),
            FilteringTextInputFormatter.allow(RegExp('[0-9.,//]'))
          ],
          labelStyle: FontStyles.interStyle(
            fontWeight: FontWeight.w400,
            fontSize: Sizes.textSize14,
            textColor: ColorUtils.kGreyBorderColor,
          ),
          contentPadding: const EdgeInsets.only(top: 8, bottom: 10),
          enableBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
          ),
          focusBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
          ),
          maxLength: 10,
          validator: (value) {
            return ref.watch(getDOBErrorMsgProvider).isNotEmpty
                ? ref.watch(getDOBErrorMsgProvider)
                : null;
          },
          onChanged: (value) {
            dobValidationNotifier.validateDateOfBirth(value);
          },
          suffixIcon: InkWell(
            child: Container(
              padding: const EdgeInsets.only(top: 16, right: 8, bottom: 8),
              child: SvgPicture.asset(
                AssetUtils.iconCalendar,
                package: "common",
              ),
            ),
            onTap: () async {
              var datePicked = await PickDate.selectDate(
                context: context,
                initialDate:
                    DateTime.now().subtract(const Duration(days: (30 * 365))),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (datePicked != null) {
                print("Date::$datePicked");
                dobController.text = PickDate.getDateOfString(datePicked) ?? "";
                dobValidationNotifier.validateDateOfBirth(dobController.text);
              }
            },
          ),
        ),*/

//ajay
/*   GestureDetector(
          onTap: () async {
            var datePicked = await PickDate.selectDate(
              context: context,
              initialDate:
                  DateTime.now().subtract(const Duration(days: (30 * 365))),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (datePicked != null) {
              print("Date::$datePicked");
              dobController.text = PickDate.getDateOfString(datePicked) ?? "";
              dobValidationNotifier.validateDateOfBirth(dobController.text);
              if (fullNameController.text.isNotEmpty) {
                ref
                    .read(enableCtaButtonProvider.notifier)
                    .changeActiveState(true);
              }
            }
          },
          child: AppTextFormFiled(
            controller: dobController,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            labelText: AppConstants.dobLabel,
            hintText: AppConstants.dobHintText,
            inputType: TextInputType.number,
            enabled: false,
            inputFormatters: [
              DateTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp('[0-9.,//]'))
            ],
            labelStyle: FontStyles.interStyle(
              fontWeight: FontWeight.w400,
              fontSize: Sizes.textSize14,
              textColor: ColorUtils.kGreyBorderColor,
            ),
            contentPadding: const EdgeInsets.only(top: 8, bottom: 10),
            enableBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
            ),
            focusBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorUtils.kGreyBorderColor),
            ),
            maxLength: 10,
            validator: (value) {
              return ref.watch(getDOBErrorMsgProvider).isNotEmpty
                  ? ref.watch(getDOBErrorMsgProvider)
                  : null;
            },
            onChanged: (value) {
              dobValidationNotifier.validateDateOfBirth(value);
              if (value.isNotEmpty && fullNameController.text.isNotEmpty) {
                ref
                    .read(enableCtaButtonProvider.notifier)
                    .changeActiveState(true);
              }
            },
          ),
        ),*/
