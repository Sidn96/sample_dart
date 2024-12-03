import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mf_pod/presentation/features/check_your_kyc/data/kyc_status_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/analysis_quadrant_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/overall_portfolio_model.dart';

part 'mf_sync_dashboard_dto.freezed.dart';
part 'mf_sync_dashboard_dto.g.dart';

class MfSyncDashboardApiDto {
  final List<AmcScheme>? schemes;
  final DateTime? lastSync;
  final String? camsKycModificationLink;
  final KycStatusEnum kycStatus;
  final Portfolio? overallPortfolio;
  final Portfolio? externalPortfolio;
  final Portfolio? internalPortfolio;

  const MfSyncDashboardApiDto(
      {this.schemes,
      this.lastSync,
      this.camsKycModificationLink,
      this.kycStatus = KycStatusEnum.none,
      this.externalPortfolio,
      this.internalPortfolio,
      this.overallPortfolio});

  factory MfSyncDashboardApiDto.fromJson(Map<String, dynamic> json) {
    return MfSyncDashboardApiDto(
      schemes: AmcScheme.fromJsonList(json["schemes"]),
      lastSync: json['lastSync'] == null
          ? null
          : DateTime.parse(json['lastSync'] as String),
      camsKycModificationLink: json["camsKycModificationLink"] ?? "",
      kycStatus: KycStatusEnum.get(json['kycStatus'] ?? ""),
      externalPortfolio: Portfolio.fromJson(json["externalPortfolio"]),
      internalPortfolio: Portfolio.fromJson(json["internalPortfolio"]),
      overallPortfolio: Portfolio.fromJson(json["overallPortfolio"]),
    );
  }

  OverallPortfolioModel getOverAllPortfolio() => OverallPortfolioModel(
      rootPortfolioModel: RootPortfolioModel(
          asOfDate: lastSync,
          investInfoFiellds: InvestInfoFields(
              currentValue: overallPortfolio?.currentValue,
              gainLoss: overallPortfolio?.gainLoss,
              totInvested: overallPortfolio?.totInvested,
              xirr: overallPortfolio?.xirr)),
      externalPortfolioModel: ExternalPortfolioModel(
          informationFields: InvestInfoFields(
              currentValue: externalPortfolio?.currentValue,
              xirr: externalPortfolio?.xirr,
              totInvested: externalPortfolio?.totInvested,
              gainLoss: externalPortfolio?.gainLoss)),
      internalPortfolioModel: InternalPortfolioModel(
          commonFields: InvestInfoFields(
              currentValue: internalPortfolio?.currentValue,
              totInvested: internalPortfolio?.totInvested,
              gainLoss: internalPortfolio?.gainLoss,
              xirr: internalPortfolio?.xirr)));
}

@freezed
class AmcScheme with _$AmcScheme {
  const AmcScheme._();

  const factory AmcScheme({
    @Default("")
    String schemeName,
    @Default(0)
    double investedAmount,
    @Default(0)
    double currentCorpus,
    @Default(0)
    double returnPercentage,
    @Default(0) double returnAmount,
    String? folio,
    String? isin,
    String? amcName,
    String? symbol,
    @Default(true) bool external,
    @Default(0) double xirr,
    @Default(0) double performanceScore,
    @Default(0) double riskScore,
    @Default(0) double radius,
    double? tfRating,
    @Default("")
    String analysisQuadrant, //Imperfect, Concerning, Ideal, Undesirable
    @Default("")
    String analysisCategory
  }) = _AmcScheme;

  static List<AmcScheme> fromJsonList(List<dynamic> json) {
    var r = <AmcScheme>[];
    for(var i in json){
      r.add(_$AmcSchemeFromJson(i));
    }
    return r;
  }

  factory AmcScheme.fromJson(Map<String, dynamic> json) => _$AmcSchemeFromJson(json);

  AnalysisQuadrantEnum get analysisQuadrantEnum => AnalysisQuadrantEnum.getEnumFromApi(analysisQuadrant);

}

@freezed
class Portfolio with _$Portfolio{
  const factory Portfolio({
    @Default(0)
    double totInvested,
    @Default(0)
    double gainLoss,
    @Default(0)
    double xirr,
    @Default(0)
    double currentValue,
  }) = _Portfolio;

  factory Portfolio.fromJson(Map<String, dynamic> json) => _$PortfolioFromJson(json);
}