import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';
import 'package:mf_pod/presentation/features/check_your_kyc/components/kyc_status_header_component.dart';
import 'package:mf_pod/presentation/features/check_your_kyc/data/kyc_status_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/components/overall_portfolio_no_data.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/components/portfolio_mix_dashboard_component.dart';
import 'package:mf_pod/presentation/features/landing_page/domain/purchase_status_enum.dart';

class DashboardForUnderProcess extends HookConsumerWidget {
  final String? camsKycModificationLink;
  final KycStatusEnum? kycStatusEnum;
  final PurchaseStatusEnum? purchaseStatusEnum;

  const DashboardForUnderProcess({
    super.key,
    this.camsKycModificationLink = '',
    this.kycStatusEnum,
    this.purchaseStatusEnum,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        HeaderKycStatusComponent(
          externalLink: camsKycModificationLink,
          kycStatusType: getKycStatusType(purchaseStatusEnum) ?? kycStatusEnum,
        ),
        const OverallPortfolioNoData(),
        const PortfolioMixDashboardComponent(),
      ],
    );
  }

  getKycStatusType(PurchaseStatusEnum? status) {
    return switch (status) {
      PurchaseStatusEnum.not_started => null,
      PurchaseStatusEnum.pending => KycStatusEnum.kycUnderProgress,
      PurchaseStatusEnum.completed => null,
      _ => null
    };
  }
}
