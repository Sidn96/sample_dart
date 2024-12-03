import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class RatingStarsAndStatus extends HookConsumerWidget {
  final Function(double)? onRatingUpdate;
  const RatingStarsAndStatus({super.key, this.onRatingUpdate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratingValue = useState(0.0);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: Sizes.screenWidth() / 2.5,
              child: AnimatedRatingBar(
                  activeFillColor: ColorUtils.yellow,
                  strokeColor: ColorUtils.darkYellow,
                  initialRating: 0,
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  animationColor: ColorUtils.yellow,
                  onRatingUpdate: (rating) {
                    ratingValue.value = rating;
                    onRatingUpdate?.call(rating);
                  })),
          AppText(
              data:
                  '${ratingValue.value.toInt()}/5 ${ratingText(ratingValue.value.toInt())}',
              fontColor: ColorUtils.ageCorpusTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0),
        ]);
  }

  String ratingText(int rating) {
    if (rating == 1) {
      return "Terrible";
    } else if (rating == 2) {
      return "Bad";
    } else if (rating == 3) {
      return "Okay";
    } else if (rating == 4) {
      return "Good";
    } else if (rating == 5) {
      return "Excellent";
    } else {
      return "";
    }
  }
}
