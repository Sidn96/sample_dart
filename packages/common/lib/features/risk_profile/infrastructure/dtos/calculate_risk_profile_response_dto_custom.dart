class CalculateRiskProfileResponseDtoCustom {
  int? status = -1;
  String? message;
  RiskProfileDataDto? riskData;
  String? error;

  CalculateRiskProfileResponseDtoCustom(
      {this.status, this.message, this.riskData, this.error});

  CalculateRiskProfileResponseDtoCustom.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    riskData =
        json['data'] != null ? RiskProfileDataDto.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['statusCode'] = status;
    data['message'] = message;
    data['error'] = error;
    if (riskData != null) {
      data['data'] = riskData?.toJson();
    }
    return data;
  }
}

class RiskProfileDataDto {
  int? currentAge;
  String? riskProfile;
  String? message;
  IdealPortfolioAllocationPercentage? idealPortfolioAllocationPercentage;
  List<IdealPortfolioAllocation>? idealPortfolioAllocation;

  RiskProfileDataDto(
      {this.currentAge,
      this.riskProfile,
      this.message,
      this.idealPortfolioAllocationPercentage,
      this.idealPortfolioAllocation});

  RiskProfileDataDto.fromJson(Map<String, dynamic> json) {
    currentAge = json['currentAge'];
    riskProfile = json['riskProfile'];
    message = json['message'];
    idealPortfolioAllocationPercentage =
        json['idealPortfolioAllocationPercentage'] != null
            ? IdealPortfolioAllocationPercentage.fromJson(
                json['idealPortfolioAllocationPercentage'])
            : null;
    if (json['idealPortfolioAllocation'] != null) {
      idealPortfolioAllocation = <IdealPortfolioAllocation>[];
      json['idealPortfolioAllocation'].forEach((v) {
        idealPortfolioAllocation!.add(IdealPortfolioAllocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['currentAge'] = currentAge;
    data['riskProfile'] = riskProfile;
    data['message'] = message;

    if (idealPortfolioAllocationPercentage != null) {
      data['idealPortfolioAllocationPercentage'] =
          idealPortfolioAllocationPercentage?.toJson();
    }

    if (idealPortfolioAllocation != null) {
      data['idealPortfolioAllocation'] =
          idealPortfolioAllocation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IdealPortfolioAllocationPercentage {
  int? equityFunds;
  int? nps;
  int? hybridFunds;
  int? corporateBonds;
  int? ppfNsc;
  int? fd;
  int? sgb;
  int? insurance;

  IdealPortfolioAllocationPercentage(
      {this.equityFunds,
      this.nps,
      this.hybridFunds,
      this.corporateBonds,
      this.ppfNsc,
      this.fd,
      this.sgb,
      this.insurance});

  IdealPortfolioAllocationPercentage.fromJson(Map<String, dynamic> json) {
    equityFunds = json['equityFunds'];
    nps = json['nps'];
    hybridFunds = json['hybridFunds'];
    corporateBonds = json['corporateBonds'];
    ppfNsc = json['ppfNsc'];
    fd = json['fd'];
    sgb = json['sgb'];
    insurance = json['insurance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['equityFunds'] = equityFunds;
    data['nps'] = nps;
    data['hybridFunds'] = hybridFunds;
    data['corporateBonds'] = corporateBonds;
    data['ppfNsc'] = ppfNsc;
    data['fd'] = fd;
    data['sgb'] = sgb;
    data['insurance'] = insurance;

    return data;
  }
}

class IdealPortfolioAllocation {
  String? investmentType;
  int? value;
  String? color;

  IdealPortfolioAllocation({this.investmentType, this.value, this.color});

  IdealPortfolioAllocation.fromJson(Map<String, dynamic> json) {
    investmentType = json['investmentType'];
    value = json['Value'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['investmentType'] = investmentType;
    data['Value'] = value;
    data['color'] = color;

    return data;
  }
}
