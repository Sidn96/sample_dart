import 'package:common/core/infrastructure/local_storage_data_source/secure_storage.dart';
import 'package:common/core/presentation/components_v2/app_snackbar.dart';
import 'package:common/core/presentation/components_v2/billdesk_order_webview_page.dart';
import 'package:common/core/presentation/components_v2/digilocker_webView_page.dart';
import 'package:common/core/presentation/components_v2/signzy_digilocker_webview_page.dart';
import 'package:common/core/presentation/utils/enums/common_digilocker_state_enum.dart';
import 'package:common/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonFunctions {
  navigateToAnyURL(String url, {bool isNewTab = true}) async {
    if (!await launchUrl(Uri.parse(url),
        webOnlyWindowName: isNewTab ? '_blank' : '_self')) {
      throw Exception('Could not launch $url');
    }
  }

  /// Function to compare two Strings irrespective of the cases
  static bool compareStringsIgnoreCase(String? str1, String? str2) {
    if (str1 == null && str2 == null) {
      return true; // Both strings are null, consider them equal
    }
    if (str1 == null || str2 == null) {
      return false; // One string is null and the other is not, consider them not equal
    }
    return str1.toLowerCase() == str2.toLowerCase();
  }

  /// Function to calculate Retirement Date
  /// Given: DateTime? dateOfBirth,
  /// Given: int retirementAge
  /// Returns DateTime

  static DateTime? calculateRetirementDate(
      {required DateTime dateOfBirth, required int retirementAge}) {
    // Calculate the year of retirement
    final retirementYear = dateOfBirth.year + retirementAge;

    // Create the retirement date by setting the year to the retirement year and keeping the month and day the same
    final retirementDate =
        DateTime(retirementYear, dateOfBirth.month, dateOfBirth.day);

    return retirementDate;
  }

  /// Function to copy text and show the snackbar
  static void copyToClipboard(
      {required BuildContext context, required String text}) {
    Clipboard.setData(ClipboardData(text: text));
    AppSnackBar.show(context: context, message: "Copied To Clipboard $text");
  }

  /// Function to store In Local Storage
  static Future<void> storeInLocalStorage(String key, String value) async {
    await SecureStorage().setPref(key: key, value: value);
  }

  /// Function to format number with one decimal point
  static NumberFormat formatterWithOneDecimal =
      NumberFormat.decimalPatternDigits(locale: 'en_us', decimalDigits: 1);

 /// Function to  get Income Range for RRR
  static String getIncomeRange(int income) {
    return switch (income) {
      > 20000000 => "201-500",
      > 10000000 => "101-200",
      > 5000000 => "51-100",
      > 1700000 => "18-50",
      _ => "10-17"
    };
  }     

  Future<void> openDiGiLockerWebViewInBottomSheet(BuildContext context,
      {required String digiLockerUrl,
      required String redirectUrl,
      VoidCallback? successCallback}) async {
    var result = await showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (dialogContext) {
        return AppBottomSheet(
            topLeftRadius: 0.0,
            topRightRadius: 0.0,
            childWidget: DiGiLockerWebView(
              diGiLockerUrl: digiLockerUrl,
              redirectUrl: redirectUrl,
            ));
      },
    );
    if (result == CommonDiGiLockerStatusEnum.VERIFIED) {
      successCallback?.call();
    }
  }

  Future<void> openSignzyDigiLockerWebViewInBottomSheet(BuildContext context,
      {required String signzyDigilockerUrl,
      required String redirectUrl,
      VoidCallback? successCallback,
      VoidCallback? onCancelTap}) async {
    var result = await showModalBottomSheet(
      context: context,
      isDismissible: false,
      useRootNavigator: false,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (dialogContext) {
        return AppBottomSheet(
            topLeftRadius: 0.0,
            topRightRadius: 0.0,
            childWidget: SignzyDigiLockerWebView(
              signzyDigilockerUrl: signzyDigilockerUrl,
              redirectUrl: redirectUrl,
            ));
      },
    );
    if (result == SignzyDigilockerStatusEnum.VERIFIED) {
      successCallback?.call();
    } else if (result == SignzyDigilockerStatusEnum.CANCELLED) {
      onCancelTap?.call();
    }
  }

  Future<void> openOrderPlacementWebViewInBottomSheet(BuildContext context,
      {required String billDeskUrl,
      required String redirectUrl,
      ValueChanged<Uri>? successCallback,
      VoidCallback? onCancelTap}) async {
    var result = await showModalBottomSheet(
      context: context,
      isDismissible: false,
      useRootNavigator: false,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (dialogContext) {
        return AppBottomSheet(
            topLeftRadius: 0.0,
            topRightRadius: 0.0,
            childWidget: BillDeskOrderWebViewPage(
              billDeskUrl: billDeskUrl,
              redirectUrl: redirectUrl,
            ));
      },
    );
    if (result is List) {
      if (result[0] == BillDeskStatusEnum.VERIFIED) {
        successCallback?.call(result[1]);
      } else if (result[0] == BillDeskStatusEnum.CANCELLED) {
        onCancelTap?.call();
      }
    } else {
      onCancelTap?.call();
    }
  }

  Future<void> openMandateWebViewInBottomSheet(BuildContext context,
      {required String mandateUrl,
      required String redirectUrl,
      ValueChanged<Uri>? successCallback,
      VoidCallback? onCancelTap}) async {
    var result = await showModalBottomSheet(
      context: context,
      isDismissible: false,
      useRootNavigator: false,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (dialogContext) {
        return AppBottomSheet(
            topLeftRadius: 0.0,
            topRightRadius: 0.0,
            childWidget: BillDeskOrderWebViewPage(
              billDeskUrl: mandateUrl,
              redirectUrl: redirectUrl,
            ));
      },
    );
    if (result is List) {
      if (result[0] == BillDeskStatusEnum.VERIFIED) {
        successCallback?.call(result[1]);
      } else if (result[0] == BillDeskStatusEnum.CANCELLED) {
        onCancelTap?.call();
      }
    } else {
      onCancelTap?.call();
    }
  }
}
