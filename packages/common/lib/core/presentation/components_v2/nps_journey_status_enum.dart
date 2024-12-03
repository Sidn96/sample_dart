enum NpsJourneyStatusEnum {
  none,
  // Retail
  contactDetails, //1
  customerDetails, //2
  viewSummaryAndPay, //3
  addNominee, //4
  bankingDetails, //5
  ;

  static NpsJourneyStatusEnum fromString(String? value) {
    return switch (value) {
      "contactDetails" => contactDetails,
      "customerDetails" => customerDetails,
      "viewSummaryAndPay" => viewSummaryAndPay,
      "bankingDetails" => bankingDetails,
      "addNominee" => addNominee,
      null || "" => NpsJourneyStatusEnum.none,
      _ => throw UnimplementedError("$value is not implemented"),
    };
  }
}

extension NpsJourneyStatusEnumExtension on NpsJourneyStatusEnum {
  static List<NpsJourneyStatusEnum> getUiList({bool isCorporate = false}) {
    return isCorporate ? corporateList : retailList;
  }

  int getStage(bool isCorporate) {
    return switch (this) {
      /// Retail stages
      NpsJourneyStatusEnum.contactDetails => 1,
      NpsJourneyStatusEnum.customerDetails => 2,
      NpsJourneyStatusEnum.viewSummaryAndPay => isCorporate ? -1 : 3,
      NpsJourneyStatusEnum.addNominee => isCorporate ? 3 : 4,
      NpsJourneyStatusEnum.bankingDetails => isCorporate ? 4 : 5,
      _ => 0,
    };
  }

  static List<NpsJourneyStatusEnum> get retailList => [
        NpsJourneyStatusEnum.contactDetails,
        NpsJourneyStatusEnum.customerDetails,
        NpsJourneyStatusEnum.viewSummaryAndPay,
        NpsJourneyStatusEnum.addNominee,
        NpsJourneyStatusEnum.bankingDetails,
      ];

  static List<NpsJourneyStatusEnum> get corporateList => [
        NpsJourneyStatusEnum.contactDetails, //1
        NpsJourneyStatusEnum.customerDetails, //2
        NpsJourneyStatusEnum.addNominee, //3
        NpsJourneyStatusEnum.bankingDetails, //4
      ];

  String get uiValue => switch (this) {
        NpsJourneyStatusEnum.contactDetails => 'Contact Details',
        NpsJourneyStatusEnum.customerDetails => 'Customer Details',
        NpsJourneyStatusEnum.viewSummaryAndPay => 'View Summary And Pay',
        NpsJourneyStatusEnum.bankingDetails => "Banking details",
        NpsJourneyStatusEnum.addNominee => "Nominee details",
        _ => "Unknown"
      };

  NpsJourneyStatusEnum nextPage(bool isCorporate) {
    int currentStage = getStage(isCorporate);

    return switch (currentStage) {
      /// 1. Contact Details
      1 => NpsJourneyStatusEnum.customerDetails,

      /// 2. Customer Details
      2 => isCorporate
          ? NpsJourneyStatusEnum.addNominee
          : NpsJourneyStatusEnum.viewSummaryAndPay,

      /// 3. Add Nominee / View Summary And Pay
      3 => isCorporate
          ? NpsJourneyStatusEnum.bankingDetails
          : NpsJourneyStatusEnum.addNominee,

        /// 5. Add Nominee
      4 => isCorporate
            ? NpsJourneyStatusEnum.none
            : NpsJourneyStatusEnum.bankingDetails,
        _ => throw UnimplementedError("This is not valid")
      };
  }
}
