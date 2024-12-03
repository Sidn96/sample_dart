import 'package:common/core/domain/validator.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/member_pal_login/presentation/providers/member_signup_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemberNameFormW extends HookConsumerWidget {
  final LoginFormEnum? commingFrom;
  const MemberNameFormW({super.key, this.commingFrom});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final nameFocus = useFocusNode();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        nameFocus.requestFocus();
        ref
            .read(memberSignUpLoginProvierProvider.notifier)
            .setSource(commingFrom?.value);
      });
      return;
    }, const []);

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        controller: nameController,
        focusNode: nameFocus,
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
        style: const TextStyle(
            color: ColorUtils.bluishblack,
            fontWeight: FontWeight.w700,
            fontSize: 16),
        keyboardType: TextInputType.text,
        onTapOutside: (v) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: const InputDecoration(
          hintText: "Enter Your Name",
          hintStyle: TextStyle(
              color: ColorUtilsV2.hex_9CA3AF,
              fontWeight: FontWeight.w400,
              fontSize: 14),
          labelText: "Name",
          labelStyle: TextStyle(
              color: ColorUtilsV2.hex_9CA3AF, fontWeight: FontWeight.w400),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.ffC2C2C9),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.ffC2C2C9),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.ffC2C2C9),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
        ),
        onChanged: (value) {
          ref
              .read(memberSignUpLoginProvierProvider.notifier)
              .setUserName(value);
        },
        validator: (v) => Validator.isNameValid(v),
      ),
    );
  }
}
