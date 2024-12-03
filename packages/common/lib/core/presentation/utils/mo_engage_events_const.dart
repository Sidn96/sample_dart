class MoEngageEventsConsts {
  static const eventsNames = _NpsRetailEvents();

  static const eventAttributesKey = _NpsRetailEventKeys();
  static const eventAttributesValue = _NpsRetailEventValues();
  /// NPS Sync Events
  static const npsSyncEvents = _NpsSyncEvents();

  /// NPS Sync Event Properties
  static const npsSyncEventKeys = _NpsSyncEventKeys();

  /// NPS Sync Event Properties Values
  static const npsSyncEventValues = _NpsSyncEventValues();

  /// NPS Contribute Events
  static const npsContributeEvents = _NpsContributeEvents();

  /// NPS Contribute Event Properties
  static const npsContributeEventKeys = _NpsContributeEventKeys();

  /// NPS Contribute Event Properties Values
  static const npsContributeEventValues = _NpsContributeEventValues();

  static const myOrderEventKeys = _MyOrderEventsKeys();
  static const myOrderEventValues = _MyOrderEventsValue();

   static const oneViewEventKeys =   _OneViewEventsKeys();
  static const  oneViewEventValues = _OneViewEventsValue();

  static const horizontalEventsValue = _HorizontalEventsValue();

  MoEngageEventsConsts._();
}


class _HorizontalEventsValue{
   final String truefincontenthomescreenviewed = "truefin_content_home_screen_viewed";
   final String truefinblogscreenviewed = "truefin_blog_screen_viewed";
   final String truefinfaqscreenviewed = "truefin_faq_screen_viewed";
  const _HorizontalEventsValue();
}




class _MyOrderEventsKeys{
   final String journey = "journey";
  const _MyOrderEventsKeys();
}

class _MyOrderEventsValue{
   final String truefinorderstransactionhistoryscreenviewed = "truefin_orders_transaction_history_screen_viewed";
   final String truefinordersdetailscreenviewed = "truefin_orders_detail_screen_viewed";
   final String truefinorderscardclicked = "truefin_orders_card_clicked";
  const _MyOrderEventsValue();
}



class _NpsContributeEventKeys {
  final String state = "state";

  final String contributeScreenViewedKey = "screen_viewed";
  final String selection = "selection";
  // [nps_pran_code<<freeezecode>>_<<cta>>]
  final String reasonCode = "reason_code";

  final String investedAmount = "invested_amount";

  final String npsAccountType = "nps_account_type";
  final String npsMemberType = "nps_member_type";
  final String cra = "cra";
  final String pfm = "pfm";
  final String schemeName = "scheme";
  final String pranStatus = "pran_status";
  final String ageOfMaturity = "age_of_maturity";
  final String npsSipFrequency = "nps_sip_frequency";
  final String corpus = "corpus";
  final String sipStartDate = "sip_start_date";
  final String totalPayable = "total_payable";
  final String sipMode = "sip_mode";

  final String sipAmount = "sip_amount";
  final String nextSipDueDate = "next_sip_due_date";
  const _NpsContributeEventKeys();
}

class _NpsContributeEvents {
  // Event# 20
  final String viewButtonClickedEvent = "nps_view_button_clicked";

  // Event# 20
  final String pranStatusFetchedEvent = "nps_member_pran_status_fetched";

  // Event# 20
  final String viewContributeSuccessfulEvent = "nps_view_Contribute_successful";

  // Event# 24
  final String contributeScreenViewedEvent = "nps_screen_viewed";

  final String npsviewenterdetailsscreenviewed  = "nps_view_enter_details_screen_viewed";


  
  final String npsviewpranstatusactionclicked = "nps_view_pran_status_action_clicked";
  

  // Event# 22
  final String retailContributeCalculatorClickedEvent =
      "nps_retail_contribute_proceed_to_pay_clicked";

  // Event# 22


  // Event# 22  SIP SET UP
  final String retailContributeSipSetupSuccessfulEvent =
      "nps_retail_contribute_sip_setup_successful";

  /// As per new Event Sheet
  final String npsretailcontributepransubmitbuttonclicked ="nps_retail_contribute_pran_submit_button_clicked";


  final String contributePranStatusAction ="nps_contribute_pran_status_action_clicked";
  final String retailContributeInvestNowClicked = "nps_retail_contribute_invest_now_clicked";
  final String retailContributeCalculatorButtonClicked = "nps_retail_contribute_calculator_button_clicked";
  final String npsretailbuyproceedtopayclicked = "nps_retail_buy_proceed_to_pay_clicked";
  final String retailContributeEnterPranScreen = "nps_retail_contribute_enter_pran_screen_viewed";
  final String pranFrozenScreen = "nps_retail_contribute_pran_frozen_screen_viewed";
  final String yourExistingInvestmentScreenString = "nps_retail_contribute_existing_investment_plan_viewed";
  final String contributeCalculationScreenViewed = "nps_retail_contribute_calculator_screen_viewed";
  final String contributeFundSummaryScreenViewed = "nps_retail_contribute_fund_summary_screen_viewed";
  final String lumpsumInvestmentSuccessScreenString = "nps_retail_contribute_lumpsum_payment_success_screen_viewed";
  final String lumpsumInvestmentFailureScreenString = "nps_retail_contribute_lumpsum_payment_failure_screen_viewed";
  final String sipMandateSuccessfulScreenString = "nps_retail_contribute_sip_mandate_success_screen_viewed";
  final String sipMandateFailureScreenString = "nps_retail_contribute_sip_mandate_failure_screen_viewed";
  const _NpsContributeEvents();

}

class _NpsContributeEventValues {
  /// Contribute to NPS
  /// Enter Details Screen
  final String submitPran = "submit pran";

  ///PRAN entry screen
  final String active = "active";

  final String frozen = "frozen";
  /// Your Existing Investment Plan
  final String investNow = "invest now";

  final String tierOne = "tier1"; // tier1, tier 2
  final String tierTwo = "tier 2";
  final String pop = "pop";
  final String nonPop = "non_pop";
  /// Proceed to pay screen

  final String setSipString = "set sip";

  //[60-age,70-age,5,10]
  final String sixtyString = "60-age";

  final String seventyString = "70-age";
  final String fiveString = "5";
  final String tenString = "10";
  //[monthly,quarterly,semi-anually,anually]
  final String monthlyString = "monthly";

  final String quarterlyString = "quarterly";
  final String semiAnuallyString = "semi-anually";
  final String anuallyString = "anually";
  final String proceedToPayLumpsumString = "proceed to pay lumpsum";

  final String proceedToApproveSipMandateString =
      "proceed to approve sip mandate";
  //[upi,e-mandate]
  final String upiString = "upi";

  final String eMandateString = "e-mandate";
  /// SIP successful mandate setup

  //[enter pran screen, contribute to nps,
// pran frozen screens , // typo
// your existing investment plan,
// ,proceed to pay screen
// ,lumpsum investment fund summary
// ,lumpsum investment success Screen,// typo
// lumpsum investment failure screen,
// ,sip investment fund summary
// sip mandate successful screen,
// sip mandate failure screen

  final String enterPranScreenString = "enter pran screen";




  final String sipInvestmentFundSummaryScreenString =
      "sip investment fund summary";

  final String backToHomeString = "back to home";

  const _NpsContributeEventValues();

  }

class _NpsRetailEventKeys {
  //------ new nps events keys --------------------------------------------
  final String journey = "journey";

  final String digilockerverificationstatus = "digilocker_verification_status";
  final String emailverificationstatus = "email_verification_status";
  //------ new nps events keys --------------------------------------------

  final String platform = "platform";
  final String appVersion = "app_version";
  final String deviceType = "device_type";
  final String operatingSystem = "operating_system";
  final String source = "source";
  final String screenViewed = "screen_viewed";
  final String selection = "selection";
  final String npsCalculationType = "nps_calculation_type";
  final String memberAge = "member_age";
  final String investmentAmount = "investment_amount";
  final String goalAmount = "goal_amount";
  final String frequency = "frequency";
  final String targetYears = "target_years";
  final String pfm = "pfm";
  final String scheme = "scheme";
  final String riskProfile = "risk_profile";
  final String investmentOption = "investment_option";
  final String investmentPlan = "investment_plan";
  final String pfmTag = "pfm_tag";
  final String pfmPosition = "pfm_position";
  final String cra = "cra";
  final String initialOneTimeContributionAmount =
      "initial_one_time_contribution_amount";
  final String numberOfNominees = "number_of_nominees";
  final String nomineeRelations = "nominee_relations";
  final String nomineePercentages = "nominee_percentages";
  final String nomineePercentagesFromSnowPlow = "nominee_percentages_snowPlow";
  final String currentAge = "current_age";
  final String ageOfEarning = "age_of_earning";
  final String retirementAge = "retirement_age";
  final String currentIncome = "current_income";
  final String currentExpenses = "current_expenses";
  final String goals = "goals";
  final String selectedPortfolio = "selected_portfolio";
  final String idealPortfolio = "ideal_portfolio";
  final String launchType = "launch_type";
  const _NpsRetailEventKeys();
}

class _NpsRetailEvents {
  //------ new nps events --------------------------------------------
  final String npshomescreenviewed = "nps_home_screen_viewed";

  final String npsretailbuycalculatorsidedrawerviewed = "nps_retail_buy_calculator_side_drawer_viewed";
  final String npsretailbuyaggregatorscreenviewed = "nps_retail_buy_aggregator_screen_viewed";
  final String npsmemberloginscreenviewed = "nps_member_login_screen_viewed";
  final String npsretailbuycustomerdetailsscreenviewed = "nps_retail_buy_customer_details_screen_viewed";
  final String npsretailbuyshortsummaryscreenviewed = "nps_retail_buy_short_summary_screen_viewed";
  final String npsretailbuynomineedetailsscreenviewed = "nps_retail_buy_nominee_details_screen_viewed";
  final String npsretailbuybankingdetailsscreenviewed = "nps_retail_buy_banking_details_screen_viewed";
  final String npsretailbuysummarydetailsscreenviewed = "nps_retail_buy_long_summary_details_screen_viewed";
  final String npsretailbuyprangenerationsuccessscreenviewed  = "nps_retail_buy_pran_generation_success_screen_viewed";
  final String npsretailbuyinitiatedigilockerclicked = "nps_retail_buy_initiate_digilocker_clicked";
  final String npsretailbuysavecustomerdetailsclicked = "nps_retail_buy_save_customer_details_clicked";
  //------ new nps events ------------------------------------------//--

  final String npsScreenViewed = "nps_screen_viewed";
  final String npsHomepageButtonClicked = "nps_homepage_button_clicked";
  final String npsRetailBuyCalculatorClicked =
      "nps_retail_buy_calculator_submit_clicked";
  final String npsRetailBuyButtonClicked = "nps_retail_buy_now_button_clicked";
  final String npsretailbuygeneratepranclicked = "nps_retail_buy_generate_pran_clicked";
  final String npsretailbuyverifybankdetailsclicked = "nps_retail_buy_verify_bank_details_clicked";
  final String npsRetailPaymentSuccessful = "nps_retail_buy_payment_successful";
  final String npsRetailPaymentFailed = "nps_retail_buy_payment_failed";
  final String npsMemberNomineeDetailsAdded =
      "nps_member_nominee_details_added";
  final String npsretailbuysavenomineedetailsclicked = "nps_retail_buy_save_nominee_details_clicked";
  final String npsMemberPranGenerationSuccessful =
      "nps_member_pran_generation_successful";
  final String npsMemberPranGenerationFailed =
      "nps_member_pran_generation_failed";
  final String memberContactVerificationSuccess =
      "member_registration_successful";
  final String membersigninsuccessful = "member_sign_in_successful";
  final String memberLogoutsuccessful = "member_logout_successful";
  final String memberContactVerificationFail = "member_registration_failed";
  final String membersigninfailed = "member_sign_in_failed";
  final String memberKycVerificationSuccess =
      "nps_member_kyc_verification_successful";
  final String memberKycVerificationFail = "nps_member_kyc_verification_failed";
  final String memberDigiLockerVerificationSuccess =
      "nps_member_digilocker_verification_successful";
  final String memberDigiLockerVerificationFail =
      "member_digilocker_verification_failed";
  final String memberEmailVerificationSuccess =
      "member_email_verification_successful";
  final String memberEmailVerificationFail =
      "member_email_verifiication_failed";
  final String npsMemberPranAlreadyExists = "nps_member_pran_already_exists";
  final String npsMemberBankVerificationSuccessful =
      "nps_member_bank_verification_successful";
  final String npsMemberBankVerificationFailed =
      "nps_member_bank_verification_failed";
  //truefin homepage events
  final String truefinScreenViewed = "truefin_screen_viewed";
  final String truefinhomepagescreenviewed = "truefin_homepage_screen_viewed";
  final String memberloginscreenviewed = "member_login_screen_viewed";
  final String truefinhamburgerscreenviewed = "truefin_hamburger_screen_viewed";
  final String truefinfaqscreenviewed = "truefin_faq_screen_viewed";
  final String truefinemailsyncpandobscreenviewed = "truefin_email_sync_pan_dob_screen_viewed";
  final String truefinemailsyncpandobsubmitted = "truefin_email_sync_pan_dob_submitted";
  final String truefininfoscreenviewed = "truefin_info_screen_viewed";
  final String truefinemailsyncsuccess = "truefin_email_sync_success";
  final String truefinloginbuttonclicked = "truefin_login_button_clicked";

  final String truefinHomepageCtaClicked = "truefin_homepage_cta_clicked";
  final String truefinsyncmyinvestmentsctaclicked = "truefin_sync_my_investments_cta_clicked";
  final String truefinhomepageproductknowmorectaclicked = "truefin_homepage_product_know_more_cta_clicked";
  final String truefinhomepageexploremorectaclicked = "truefin_homepage_explore_more_cta_clicked";
  final String appLaunched = "truefin_app_launched";
  final String truefinreferralhomepagescreenviewed = "truefin_referral_homepage_screen_viewed";
  final String truefinreferralhomepagescreenButtonClick = "truefin_referral_homepage_screen_clicked";
  final String truefinreferralctaclicked = "truefin_referral_cta_clicked";
  final String truefinreferralemailsubmitclicked = "truefin_referral_email_submit_clicked";
  const _NpsRetailEvents();
}

class _NpsRetailEventValues {
  //------ new nps events value --------------------------------------------
  final String npsretailbuy = "nps_retail_buy";
  final String npsretailcontribute = "nps_retail_contribute";
  //------ new nps events value --------------------------------------------

  final String npsLandingPage = "nps landing page";

  final String openNPSSideDrawer = "open nps side drawer";
  final String npsAggregatorPage = "nps aggregator page";
  final String contactDetailsPage = "contact details page";
  final String customerDetailsPage = "customer details page";
  final String npsShortSummaryPage = "nps short summary page";
  final String nomineeDetailPage = "nominee detail page";
  final String bankingDetailsPage = "banking details page";
  final String npsSummaryDetailsPage = "nps summary details page";
  final String npsPRANGenerationSuccessPage =
      "nps pran generation success page";
  final String openNPSAccount = "open nps account";

  final String contributeNPS = "contribute to nps";
  final String npsViewCorpus = "nps view corpus";
  final String viewCorpusDownloadStmt = "nps view corpus download stmt";
  final String npsSetSIP = "nps set sip";
  final String npsExploreMoreVideos = "nps explore more videos";
  final String npsExploreMoreBlogs = "nps explore more blogs";
  final String iWishToInvest = "i wish to invest";

  final String iWantToAchieve = "i want to achieve";
  final String buyNow = "nps_retail_buy_now_button_clicked";

  final String high = "high";
  final String medium = "medium";
  final String low = "low";
  final String auto = "auto";
  final String active = "active";
  final String aggressive = "aggressive";
  final String moderate = "moderate";
  final String conservative = "conservative";
  final String bestFit = "best fit";
  final String recommended = "recommended";
  final String proceedToPay = "proceed to pay";

  final String saveNomineeDetails = "save nominee details";
  final String verifyBankDetails = "verify bank details";
  final String generatePRAN = "generate pran";
  final String navigationPanel = "navigation panel";

  final String truefinHomepage = "truefin homepage";
  final String contentCentre = "content centre";
  final String oneViewDashboard = "one view dashboard";
  final String hamburgerMenu = "hamburger menu";
  final String faqs = "faqs";
  final String termsAndConditions = "terms and conditions";
  final String privacyPolicy = "privacy policy";
  final String legalDisclaimer = "legal disclaimer";
  final String serviceCenter = "service center";
  final String services = "services";
  final String checkYourRetirementReadiness = "check your retirement readiness";
  final String npsKnowMore = "nps know more";
  final String syncMyInvestments = "sync my investments";
  final String createRetirementScore = "create retirement score";
  final String currentAge = "current_age";
  final String ageOfEarning = "age_of_earning";
  final String retirementAge = "retirement_age";
  final String currentIncome = "current_income";
  final String currentExpenses = "current_expenses";
  final String newLaunch = "new launch";
  final String background = "background";
  final String initiateDigiLocker = "initiate digilocker verification";
  final String contactNum = "contact_number";
  final String saveCustomerDetails = "save customer details";
  const _NpsRetailEventValues();
}

class _NpsSyncEventKeys {
  final String source = "source";

  final String syncScreenViewedKey = "screen_viewed";
  final String selection = "selection";
  final String reasonCode =
      "reason_code"; //[nps_pran_code<<freeezecode>>_<<cta>>]
  final String npsCorpusAmount = "nps_corpus_amount";
  final String npsMemberType = "nps_member_type";
  final String npsCorpus = "nps_Corpus";
  final String date = "date";
  final String totalContribution = "total_contribution";
  final String returns = "total_returns";
  final String schemeName = "scheme_name";
  final String totalValue = "total_value";
  final String remaningContribution = "remaning_contribution";
  final String selfContribution = "self_contribution";
  final String employerContribution = "employer_contribution";
  final String state = "state";
  const _NpsSyncEventKeys();
}

class _NpsSyncEvents {
  // Event# 20
  final String viewButtonClickedEvent = "nps_sync_submit_details_clicked";

  final String npsviewdownloadstatementclicked = "nps_view_download_statement_clicked";

  final String npsviewcorpusdetailsclicked = "nps_view_corpus_details_clicked";

  final String npsviewpranstatusactionclicked = "nps_view_pran_status_action_clicked";

  // Event# 20
  final String pranStatusFetchedEvent = "nps_member_pran_status_fetched";

  // Event# 20
  final String viewSyncSuccessfulEvent = "nps_view_sync_successful";

  // Event# 24
  final String syncScreenViewedEvent = "nps_view_sync_successful_screen_viewed";

  final String npsViewEnterDetailsScreenViewed = "nps_view_enter_details_screen_viewed";
  

  final String npsviewdetailedsummaryscreenviewed = "nps_view_detailed_summary_screen_viewed";

  final String npsviewdownloadstatementscreenviewed  = "nps_view_download_statement_screen_viewed";

  // Event# 22
  final String retailContributeButtonClickedEvent =
      "nps_retail_contribute_button_clicked";

  final String npsViewFinancialYearSelectionScreenViewed = "nps_view_financial_year_selection_screen_viewed";

  const _NpsSyncEvents();
}

class _NpsSyncEventValues {
  /// Access your Statement
  ///PRAN entry screen
  final String submitPran = "submit pran";

  final String submitPassword = "submit password";
  final String active = "active";

  final String frozen = "frozen";
  /// [pop, non_pop]
  final String pop = "pop";

  final String nonPop = "non_pop";
  /// NPS - View/Sync NPS screen

  final String continueString = "continue";

  final String resetPassword = "reset password";
  final String viewCorpusDetails = "view corpus details";

  /// [ enter pran screen, enter password screen, reset password screen,
  ///  enter otp screen, sync successful screen, view detailed summary screen,
  ///  download statement screen, financial year seceltion screen]
  final String enterPranScreen = "enter pran screen";

  final String enterPasswordScreen = "enter password screen";
  final String resetPasswordScreen = "reset password screen";
  final String enterOtpScreen = "enter otp screen";
  final String syncSuccessfulScreen = "sync successful screen";
  final String viewDetailedSummaryScreen = "view detailed summary screen";
  final String downloadStatementScreen = "download statement screen";
  final String financialYearSelectionScreen = "financial year selection screen";
  /// Account Summary screen

  final String downloadStatement = "download statement";

  /// PRAN Frozen
  /// [contribute now, back to home, try other services, update on cra]
  final String contributeNow = "contribute now";

  const _NpsSyncEventValues();
}

class _OneViewEventsKeys{
  const _OneViewEventsKeys();
}

class _OneViewEventsValue{
   final String truefinoneviewscreenviewed = "truefin_oneview_screen_viewed";
   final String truefinoneviewnpsctaclicked = "truefin_oneview_nps_cta_clicked";
   final String npssyncsubmitdetailsclicked = "nps_sync_submit_details_clicked";
   final String truefinoneviewmfctaclicked = "truefin_oneview_mf_cta_clicked";
   final String truefinoneviewepfctaclicked = "truefin_oneview_epf_cta_clicked";
   final String truefinoneviewhictaclicked = "truefin_oneview_hi_cta_clicked";
   final String truefinoneviewcorpusbreakdownbuttonclicked = "truefin_oneview_corpus_breakdown_button_clicked";
   final String truefinoneviewnotificationctaclicked = "truefin_oneview_notification_cta_clicked";
   final String truefinoneviewprotipsctaclicked = "truefin_oneview_protips_cta_clicked";
   final String truefinoneviewpromoctaclicked = "truefin_oneview_promo_cta_clicked";
   final String truefinoneviewrrrbuttonclicked = "truefin_oneview_rrr_button_clicked";
  const _OneViewEventsValue();
}
