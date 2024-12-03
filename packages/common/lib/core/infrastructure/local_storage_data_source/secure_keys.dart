import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureKeys {
  static final SecureKeys _instance = SecureKeys._internal();
  factory SecureKeys() => _instance;
  SecureKeys._internal();

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  // IOSOptions getIOSOptions() => IOSOptions(accessibility: IOSAccessibility.first_unlock);


  static const String utmsource = "utm_source";
  static const String utmmedium = "utm_medium";
  static const String utmcampaign = "utm_campaign";
  static const String utmcontent = "utm_content";
  static const String firstrun = 'first_run';
  static const String forAngel = 'forAngel';
  static const String accessToken = 'access-token';
  static const String refreshToken = 'refresh-token';
  static const String phoneNumber = 'phoneNumber';
  static String sessionFullName = 'sessionFullName'; //for RC-pod
  static String merchantTxnNo = 'merchantTxnNo'; //for RC subscription pod
  static String memberInfo = 'memberInfo';
  static String bookingData = "bookingData"; // for EC
  static String proceedClicked = "proceedClicked"; // for EC
  static String servicePincode = "servicePincode";
  static String palName = "palName";
  static String installReferrerInfo = "installReferrerInfo";
  static String referralCodeData = "referralCodeData";
  static String referralCode = "referralCode";
  static String referralCodeMember = "referralCodeMember";

  static String partnerAddress = "partnerAddress";
  static String partnerServiceGroupId = "partnerServiceGroupId";
  static String partnerServiceIds = "partnerServiceIds";
}
