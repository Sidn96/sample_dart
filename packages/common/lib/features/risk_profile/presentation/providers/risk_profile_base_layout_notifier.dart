import 'package:common/core/infrastructure/local_storage_data_source/secure_keys.dart';
import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/risk_profile/infrastructure/dtos/calculate_risk_profile_request_dto.dart';
import 'package:common/features/risk_profile/infrastructure/dtos/calculate_risk_profile_response_dto_custom.dart';
import 'package:common/features/risk_profile/infrastructure/repos/calculate_risk_profile_repo.dart';
import 'package:common/features/risk_profile/presentation/providers/q1_current_age_provider.dart';
import 'package:common/features/risk_profile/presentation/providers/q2_annual_income_provider.dart';
import 'package:common/features/risk_profile/presentation/providers/q3_save_income_provider.dart';
import 'package:common/features/risk_profile/presentation/providers/q4_portfolio_gain_provider.dart';
import 'package:common/features/risk_profile/presentation/providers/q5_loss_bearing_provider.dart';
import 'package:common/features/risk_profile/presentation/screens/q1_current_age_screen.dart';
import 'package:common/features/risk_profile/presentation/screens/q2_annual_income_screen.dart';
import 'package:common/features/risk_profile/presentation/screens/q3_save_income_screen.dart';
import 'package:common/features/risk_profile/presentation/screens/q4_portfolio_gain_screen.dart';
import 'package:common/features/risk_profile/presentation/screens/q5_loss_bearing_screen.dart';
import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'risk_profile_base_layout_notifier.g.dart';

@riverpod
class RiskProfilePageViewNotifier extends _$RiskProfilePageViewNotifier {
  final initialValue = 0;

  List pageViewItem = [
    const RiskProfileStepOneAge(),
    const RiskProfileStep2AnnualIncome(),
    const RiskProfileStep3SaveIncome(),
    const RiskProfileStep4PortfolioGain(),
    const RiskProfileStep5LossBearing(),
  ];

  final PageController pageController = PageController();

  RiskProfilePageViewNotifier();

  @override
  int build() => initialValue;

  void setCurrentPageValue(int pageNo) {
    state = pageNo;
  }

  void clearAllAnswers() {
    ref.read(riskProfileQuestionOneAgeNotifierProvider.notifier).updateValue(0);
    ref
        .read(riskProfileAnswerOneAgeNotifierProvider.notifier)
        .updateAgeValue(21, 30);
    ref.read(selectedUserAgeRPNotifierProvider.notifier).updateAgeValue(-1);

    ref
        .read(riskProfileAnnualIncomeNotifierProvider.notifier)
        .setAnnualSelection(-1);
    ref
        .read(riskProfileSaveIncomeNotifierProvider.notifier)
        .setSaveIncomeSelection(-1);
    ref
        .read(riskProfilePortfolioGainNotifierProvider.notifier)
        .setPortfolioGainSelection(-1);
    ref
        .read(riskProfileLossBearingNotifierProvider.notifier)
        .setLossBearingSelection(-1);
  }
}

@riverpod
class RedirectRiskProfileResult extends _$RedirectRiskProfileResult {
  int resultValue = -1;

  @override
  int build() => resultValue;

  setResponseValue(int responseValue) {
    resultValue = responseValue;
    state = resultValue;
  }
}

///this class should be used for risk profile calculation throughout the app
@riverpod
class RiskProfileApiNotifier extends _$RiskProfileApiNotifier {
  @override
  FutureOr<CalculateRiskProfileResponseDtoCustom?> build() async {
    return null;
  }

  callRiskProfileCalculateApi() async {
    try {
      final selectedCurrentAgeRangeAns =
      ref.watch(riskProfileAnswerOneAgeNotifierProvider);
      final selectedCurrentAgeIndex =
      ref.watch(selectedUserAgeRPNotifierProvider);
      int currentAge = selectedCurrentAgeRangeAns[selectedCurrentAgeIndex];
      String incomeRange = getRiskProfileAnnualIncomeValue();
      String savingRange = getRiskProfileSavingIncomeValue();
      String actionWhenShortTimePortfolioGain =
      getRiskProfilePortfolioGainValue();
      String lossBearingCapacityRange = getRiskProfileLossBearingValue();
      final riskProfileCalculationRepo = ref.watch(riskProfileRepoProvider);

      final getAccessToken =
          await SecureStorage().getPref(key: SecureKeys.accessToken) ?? '';

      if (getAccessToken.isNotEmpty) {
        state = const AsyncValue.loading();
        final data = await riskProfileCalculationRepo.postRiskProfileFlowApi(
            CalculateRiskProfileRequestDto(
                currentAge: currentAge,
                incomeRange: incomeRange,
                savingRange: savingRange,
                actionWhenShortTimePortfolioGain:
                actionWhenShortTimePortfolioGain,
                lossBearingCapacityRange: lossBearingCapacityRange),
            getAccessToken);
        state = AsyncValue.data(data);
        if (data.status == 200) {
          await ref
              .read(redirectRiskProfileResultProvider.notifier)
              .setResponseValue(1);
        }
      } else {
        await ref
            .read(redirectRiskProfileResultProvider.notifier)
            .setResponseValue(0);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String getRiskProfileAnnualIncomeValue() {
    String result = "";
    int index = ref.watch(riskProfileAnnualIncomeNotifierProvider);
    if (index == 0) {
      result = AppConstants.incomeSavingRangeLessThan10;
    } else if (index == 1) {
      result = AppConstants.incomeSavingRangeBetween;
    } else {
      result = AppConstants.incomeSavingRangeMoreThan25;
    }
    return result;
  }

  String getRiskProfileSavingIncomeValue() {
    String result = "";
    int index = ref.watch(riskProfileSaveIncomeNotifierProvider);
    if (index == 0) {
      result = AppConstants.incomeSavingRangeLessThan10;
    } else if (index == 1) {
      result = AppConstants.incomeSavingRangeBetween;
    } else {
      result = AppConstants.incomeSavingRangeMoreThan25;
    }

    return result;
  }

  String getRiskProfilePortfolioGainValue() {
    String result = "";
    int index = ref.watch(riskProfilePortfolioGainNotifierProvider);
    if (index == 0) {
      result = AppConstants.rProfilePortfolioSell;
    } else if (index == 1) {
      result = AppConstants.rProfilePortfolioHold;
    } else {
      result = AppConstants.rProfilePortfolioBuy;
    }

    return result;
  }

  String getRiskProfileLossBearingValue() {
    String result = "";
    int index = ref.watch(riskProfileLossBearingNotifierProvider);
    if (index == 0) {
      result = AppConstants.rProfileLossBearingZero;
    } else if (index == 1) {
      result = AppConstants.rProfileLossBearingBetween;
    } else {
      result = AppConstants.rProfileLossBearingMoreThan20;
    }

    return result;
  }

  //
  Future<void> callGetRiskProfileCalculateApi() async {
    try {
      final riskProfileCalculationRepo = ref.read(riskProfileRepoProvider);

      final data = await riskProfileCalculationRepo.getRiskProfileFlowApi();
      if (data.status == 200) {
        state = AsyncValue.data(data);
      }
    } catch (e) {
      debugPrint("callGetRiskProfileCalculateApi =>  Error common 1: ${e.toString()}");
     // state = AsyncError(e, StackTrace.current);
    }
  }
  
  Future<String> callGetRiskProfileCalculateApi1() async {
    try {
      final riskProfileCalculationRepo = ref.read(riskProfileRepoProvider);

      final data = await riskProfileCalculationRepo.getRiskProfileFlowApi();
      if (data.status == 200) {
        return data.riskData?.riskProfile ?? "";
      }
    } catch (e) {
      debugPrint("callGetRiskProfileCalculateApi =>  Error common 2: ${e.toString()}");
     // state = AsyncError(e, StackTrace.current);
    }
    return "";
  }

  Future<String> getRiskProfileStringFromApi() async {
    return await callGetRiskProfileCalculateApi1();
    // return state.value?.data?.riskProfile ?? '';
  }
}
