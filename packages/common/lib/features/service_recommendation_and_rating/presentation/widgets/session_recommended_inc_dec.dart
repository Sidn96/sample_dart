import 'package:common/core/presentation/widgets/text_field_light_grey_decoration.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/providers/service_recommendation_and_rating_provider.dart';
import 'package:flutter/material.dart';

class SessionRecommendedIncrementDecrement extends HookConsumerWidget {
  final int min;
  final int max;
  final Function(int) onSelection;

  const SessionRecommendedIncrementDecrement(
      {super.key, this.min = 0, this.max = 5, required this.onSelection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = useState<int>(5);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        ref
            .read(partnerRecommendationAndRatingDataProvider.notifier)
            .setSessionsRecommended(5);
      });
      return;
    }, const []);

    return InputDecorator(
      decoration: textFieldLightGreyDecoration(
        enableBorderColor: (count.value < min)
            ? ColorUtils.errorColor
            : ColorUtils.kbuttondisableText,
        disableBorderColor: (count.value < min)
            ? ColorUtils.errorColor
            : ColorUtils.taxdarkGray,
        focusedBorderColor: (count.value < min)
            ? ColorUtils.errorColor
            : ColorUtils.bluishblack,
        contentPadding: EdgeInsets.zero,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (count.value > 0) {
                  count.value--;
                  onSelection(count.value);
                }
              },
              padding: EdgeInsets.zero,
              icon: Text(
                String.fromCharCode(
                  Icons.remove.codePoint,
                ),
                style: TextStyle(
                  fontFamily: Icons.remove.fontFamily,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: (count.value < min)
                      ? ColorUtils.errorColor
                      : ColorUtils.midLightGrey,
                ),
              ),
            ),
            AppText(
              data: (count.value).toString(),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontColor: (count.value < min)
                  ? ColorUtils.errorColor
                  : ColorUtils.darkestBlue,
            ),
            IconButton(
              onPressed: () {
                if (count.value < max) {
                  count.value++;
                  onSelection(count.value);
                }
              },
              padding: EdgeInsets.zero,
              icon: Text(
                String.fromCharCode(
                  Icons.add.codePoint,
                ),
                style: TextStyle(
                  fontFamily: Icons.add.fontFamily,
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: (count.value < min)
                      ? ColorUtils.errorColor
                      : ColorUtils.midLightGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
