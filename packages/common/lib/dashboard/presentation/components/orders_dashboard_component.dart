import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_pod/presentation/common_widgets/no_orders_found_widget.dart';
import 'package:mf_pod/presentation/features/orders/domain/enums.dart';
import 'package:mf_pod/presentation/features/orders/presentation/widgets/order_scheme_record_item.dart';
import 'package:mf_pod/presentation/features/orders/provider/order_listing_provider.dart';
import 'package:mf_pod/routing/mf_route_paths.dart';
import 'package:mf_pod/utils/enums/investment_type_enum.dart';
import 'package:mf_pod/utils/mf_asset_utils.dart';

class OrderDashboardPageArgs{
  InvestmentTypeEnum investmentType;

   OrderDashboardPageArgs({required this.investmentType});
}
class OrdersDashboardComponent extends HookConsumerWidget {
  final OrderDashboardPageArgs _args;
  final Function onStartInvesting;
  const OrdersDashboardComponent(this._args, this.onStartInvesting, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orders = ref.watch(orderListingNotifierProvider(_args.investmentType));
    var ordersNotifier = ref.read(orderListingNotifierProvider(_args.investmentType).notifier);
    var selectedInvestment = useState(_args.investmentType);

    if (orders == null) {
      return Center(
          child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
              child: const CommonTrueFinLoader()));
    }
    //@TODO check the load time of order screen and make the keepalive = true as dashboard
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            holdingCategoriesItem(InvestmentTypeEnum.sip.uiValue,
                selectedInvestment.value == InvestmentTypeEnum.sip, () {
              ordersNotifier.setInvestmentType(InvestmentTypeEnum.sip);
              selectedInvestment.value = InvestmentTypeEnum.sip;
            }),
            const SizedBox(width: 12),
            holdingCategoriesItem(InvestmentTypeEnum.lumpsum.uiValue,
                selectedInvestment.value == InvestmentTypeEnum.lumpsum, () {
                  ordersNotifier.setInvestmentType(InvestmentTypeEnum.lumpsum);
                  selectedInvestment.value = InvestmentTypeEnum.lumpsum;
            }),
            const Spacer(),
            PopupMenuButton(
              elevation: 5,
              color: ColorUtilsV2.genericWhite,
              //Theme.of(context).canvasColor,
              icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    MfAssetUtils.icFilter,
                    package: 'mf_pod',
                  )),
              onSelected: (val) {
                ordersNotifier.setFilter(val);
              },

              offset: const Offset(0, 45),
              itemBuilder: (BuildContext context) {
                return OrderListingFilterTypeEnum.values
                    .map((OrderListingFilterTypeEnum value) {
                  return PopupMenuItem<OrderListingFilterTypeEnum>(
                    value: value,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: OrderListingFilterTypeEnum.values.last ==
                                  value
                              ? null
                              : const Border(
                                  bottom: BorderSide(
                                      color: ColorUtilsV2.specialNeutral200))),
                      child: Text(
                        value.uiValue,
                        style: const TextStyle(
                            fontSize: Sizes.textSize15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                }).toList();
              },
            ),

            ///Commented because on want to remove ripple effect onTap PMF-693
            /*DropdownButton(
                padding: EdgeInsets.zero,
                isDense: true,
                style: FontStyles.interStyle(
                    fontWeight: FontWeight.w500,
                    textColor: ColorUtilsV2.specialNeutral700,
                    fontSize: Sizes.textSize14),
                underline: const SizedBox.shrink(),
                icon: SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      MfAssetUtils.icFilter,
                      package: 'mf_pod',
                    )),
                items: OrderListingFilterTypeEnum.values
                    .map((OrderListingFilterTypeEnum value) {
                  return DropdownMenuItem<OrderListingFilterTypeEnum>(
                    value: value,
                    child: Text(
                      value.uiValue,
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    ordersNotifier.setFilter(val);
                  }
                }),*/
          ]),
        ),
        orders.isEmpty
            ? NoOrdersFound(onTap: (){onStartInvesting.call();})
            : Expanded(
              child: ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orders.length,
                  itemBuilder: (context, pos) {
                    return OrderSchemeRecordItem(
                      model: orders[pos],
                      onTap: () {
                        context.pushNamed(MutualFundRoutePaths.orderDetails,
                            queryParameters: {
                              "orderId": orders[pos].fpId,
                              "investType": orders[pos].investmentTypeEnum.apiValue
                            });
                      },
                    );
                  },
                ),
            ),
      ],
    );
  }

  Widget holdingCategoriesItem(
      String label, bool isSelected, Function onCategoryClick) {
    return GestureDetector(
      onTap: () {
        onCategoryClick.call();
      },
      child: !isSelected
          ? DottedBorder(
              color: ColorUtilsV2.hex_C3C4FE,
              borderType: BorderType.RRect,
              radius: const Radius.circular(16),
              strokeWidth: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12),
                child: AppTextV2(
                  data: label,
                  fontSize: Sizes.textSize14,
                  fontWeight: FontWeight.w500,
                  fontColor: ColorUtilsV2.hex_5D5D70,
                ),
              ))
          : Container(
              decoration: const BoxDecoration(
                color: ColorUtilsV2.specialSuccess300,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 12),
              child: AppTextV2(
                data: label,
                fontSize: Sizes.textSize14,
                fontWeight: FontWeight.w500,
                fontColor: ColorUtilsV2.hex_5D5D70,
              ),
            ),
    );
  }
}
