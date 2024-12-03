import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/core/presentation/widgets/text_field_light_grey_border.dart';
import 'package:common/core/presentation/widgets/toast_custom_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/refer_and_earn/presentation/providers/refer_and_earn_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GenerateRefereLinkBodyWidget extends HookConsumerWidget {
  const GenerateRefereLinkBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final isEmailvalid = useState<bool>(false);
    final isLoading = useState<bool>(false);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  bottom: 30,
                  left: 0.0,
                  right: 0.0,
                  child: rippleCircle(
                    height: 400,
                    width: 200,
                    bgColor: ColorUtilsV2.hex_2E3194.withOpacity(0.2),
                  ),
                ),
                Positioned(
                  bottom: 70,
                  left: 0.0,
                  right: 0.0,
                  child: rippleCircle(
                    height: 300,
                    width: 400,
                    bgColor: ColorUtilsV2.hex_3C3EAC.withOpacity(0.2),
                  ),
                ),
                Positioned(
                  bottom: 110,
                  left: 0.0,
                  right: 0.0,
                  child: rippleCircle(
                    height: 200,
                    width: 400,
                    bgColor: ColorUtilsV2.hex_4244B8.withOpacity(0.2),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Image.asset(AppImages.referemaillogo,
                      package: "common", height: 74),
                ),
                const Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: CloseButton(color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const AppTextV2(
                  data: "Email Required",
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  fontColor: Colors.white,
                ),
                const SizedBox(height: 20),
                const AppTextV2(
                  data:
                      "Provide your email to generate the referral link\nand enjoy the benefits of our referral program",
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w300,
                  fontColor: Colors.white,
                ),
                const SizedBox(height: 40),
                TextFieldLightGreyBorder(
                  controller: emailController,
                  label: "Enter Email",
                  labelColor: ColorUtilsV2.hex_FFFFFF,
                  valueColor: ColorUtilsV2.hex_FFFFFF,
                  fillColor: ColorUtilsV2.hex_35354D,
                  enableBorderColor: ColorUtilsV2.hex_5D5D70,
                  focusedBorderColor: ColorUtilsV2.hex_5D5D70,
                  inputType: TextInputType.emailAddress,
                  onChanged: (value) {
                    final isValid = validateEmail(value);
                    if (isValid != null) {
                      isEmailvalid.value = false;
                    } else {
                      isEmailvalid.value = true;
                    }
                  },
                  validator: (value) {
                    final isValid = validateEmail(value);
                    return isValid;
                  },
                ),
                const SizedBox(height: 10),
                const AppTextV2(
                  data:
                      "Please enter the correct email to ensure you receive your voucher",
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  fontColor: ColorUtilsV2.hex_C2C2C9,
                ),
                const SizedBox(height: 30),
                isLoading.value
                    ? const CircularProgressIndicator(
                        color: ColorUtilsV2.hex_4E52F8)
                    : MemberAngelAppButton(
                        label: "Submit",
                        textColor: ColorUtilsV2.hex_FFFFFF,
                        bgDisableColor:
                            ColorUtilsV2.hex_4E52F8.withOpacity(0.3),
                        bgColor: ColorUtilsV2.hex_4E52F8,
                        bttnEnabled: isEmailvalid.value,
                        onSuccessHandler: () async {
                          isLoading.value = true;
                          MoEngageService().trackEvent(
                              eventName: MoEngageEventsConsts.eventsNames
                                  .truefinreferralemailsubmitclicked,
                              product: ProductEvent.truefin);
                          final result = await ref.read(
                              sendpartnerRefEmailProvider(
                                      emailId: emailController.text)
                                  .future);
                          if (result) {
                            ref.refresh(getpartnerRefMessagesProvider);
                            context.pop();
                          } else {
                            showToastBox(context,
                                message: AppConstants.somethingWrong);
                          }
                          isLoading.value = false;
                        },
                      ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget rippleCircle({
    required Color bgColor,
    double? height,
    double? width,
  }) =>
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
      );

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
