class OverallPortfolioModel {
  final RootPortfolioModel? rootPortfolioModel;
  final ExternalPortfolioModel? externalPortfolioModel;
  final InternalPortfolioModel? internalPortfolioModel;

  OverallPortfolioModel(
      {this.externalPortfolioModel,
      this.internalPortfolioModel,
      this.rootPortfolioModel});
}

class ExternalPortfolioModel {
  final InvestInfoFields? informationFields;

  ExternalPortfolioModel({this.informationFields});
}

class RootPortfolioModel {
  final InvestInfoFields? investInfoFiellds;
  final DateTime? asOfDate;

  RootPortfolioModel({this.investInfoFiellds,this.asOfDate});
}

class InternalPortfolioModel {
  final InvestInfoFields? commonFields;

  InternalPortfolioModel({this.commonFields});
}

class InvestInfoFields {
  final double? totInvested;
  final double? gainLoss;
  final double? xirr;
  final double? currentValue;

  InvestInfoFields({this.totInvested, this.gainLoss, this.xirr, this.currentValue});
}
