// import 'package:clevertap_plugin/clevertap_plugin.dart';

// class AppEvents {
//   /// this method should be called whenever required event is received
//   static void trackTrupalPartnerEvent(
//     String screenName,
//     String eventName, {
//     String? eventType,
//     String? questionNumber,
//     String? kycStatus,
//     int? moduleNumber,
//     String? calendarDate,
//     String? timeSlot,
//     String? unavailableToggle,
//     String? repeatToggle,
//     int? visitRequestCount,
//     String? scheduleVisitsTab,
//     String? memberId,
//     String? memberName,
//     String? status,
//     String? time,
//     String? date,
//     double? distance,
//     String? otpType,
//   }) {
//     try {
//       // MoEProperties moProperties = MoEProperties();
//       // moProperties.addAttribute("Pod Type", "TruePal-Partner");
//       // moProperties.addAttribute("Screen Name", screenName);
//       // if (eventType != null) {
//       //   moProperties.addAttribute("Event Type", eventType);
//       // }
//       // if (questionNumber != null) {
//       //   moProperties.addAttribute("question_number", questionNumber);
//       // }
//       // if (kycStatus != null) {
//       //   moProperties.addAttribute("kyc_status", kycStatus);
//       // }
//       // if (moduleNumber != null) {
//       //   moProperties.addAttribute("module_number", moduleNumber);
//       // }
//       // if (calendarDate != null) {
//       //   moProperties.addAttribute("calendar_date", calendarDate);
//       // }
//       // if (timeSlot != null) {
//       //   moProperties.addAttribute("time_slot", timeSlot);
//       // }
//       // if (unavailableToggle != null) {
//       //   moProperties.addAttribute("unavailable_toggle", unavailableToggle);
//       // }
//       // if (repeatToggle != null) {
//       //   moProperties.addAttribute("repeat_toggle", repeatToggle);
//       // }
//       // if (visitRequestCount != null) {
//       //   moProperties.addAttribute("visit_request_count", visitRequestCount);
//       // }
//       // if (scheduleVisitsTab != null) {
//       //   moProperties.addAttribute("schedule_visits_tab", scheduleVisitsTab);
//       // }
//       // if (memberId != null) {
//       //   moProperties.addAttribute("member_id", memberId);
//       // }
//       // if (status != null) {
//       //   moProperties.addAttribute("status", status);
//       // }
//       // if (time != null) {
//       //   moProperties.addAttribute("time", time);
//       // }
//       // if (date != null) {
//       //   moProperties.addAttribute("date", date);
//       // }
//       // if (distance != null) {
//       //   moProperties.addAttribute("distance", distance);
//       // }
//       // if (otpType != null) {
//       //   moProperties.addAttribute("otp_type", otpType);
//       // }
//       // final MoEngageFlutter moengagePlugin =
//       //     MoEngageFlutter('4FXR0OHA9TCLKMQTTPN2P4QR');
//       // moengagePlugin.initialise();
//       // moengagePlugin.trackEvent(eventName, moProperties);

//       Map<String, dynamic> properties = {
//         'Pod Type': 'TruePal-Partner',
//         'Screen Name': screenName,
//         'Event Type': eventType,
//         'question_number': questionNumber,
//         'kyc_status': kycStatus,
//         'module_number': moduleNumber,
//         'calendar_date': calendarDate,
//         'time_slot': timeSlot,
//         'unavailable_toggle': unavailableToggle,
//         'repeat_toggle': repeatToggle,
//         'visit_request_count': visitRequestCount,
//         'schedule_visits_tab': scheduleVisitsTab,
//         'member_id': memberId,
//         'member_name': memberName,
//         'status': status,
//         'time': time,
//         'date': date,
//         'distance': distance,
//         'otp_type': otpType,
//       };
//       properties.removeWhere((key, value) => value == null);
//       CleverTapPlugin.recordEvent(eventName, properties);
//     } catch (_) {}
//   }

//   /// this method should be called whenever required event is received
//   static void trackTrupalMemberEvent(
//     String screenName,
//     String eventName, {
//     String? eventType,
//     dynamic eventProperty,
//     String? subscriptionPlan,
//     String? validity,
//     String? services,
//     String? credits,
//     String? amount,
//     String? scheduleVisitsTab,
//     String? memberId,
//     String? memberName,
//     String? status,
//     String? time,
//     String? date,
//     String? distance,
//   }) {
//     Map<String, dynamic> properties = {
//       'Pod Type': 'TruePal-Member',
//       'Screen Name': screenName,
//       'Event Type': eventType,
//       'subscription_plan': subscriptionPlan,
//       'validity': validity,
//       'services': services,
//       'credits': credits,
//       'amount': amount,
//       'schedule_visits_tab': scheduleVisitsTab,
//       'member_id': memberId,
//       'member_name': memberName,
//       'status': status,
//       'time': time,
//       'date': date,
//       'distance': distance,
//     };
//     properties.removeWhere((key, value) => value == null);
//     CleverTapPlugin.recordEvent(eventName, properties);
//   }

//   /// this method should be called whenever required event is received
//   static void trackRCEvent(
//     String screenName,
//     String eventName, {
//     String? eventType,
//     String? eventProperty,
//     String? subscriptionPlan,
//     String? validity,
//     String? services,
//     String? credits,
//     String? amount,
//     String? scheduleVisitsTab,
//     String? memberId,
//     String? memberName,
//     String? status,
//     String? time,
//     String? date,
//     String? distance,
//   }) {
//     Map<String, dynamic> properties = {
//       'Pod Type': 'Retirement-Consultancy',
//       'Screen Name': screenName,
//       'Event Type': eventType,
//       'subscription_plan': subscriptionPlan,
//       'validity': validity,
//       'services': services,
//       'credits': credits,
//       'amount': amount,
//       'schedule_visits_tab': scheduleVisitsTab,
//       'member_id': memberId,
//       'member_name': memberName,
//       'status': status,
//       'time': time,
//       'date': date,
//       'distance': distance,
//     };
//     properties.removeWhere((key, value) => value == null);
//     CleverTapPlugin.recordEvent(eventName, properties);
//   }

//   /// this method should be called to track the events
//   static void trackError(String errorMessage, String podName,
//       {String? screenName}) {
//     Map<String, dynamic> errorProperties = {
//       'Pod Type': podName,
//       'Error': errorMessage,
//       'Screen Name': screenName
//     };
//     // Implement the logic to send the error message to your analytics provider.
//     CleverTapPlugin.recordEvent('error_trace', errorProperties);
//   }

//   /// this method should be called once at time authentication
//   // static void setUser(String userName, String userContactNumber) {
//   static void setUser(String userContactNumber) {
//     Map<String, dynamic> profile = {
//       'Identity':
//           userContactNumber, //Identity is compulsory field for clever tap logs
//       'Phone': userContactNumber
//     };
//     CleverTapPlugin.onUserLogin(profile);
//   }
// }
