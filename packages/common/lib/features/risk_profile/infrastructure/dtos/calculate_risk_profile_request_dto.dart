import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculate_risk_profile_request_dto.freezed.dart';
part 'calculate_risk_profile_request_dto.g.dart';

@Freezed(toJson: true)
class CalculateRiskProfileRequestDto with _$CalculateRiskProfileRequestDto {
  const factory CalculateRiskProfileRequestDto({
    required int? currentAge,
    required String? incomeRange,
    required String? savingRange,
    required String? actionWhenShortTimePortfolioGain,
    required String? lossBearingCapacityRange,
  }) = _CalculateRiskProfileRequestDto;

  factory CalculateRiskProfileRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CalculateRiskProfileRequestDtoFromJson(json);
}