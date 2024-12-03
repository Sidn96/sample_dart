import 'package:common/env/env.dart';

class ApiEndPoints {
  static const baseUrl = Env.baseUrlFromEnv;
  static const homeResultApi = "${baseUrl}homepage/getCombination";
  static const homePageBlogsApi = "${baseUrl}api/blogPostSection";
  static const homePageVideosApi = "${baseUrl}api/videoSection";
  static const gmailAuthApi = "${baseUrl}oneview/ov/gmail/auth";
  static const basicDetailsApi = "${baseUrl}oneview/ov/basicDetails";
  static const dashboardGetData = "${baseUrl}dashboard/getData";
  static const calculateRRR = "${baseUrl}oneview/rrr";
  static const calculateRiskProfile = "${baseUrl}oneview/risk-profile";


  //epf
  static const getUAN = "${baseUrl}oneview/epf/get-uan";
  static const generateUanOtp = "${baseUrl}oneview/epf/generate-otp";
  static const submitUanOtp = "${baseUrl}oneview/epf/submit-otp";
  static const epfDetails = "${baseUrl}oneview/epf";
  static const epfWithdrawalLimit = "${baseUrl}oneview/epf/withdrawal-limit";
}
