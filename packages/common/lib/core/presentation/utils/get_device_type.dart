import 'package:flutter/material.dart';

enum GetDeviceTypes { mobile, tablet, desktop, unDefined }

GetDeviceTypes getDeviceType(BuildContext context) {
  double screenWidth = MediaQuery.sizeOf(context).width;
  if (screenWidth >= 320 && screenWidth <= 480) {
    return GetDeviceTypes.mobile;
  } else if (screenWidth > 480 && screenWidth <= 768) {
    return GetDeviceTypes.tablet;
  } else {
    return GetDeviceTypes.unDefined;
  }
}
