import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum GenderEnum {
  male("Male"),
  female("Female"),
  others("Others");

  final String val;

  const GenderEnum(this.val);

  String get uiString => val;

}

class GenderSelectionWidget extends HookWidget {
  // final Function(String) onGenderSelect;
  final Function(GenderEnum) onGenderSelect;
  final double availableWidth;
  final GenderEnum? initialValue;
  final bool enabled;

  const GenderSelectionWidget(
      {super.key,
        required this.onGenderSelect,
        required this.availableWidth,
        this.initialValue,
        this.enabled = true});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(-1);
    final width = availableWidth;
    useEffect(() {
      if (initialValue != null) {
        selectedIndex.value = initialValue == GenderEnum.male
            ? 0
            : initialValue == GenderEnum.female
            ? 1
            : 2;
      }
    }, [initialValue]);
    List<Widget> stackChildren = [];
    Widget firstItem = Positioned(
      left: 0.0,
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: () {
          selectedIndex.value = 0;
          onGenderSelect(GenderEnum.male);
        },
        child: Container(
          height: 45.0,
          width: width / 3 +
              (selectedIndex.value == -1
                  ? 0
                  : selectedIndex.value != 0
                  ? 30.0
                  : 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: selectedIndex.value == 0
                ? ColorUtilsV2.hex_7375FD
                : ColorUtilsV2.hex_F9FAFB,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AssetUtils.icGenderMale,
                    height: 20,
                    package: "common",
                    colorFilter: ColorFilter.mode(selectedIndex.value == 0 ? Colors.white : Colors.black, BlendMode.srcIn)
                ),
                // Image.asset(
                //   InsuranceAssetConstants.icMaleUnselected,
                //   package: "insurance_pod",
                //   height: 20.0,
                //   color: selectedIndex.value == 0 ? Colors.white : null,
                // ),
                const SizedBox(width: 8.0),
                AppTextV2(
                  data: GenderEnum.male.uiString,
                  height: 16.39 / 12.0,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  fontColor: selectedIndex.value == 0
                      ? Colors.white
                      : ColorUtilsV2.hex_35354D,
                ),
                if (selectedIndex.value != 0 && selectedIndex.value != -1)
                  const SizedBox(width: 30.0)
              ],
            ),
          ),
        ),
      ),
    );
    Widget secItem = Positioned(
      left: width / 3 -
          (selectedIndex.value == 1
              ? 20.0
              : ((selectedIndex.value == 0) || selectedIndex.value == -1)
              ? 20
              : 0),
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: () {
          selectedIndex.value = 1;
          onGenderSelect(GenderEnum.female);
        },
        child: Container(
          height: 45.0,
          width: width / 3 + (selectedIndex.value == 1 ? 10.0 : -10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: selectedIndex.value == 1
                ? ColorUtilsV2.hex_7375FD
                : ColorUtilsV2.hex_F3F4F6,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selectedIndex.value == 0) const SizedBox(width: 8.0),
                SvgPicture.asset(AssetUtils.icGenderFemale,
                    height: 20,
                    package: "common",
                    colorFilter: ColorFilter.mode(selectedIndex.value == 1 ? Colors.white : Colors.black, BlendMode.srcIn)
                ),
                // Image.asset(
                //   InsuranceAssetConstants.icFemaleUnselected,
                //   package: "insurance_pod",
                //   height: 20.0,
                //   color: selectedIndex.value == 1 ? Colors.white : null,
                // ),
                const SizedBox(width: 8.0),
                AppTextV2(
                  data: GenderEnum.female.uiString,
                  height: 16.39 / 12.0,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  fontColor: selectedIndex.value == 1
                      ? Colors.white
                      : ColorUtilsV2.hex_35354D,
                ),
                if (selectedIndex.value == 2) const SizedBox(width: 30.0)
              ],
            ),
          ),
        ),
      ),
    );
    Widget thirdItem = Positioned(
      right: 0,
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: () {
          selectedIndex.value = 2;
          onGenderSelect(GenderEnum.others);
        },
        child: Container(
          height: 45.0,
          width: width / 3 + (selectedIndex.value != 2 ? 30 : 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: selectedIndex.value == 2
                ? ColorUtilsV2.hex_7375FD
                : ColorUtilsV2.hex_E5E7EB,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if(selectedIndex.value!=2)
                // const SizedBox(width: 19.0),
                // if (selectedIndex.value != 2) const SizedBox(width: 34.0),
                if (selectedIndex.value != 2) const SizedBox(width: 20.0),
                SvgPicture.asset(
                    AssetUtils.icGenderOther,
                    height: 20,
                    package: "common",
                    colorFilter: ColorFilter.mode(selectedIndex.value == 2 ? Colors.white : Colors.black, BlendMode.srcIn)
                ),
                // Image.asset(
                //   InsuranceAssetConstants.icOthersUnselected,
                //   package: "insurance_pod",
                //   height: 20.0,
                //   color: selectedIndex.value == 2 ? Colors.white : null,
                // ),
                const SizedBox(width: 8.0),
                AppTextV2(
                  data: GenderEnum.others.uiString,
                  height: 16.39 / 12.0,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  fontColor: selectedIndex.value == 2
                      ? Colors.white
                      : ColorUtilsV2.hex_35354D,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (selectedIndex.value == 0) {
      stackChildren = [thirdItem, secItem, firstItem];
    } else if (selectedIndex.value == 1) {
      stackChildren = [thirdItem, firstItem, secItem];
    } else if (selectedIndex.value == 2) {
      stackChildren = [firstItem, secItem, thirdItem];
    } else {
      stackChildren = [thirdItem, secItem, firstItem];
    }
    return IgnorePointer(
      ignoring: enabled == false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTextV2(
            data: "Choose Gender",
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            height: 19.12 / 14.0,
            fontColor: ColorUtilsV2.hex_35354D,
          ),
          const SizedBox(height: 12.0),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(
                    color: selectedIndex.value == -1
                        ? ColorUtilsV2.hex_C2C2C9
                        : Colors.black)),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 45.0,
                ),
                ...stackChildren
              ],
            ),
          ),
        ],
      ),
    );
  }
}
