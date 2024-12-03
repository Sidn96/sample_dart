import 'package:flutter/material.dart';

class CommonStarRating extends StatelessWidget {
  final double rating;
  final Widget? fullStarWidget;
  final Widget? halfStarWidget;

  const CommonStarRating({
    super.key,
    this.rating = 0.0,
    this.fullStarWidget,
    this.halfStarWidget,
  });

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    List<Widget> stars = [];
    //full stars
    for (int i = 0; i < fullStars; i++) {
      stars.add(Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
              child: fullStarWidget ?? const Icon(Icons.star_rounded,color: Colors.amber),
        ),
      ),);
    }
    //half stars
    if (hasHalfStar) {
      stars.add(Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: halfStarWidget ?? const Icon(Icons.star_half_rounded,color: Colors.amber),
        ),
      ),);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}