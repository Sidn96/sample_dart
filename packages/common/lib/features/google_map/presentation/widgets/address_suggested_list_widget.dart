import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

import '../../infrastructure/dtos/map_address_suggestion_dto.dart';
import '../providers/address_map_provider.dart';
import '../providers/member_booking_map_address_provider.dart';
import 'address_suggestion_card_detail_widget.dart';

class AddressSuggestedListWidget extends HookConsumerWidget {
  final MapAddressSuggestionDto suggestedAddress;
  final ValueNotifier<bool> isloading;

  const AddressSuggestedListWidget(
      {super.key, required this.suggestedAddress, required this.isloading});

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 300), () {
        ref.read(showForceMapProvider.notifier).changeState(true);
      });
      return null;
    });
    ref.watch(selectedSuggestedNameProvider);
    return (suggestedAddress.predictions == null ||
            suggestedAddress.predictions!.isEmpty)
        ? Center(
            child: AppText(
              data: suggestedAddress.predictions == null
                  ? "Search for Address"
                  : suggestedAddress.predictions!.isEmpty
                      ? "Address not found"
                      : "",
              height: 1.3,
              fontSize: 14,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
              fontColor: ColorUtils.midLightGrey,
            ),
          )
        : ListView.separated(
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: suggestedAddress.predictions?.length ?? 0,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final suggestedAdd = suggestedAddress.predictions?[index];
              return InkWell(
                onTap: () async {
                  isloading.value = true;
                  FocusScope.of(context).unfocus();
                  ref.read(addressSuggestionControllerProvider).text =
                      suggestedAdd?.description ?? "";
                  await ref.read(
                      searchSelectedAddressProvider(suggestedAdd?.placeId ?? "")
                          .future);

                  isloading.value = false;
                },
                child: SuggestedAddresCardDetailWidget(
                  tite: suggestedAdd?.structuredFormatting?.mainText ??
                      suggestedAdd?.structuredFormatting?.secondaryText ??
                      "",
                  description: suggestedAdd?.description ?? "",
                ),
              );
            },
          );
  }
}
