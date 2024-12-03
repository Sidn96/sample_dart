import 'dart:math';

import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:mf_pod/presentation/features/dashboard/data/mf_sync_dashboard_dto.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/scheme_filter_type_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widgets/user_mf_performance_base/scheme_details_row.dart';
import 'package:mf_pod/utils/mf_asset_utils.dart';
import 'package:mf_pod/presentation/features/check_your_kyc/presentation/widgets/mixins/common_mixins.dart';

class MfAmcCardWidget extends HookWidget with AmcUiMixin{
  final MapEntry<String, List<AmcScheme>> amcMap;
  final SchemeFilterTypeEnum schemeFilterTypeEnum;
  const MfAmcCardWidget({super.key,required this.amcMap,required this.schemeFilterTypeEnum});

  @override
  Widget build(BuildContext context) {
    var isExpanded = useState(false);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorUtilsV2.genericWhite,
        border: Border.all(width: 0.4,color: ColorUtilsV2.hex_C2C2C9),
        boxShadow: [
          BoxShadow(
            color: ColorUtilsV2.hex_C2C2C9.withOpacity(0.5), // Shadow color
            spreadRadius: 1, // The spread radius
            blurRadius: 4, // The blur radius
            offset: const Offset(0, 2), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              isExpanded.value = !isExpanded.value;
            },
            child: Container(
              height: 45,
              decoration:  const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: ColorUtilsV2.specialNeutral200),
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getAmcImage(amcMap.value.first.symbol ?? ""),
                   Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10),
                      child: AppTextV2(
                        data: amcMap.key,
                        fontSize: Sizes.textSize14,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        fontColor: ColorUtilsV2.specialNeutral700,
                      ),
                    ),
                  ),
                  Container(height: 30,
                    padding: const EdgeInsets.all(11),
                    child: Transform(
                      transform: Matrix4.identity()..rotateZ(isExpanded.value ? pi : 0),
                      alignment: Alignment.center,
                      child: Image.asset(
                        MfAssetUtils.icDownArrow,
                        package: 'mf_pod',
                        height: 9,color: ColorUtilsV2.hex_4E52F8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return SchemeDetailsRow(
                    amcScheme: amcMap.value[index],
                    isExpanded: isExpanded.value,
                    schemeFilterTypeEnum: schemeFilterTypeEnum
                );
              },
              separatorBuilder: (_, index) {
                return  Divider(
                  height: 2,
                  color: !isExpanded.value ? ColorUtilsV2.hex_E5E7EB : ColorUtilsV2.transparent,
                  thickness: 2,
                );
              },
              itemCount: amcMap.value.length),
        ],
      ),
    );
  }
}
