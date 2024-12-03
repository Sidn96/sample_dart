import 'package:adjusted_html_view_web/adjusted_html_view_web.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  final String htmlContent;
  const PrivacyPolicyView({super.key, required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: AdjustedHtmlView(htmlText:
        """
        <html>
        <head>
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
          * {
            font-family: 'Manrope', sans-serif;
            color: #35354D;
            font-weight: 400;
            line-height: 28px;
        }
        html, body {
    width: 100vw;
}
        </style>
        </head>
        <body>
        $htmlContent
      </body>
      </html>
      
      """
        ));

  }
}
