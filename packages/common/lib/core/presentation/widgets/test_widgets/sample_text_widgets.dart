import 'package:common/core/presentation/components/app_button.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SampleTextWidgets extends HookWidget {
  SampleTextWidgets({super.key});
  final Map<String, double> stringSamplesMap = const {
    'Manrope/H1/32': 32,
    'Manrope/H1/26': 26,
    'Manrope/H1/20': 20,
    'Manrope/H1/18': 18,
    'Manrope/H1/16': 16,
    'Manrope/H1/14': 14,
    'Manrope/H1/12': 12,
  };
  final Map<String, double> stringSamplesMap2 = const {
    'Lorem Ipsum Dolor Sit Amet Consectetur/SH04/20': 20,
    'Lorem ipsum dolor sit amet consectetur/SH05/18': 18,
    'Lorem ipsum dolor sit amet consectetur/SH05/16': 16,
    'Lorem ipsum dolor sit amet consectetur/SH05/14': 14,
    'Lorem ipsum dolor sit amet consectetur/SH05/12': 12,
  };
  final bool enableLetterSpacing = true;
  var heightSpacer = const SizedBox(height: 18);
  @override
  Widget build(BuildContext context) {
    var counter = useState(0);
    var buttons = Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
      AppButton(label: "Example 1", onPressed: ()=> counter.value = 0, buttonWidth: 100,),
      AppButton(label: "Example 2", onPressed: ()=> counter.value = 1, buttonWidth: 100,),
      // AppButton(label: "Example 3", onPressed: ()=> counter.value = 2, buttonWidth: 100,),
      // AppButton(label: "Example 4", onPressed: ()=> counter.value = 3, buttonWidth: 100,),
      ],
    );
    var widgetLists = <Widget>[];
    widgetLists.add(buttons);
    switch (counter.value) {
      case 0:
        widgetLists.addAll(widgetList1());
        break;
      case 1:
        widgetLists.addAll(widgetList2());
        break;
      case 2:
        widgetLists.addAll(widgetList1());
        break;
      case 3:
        widgetLists.addAll(widgetList1());
        break;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widgetLists,
          ),
        ),
      ),
    );
  }
  

  List<Widget> widgetList1() {
    return <Widget>[
      //Extra Light
      Text('Aa', style: extraLightStyle(92)),
      Text('Extra Light', style: extraLightStyle(26)),
      heightSpacer,
      for (var e in stringSamplesMap.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: extraLightStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      //Light
      Text('Aa', style: lightStyle(92)),
      Text('Light', style: lightStyle(26)),
      heightSpacer,
      for (var e in stringSamplesMap.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: lightStyle(e.value)),
        ),
      //Regular
      Text('Aa', style: regularStyle(92)),
      Text('Regular', style: regularStyle(26)),
      heightSpacer,
      for (var e in stringSamplesMap.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: regularStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      //Medium
      Text('Aa', style: mediumStyle(92)),
      Text('Medium', style: mediumStyle(26)),
      heightSpacer,
      for (var e in stringSamplesMap.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: mediumStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      //Semi Bold
      Text('Aa', style: semiBoldStyle(92)),
      Text('SemiBold', style: semiBoldStyle(26)),
      heightSpacer,
      for (var e in stringSamplesMap.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: semiBoldStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      //Bold
      Text('Aa', style: boldStyle(92)),
      Text('Bold', style: boldStyle(26)),
      heightSpacer,
      for (var e in stringSamplesMap.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: boldStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      //Extra Bold
      Text('Aa', style: extraBoldStyle(92)),
      Text('ExtraBold', style: extraBoldStyle(26)),
      heightSpacer,
      for (var e in stringSamplesMap.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: extraBoldStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
    ];
  }

  List<Widget> widgetList2() {
    return <Widget>[
      heightSpacer,
      for (var e in stringSamplesMap2.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: extraLightStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      for (var e in stringSamplesMap2.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: lightStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      for (var e in stringSamplesMap2.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: regularStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      for (var e in stringSamplesMap2.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: mediumStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      for (var e in stringSamplesMap2.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: semiBoldStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      for (var e in stringSamplesMap2.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: boldStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
      for (var e in stringSamplesMap2.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(e.key, style: extraBoldStyle(e.value)),
        ),
      heightSpacer,
      heightSpacer,
    ];
  }

  TextStyle extraLightStyle(double fontSize) {
    return GoogleFonts.manrope(
      textStyle: TextStyle(
            package: "common",
            fontWeight: FontWeight.w200,
            fontSize: fontSize,
            color: const Color(0xFF35354D),
            letterSpacing: enableLetterSpacing ? (fontSize * -2) / 100 : null)
    );
  }

  TextStyle lightStyle(double fontSize) {
    return GoogleFonts.manrope(
        textStyle: TextStyle(
            package: "common",
            fontWeight: FontWeight.w300,
            fontSize: fontSize,
            color: const Color(0xFF35354D),
            letterSpacing: enableLetterSpacing ? (fontSize * -2) / 100 : null)
    );
  }

  TextStyle regularStyle(double fontSize) {
    return GoogleFonts.manrope(
        textStyle : TextStyle(
            package: "common",
            fontWeight: FontWeight.w400,
            fontSize: fontSize,
            color: const Color(0xFF35354D),
            letterSpacing: enableLetterSpacing ? (fontSize * -2) / 100 : null)
    );
  }

  TextStyle mediumStyle(double fontSize) {
    return GoogleFonts.manrope(
        textStyle: TextStyle(
            package: "common",
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
            color: const Color(0xFF35354D),
            letterSpacing: enableLetterSpacing ? (fontSize * -2) / 100 : null)
    );
  }

  TextStyle semiBoldStyle(double fontSize) {
    return  GoogleFonts.manrope(
        textStyle: TextStyle(
            package: "common",
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
            color: const Color(0xFF35354D),
            letterSpacing: enableLetterSpacing ? (fontSize * -2) / 100 : null)
    );
  }

  TextStyle boldStyle(double fontSize) {
    return GoogleFonts.manrope(
        textStyle: TextStyle(
            package: "common",
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
            color: const Color(0xFF35354D),
            letterSpacing: enableLetterSpacing ? (fontSize * -2) / 100 : null)
    );
  }

  TextStyle extraBoldStyle(double fontSize) {
    return GoogleFonts.manrope(
        textStyle: TextStyle(
            package: "common",
            fontWeight: FontWeight.w800,
            fontSize: fontSize,
            color: const Color(0xFF35354D),
            letterSpacing: enableLetterSpacing ? (fontSize * -2) / 100 : null)
    );
  }
}
