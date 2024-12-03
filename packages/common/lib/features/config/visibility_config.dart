import 'package:common/env/env.dart';
import 'package:growthbook_sdk_flutter/growthbook_sdk_flutter.dart';

class VisibilityConfig {
  bool showNPSContribute;
  bool showInsurance;
  bool showMutualFunds;
  bool showNPSContributeSIP;
  bool enableInsuranceBuy;
  bool enableInsuranceAddOns;
  bool enableInsuranceTenureSelection;
  bool enableInsurancePorting;
  bool enableMutualFundBuy;
  bool enableMutualFundSip;
  bool enableFetchRiskAnalysis;
  bool enableAssistVideo;

  VisibilityConfig._({
    this.showNPSContribute = false,
    this.showInsurance = false,
    this.showMutualFunds = false,
    this.showNPSContributeSIP = false,
    this.enableInsuranceBuy = false,
    this.enableInsuranceAddOns = false,
    this.enableInsuranceTenureSelection = false,
    this.enableInsurancePorting = false,
    this.enableMutualFundBuy = false,
    this.enableMutualFundSip = false,
    this.enableFetchRiskAnalysis = false,
    this.enableAssistVideo = false,
  });

// Private constructor

  late final GrowthBookSDK _gb;

  Future<void> setGrowthBookSdkInstance() async {
    _gb = await GBSDKBuilderApp(
      hostURL: 'https://cdn.growthbook.io/',
      apiKey: Env.growthBookApiKey,
      growthBookTrackingCallBack: (gbExperiment, gbExperimentResult) {},
    ).initialize();
    setFeatures();
    return;
  }

  setFeatures() {
    showNPSContribute = _gb.feature("showNPSContribute").on;
    showInsurance = _gb.feature("showInsurance").on;
    showMutualFunds = _gb.feature("showMutualFunds").on;
    showNPSContributeSIP = _gb.feature("showNPSContributeSIP").on;
    enableInsuranceBuy = _gb.feature("enableInsuranceBuy").on;
    enableInsuranceAddOns = _gb.feature("enableInsuranceAddOns").on;
    enableInsuranceTenureSelection =
        _gb.feature("enableInsuranceTenureSelection").on;
    enableInsurancePorting = _gb.feature("enableInsurancePorting").on;
    enableMutualFundBuy = _gb.feature("enableMutualFundBuy").on;
    enableMutualFundSip = _gb.feature("enableMutualFundSip").on;
    enableAssistVideo = _gb.feature("enableAssistVideo").on;
    enableFetchRiskAnalysis = _gb.feature("enableFetchRiskAnalysis").on;
  }

// Static instance variable
  static final VisibilityConfig _instance = VisibilityConfig._();

// Getter for the singleton instance
  static VisibilityConfig get instance => _instance;
}
