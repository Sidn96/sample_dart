import 'dart:async';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/presentation/utils/riverpod_framework.dart';

part 'new_login_notifiers.g.dart';

@riverpod
class LoginShowSendOtp extends _$LoginShowSendOtp {
  @override
  bool build() {
    return false;
  }

  changeActiveState(bool val) {
    state = val;
  }
}

@riverpod
class LoginEnableCtaButton extends _$LoginEnableCtaButton {
  @override
  bool build() {
    return false;
  }

  changeActiveState(bool val) {
    state = val;
  }
}

@riverpod
class LoginEnableCtaButtonText extends _$LoginEnableCtaButtonText {
  @override
  String build() {
    return "Next";
  }

  changeActiveState(String val) {
    state = val;
  }
}

@riverpod
class UserName extends _$UserName {
  @override
  String build() {
    return "User";
  }
  update(value){
    state = value;
  }

}

@riverpod
class IsLoading extends _$IsLoading {
  @override
  bool build() {
    return false;
  }

  void setLoading(bool value) {
    state = value;
  }
}



