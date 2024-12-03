import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class CommonV2Widgets {

  Widget getHtmlWidget(String htmlBody, {TextStyle? textStyle}) {
    textStyle ??= TextStyle(
        fontFamily: TextStyles.instance.getFontFamily(),
        fontSize: 10,
        color: Colors.grey);
    return HtmlWidget(
      htmlBody,
      textStyle: textStyle,
    );
  }
}