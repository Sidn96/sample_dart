import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/widgets/drop_down_custom_widget.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AutoBookingClosePopWidget extends HookConsumerWidget {
  final List<String> items;
  final Function(String reason, String info) onSubmitClicked;
  final Function() onPop;

  const AutoBookingClosePopWidget({
    super.key,
    required this.items,
    required this.onSubmitClicked,
    required this.onPop,
  });

  @override
  Widget build(BuildContext context, ref) {
    final selectedReason = useState<String?>(null);
    final infoController = useTextEditingController();

    return Container(
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  data: "Booking Closed!",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                10.height,
                const AppText(
                  data:
                      "The booking resulted in a no-show; help us\nunderstand why ",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  textAlign: TextAlign.start,
                  fontColor: ColorUtils.midLightGrey,
                ),
                20.height,
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 0.7, color: ColorUtils.kGreyLightColor),
                    ),
                  ),
                  child: DropDownCustomWidget(
                    hintText: "Select Reason",
                    items: items.map((country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, bottom: 10),
                          child: Text(country),
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) {
                      return items.map(
                        (item) {
                          return selectedReason.value == null
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppText(
                                      data: selectedReason.value ?? "",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                );
                        },
                      ).toList();
                    },
                    value: selectedReason.value,
                    onChanged: (value) {
                      selectedReason.value = value;
                    },
                    hintstyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorUtils.bluishblack,
                    ),
                  ),
                ),
                30.height,
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  height: 85,
                  decoration: BoxDecoration(
                    color: ColorUtils.kOffWhiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: ColorUtils.taxdarkGray),
                  ),
                  child: TextField(
                    controller: infoController,
                    maxLines: 3,
                    style:  GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: ColorUtils.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)
                    ),
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          'Please provide detailed information (optional)',
                      hintStyle: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: ColorUtils.midLightGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,)
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                MemberAngelAppButton(
                  label: "Submit",
                  bttnEnabled: selectedReason.value != null,
                  onSuccessHandler: () => onSubmitClicked(
                      selectedReason.value ?? "", infoController.text),
                  buttonWidth: double.infinity,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: IconButton(
              onPressed: onPop,
              icon: const Icon(
                Icons.close,
                size: 32,
                color: ColorUtils.kGreyBorderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
