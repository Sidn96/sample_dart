// enum RiskProfileTypeEnum { high, medium, low }
//
// extension RiskProfilesExtension on RiskProfileTypeEnum {
//   String get riskProfileName {
//     switch (this) {
//       case RiskProfileTypeEnum.high:
//         return 'High';
//       case RiskProfileTypeEnum.medium:
//         return 'Medium';
//       case RiskProfileTypeEnum.low:
//         return 'Low';
//       default:
//         return '';
//     }
//   }
//
// }
//
enum RiskProfileRedirection { goToLoginPage , goToResultPage, defaut}
