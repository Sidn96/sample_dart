import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/risk_profile/domain/enum/risk_profile_enum.dart';
import 'package:common/features/risk_profile/presentation/providers/q1_current_age_provider.dart';
import 'package:common/features/risk_profile/presentation/providers/q2_annual_income_provider.dart';
import 'package:common/features/risk_profile/presentation/providers/q3_save_income_provider.dart';
import 'package:common/features/risk_profile/presentation/providers/q4_portfolio_gain_provider.dart';
import 'package:common/features/risk_profile/presentation/providers/q5_loss_bearing_provider.dart';
import 'package:common/features/risk_profile/presentation/providers/risk_profile_base_layout_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_risk_profile_selections_provider.g.dart';

@riverpod
int getSelectedCurrentAge(GetSelectedCurrentAgeRef ref) {
  final selectedCurrentAgeRangeAns =
      ref.watch(riskProfileAnswerOneAgeNotifierProvider);
  final selectedCurrentAgeIndex = ref.watch(selectedUserAgeRPNotifierProvider);

  return selectedCurrentAgeRangeAns[selectedCurrentAgeIndex];
}

@riverpod
int getSelectedAnnualIncome(GetSelectedAnnualIncomeRef ref) {
  final selectedAnnualIncomeAns =
      ref.watch(riskProfileAnnualIncomeNotifierProvider);
  return selectedAnnualIncomeAns;
}

@riverpod
int getSavingAnnualIncome(GetSavingAnnualIncomeRef ref) {
  final selectedSavingIncomeAns =
      ref.watch(riskProfileSaveIncomeNotifierProvider);
  return selectedSavingIncomeAns;
}

@riverpod
int getPortfolioGain(GetPortfolioGainRef ref) {
  final selectedPortfolioGainAns =
      ref.watch(riskProfilePortfolioGainNotifierProvider);

  return selectedPortfolioGainAns;
}

@riverpod
int getLossBear(GetLossBearRef ref) {
  final selectedLossBearAns = ref.watch(riskProfileLossBearingNotifierProvider);

  return selectedLossBearAns;
}

@riverpod
Map<String, dynamic> getListOfAnswersRiskProfile(
    GetListOfAnswersRiskProfileRef ref) {
  Map<String, dynamic> listOfAnswersRiskProfile = {
    "investments": [],
    "goals": []
  };

  listOfAnswersRiskProfile.addEntries([
    MapEntry(AppConstants.riskProfileCurrentAge,
        ref.watch(getSelectedCurrentAgeProvider)),
    MapEntry(AppConstants.riskProfileIncomeRange,
        ref.watch(getSelectedAnnualIncomeProvider)),
    MapEntry(AppConstants.riskProfileSavingRange,
        ref.watch(getSavingAnnualIncomeProvider)),
    MapEntry(AppConstants.riskProfilePortfolioGain,
        ref.watch(getPortfolioGainProvider)),
    MapEntry(AppConstants.riskProfileLossBearingCapacity,
        ref.watch(getLossBearProvider)),
  ]);

  return listOfAnswersRiskProfile;
}

@riverpod
bool isRiskProfileAnsAllSelected(IsRiskProfileAnsAllSelectedRef ref) {
  bool result = false;

  int annualIncome = ref.watch(riskProfileAnnualIncomeNotifierProvider);
  int saveIncome = ref.watch(riskProfileSaveIncomeNotifierProvider);
  int portfolioGain = ref.watch(riskProfilePortfolioGainNotifierProvider);
  int lossBearing = ref.watch(riskProfileLossBearingNotifierProvider);

  if (annualIncome == -1 ||
      saveIncome == -1 ||
      portfolioGain == -1 ||
      lossBearing == -1) {
    result = false;
  } else {
    result = true;
  }

  return result;
}

@riverpod
RiskProfileRedirection getRiskProfileRedirectionEnum(
    GetRiskProfileRedirectionEnumRef ref) {
  int responseValue = ref.watch(redirectRiskProfileResultProvider);
  if (responseValue == 1) {
    return RiskProfileRedirection.goToResultPage;
  } else if (responseValue == 0) {
    return RiskProfileRedirection.goToLoginPage;
  }

  return RiskProfileRedirection.defaut;
}

@riverpod
bool enableNextButton(EnableNextButtonRef ref) {
  bool result = false;

  int currentPage = ref.watch(riskProfilePageViewNotifierProvider);

  if (currentPage == 0) {
    if (ref.watch(selectedUserAgeRPNotifierProvider) != -1) {
      result = true;
    }
  }
  if (currentPage == 1) {
    if (ref.watch(riskProfileAnnualIncomeNotifierProvider) != -1) {
      result = true;
    }
  }
  if (currentPage == 2) {
    if (ref.watch(riskProfileSaveIncomeNotifierProvider) != -1) {
      result = true;
    }
  }
  if (currentPage == 3) {
    if (ref.watch(riskProfilePortfolioGainNotifierProvider) != -1) {
      result = true;
    }
  }

  if (currentPage == 4) {
    if (ref.watch(riskProfileLossBearingNotifierProvider) != -1) {
      result = true;
    }
  }

  return result;
}
