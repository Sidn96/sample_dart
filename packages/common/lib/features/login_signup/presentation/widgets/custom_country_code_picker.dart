import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class CustomCountryCodePicker extends StatelessWidget {
  const CustomCountryCodePicker({super.key, required this.selectedCountry});

  final Function(String) selectedCountry;

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      showFlagDialog: true,
      textStyle: FontStyles.interStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      favorite: const ["IN"],
      padding: EdgeInsets.zero,
      onChanged: (CountryCode code) {
        selectedCountry("$code");
      },
      initialSelection: 'IN',
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: true,
      flagWidth: 20,
      
    );
  }
}
