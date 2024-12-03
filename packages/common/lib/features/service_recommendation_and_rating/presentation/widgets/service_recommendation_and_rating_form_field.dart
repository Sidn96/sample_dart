import 'package:flutter/material.dart';

class ServiceRecommendationAndRatingFormField extends StatelessWidget {
  final String question;
  final Widget fieldWidget;
  final bool isRequired;
  final int spacing;
  const ServiceRecommendationAndRatingFormField(
      {super.key,
      required this.question,
      required this.fieldWidget,
      required this.spacing,
      this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: question,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              if (isRequired)
                const TextSpan(
                  text: '*',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
            ],
          ),
        ),
        SizedBox(height: spacing.toDouble()),
        fieldWidget,
        const SizedBox(height: 30),
      ],
    );
  }
}
