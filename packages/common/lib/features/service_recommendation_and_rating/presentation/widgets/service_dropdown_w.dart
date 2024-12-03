import 'package:common/core/presentation/common_widgets/truepal_app_loader.dart';
import 'package:common/core/presentation/common_widgets/truepal_error_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/service_recommendation_and_rating/domain/entities/service_data_entity.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/providers/service_list_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServiceDropdownComponent extends HookConsumerWidget {
  final Function(ServiceDataEntity)? onChange;
  const ServiceDropdownComponent({super.key, required this.onChange});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(serviceListNotifierProvider);
    final selectedServiceDataEntity = useState<ServiceDataEntity?>(null);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        ref.read(serviceListNotifierProvider.notifier).getServiceCategories(2);
      });
      return;
    }, const []);

    return data.when(
      data: (list) => ServiceDropDownWidget(
        list: list ?? [],
        value: selectedServiceDataEntity.value,
        onChanged: (v) {
          if (v == null) return;
          selectedServiceDataEntity.value = v;
          onChange?.call(v); // if (detailsEntity?.appType == AppType.partner) {
          //   partnerRecommendationDataNotifier.updateQuestionAnswer(
          //       TruepalFeedbackDetail(
          //           question: e.question,
          //           type: e.type,
          //           options: e.options,
          //           value: v.id));
          //   partnerRecommendationDataNotifier.setRecommendedServiceId(v.id);
          // } else {
          //   memberRecommendationDataNotifier.updateQuestionAnswer(
          //       TruepalFeedbackDetail(
          //           question: e.question,
          //           type: e.type,
          //           options: e.options,
          //           value: v.id));
          // }
        },
      ),
      loading: () => const TrupalAppLoader(),
      error: (_, __) => TruepalErrorWidget(onSuccessHandler: () {}),
    );
  }
}

class ServiceDropDownWidget extends HookConsumerWidget {
  final List<ServiceDataEntity> list;
  final ServiceDataEntity? value;
  final Function(ServiceDataEntity?)? onChanged;
  final bool showSearchField;

  const ServiceDropDownWidget(
      {super.key,
      required this.list,
      required this.value,
      this.onChanged,
      this.showSearchField = false});

  @override
  Widget build(BuildContext context, ref) {
    final serviceController = useTextEditingController();
    // final hasError = ref.watch(angelOnboardDetailsSaverProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorUtils.kbuttondisableText,
              // color: (hasError.educationError)
              //     ? ColorUtils.errorColor2
              //     : ColorUtils.kGreyBorderColor,
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<ServiceDataEntity>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    "assets/icons/ic_down_arrow.svg",
                    package: "common",
                  ),
                ),
              ),
              hint: const Text(
                "Select your diagnosis",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: ColorUtils.unselectedTextColor,
                ),
              ),
              items: list
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item.serviceName ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ))
                  .toList(),
              value: value,
              onChanged: onChanged,
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 10, left: 8),
              ),
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200,
                decoration: BoxDecoration(color: ColorUtils.white),
              ),
              menuItemStyleData: const MenuItemStyleData(height: 40),
              dropdownSearchData: !showSearchField
                  ? null
                  : DropdownSearchData(
                      searchController: serviceController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: serviceController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for an item...',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value!.serviceName!
                            .replaceAll(".", "")
                            .toLowerCase()
                            .toString()
                            .contains(searchValue.toLowerCase());
                      },
                    ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  serviceController.clear();
                }
              },
            ),
          ),
        ),
        // if (hasError.educationError) const AngelDetailErrorWidget(),
      ],
    );
  }
}
