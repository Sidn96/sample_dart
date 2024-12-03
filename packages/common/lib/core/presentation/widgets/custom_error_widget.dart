import 'package:flutter/material.dart';

import '../styles/sizes.dart';
import '../utils/app_text.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText(data: data, fontSize: Sizes.textSize14),
    );
  }
}
