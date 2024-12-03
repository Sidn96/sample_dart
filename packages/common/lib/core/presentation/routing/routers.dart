import 'package:common/core/presentation/components/payment_gateway_page_native.dart';
import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/screens/coming_soon_screen.dart';
import 'package:common/features/blogs/domain/blog_item_model.dart';
import 'package:common/features/blogs/presentation/screens/details_page/blog_detail_screen.dart';
import 'package:common/features/blogs/presentation/screens/listing_page/blog_listing_screen.dart';
import 'package:common/features/common_html_view/presentation/common_html_page.dart';
import 'package:common/features/legal_disclaimer/legal_disclaimer_page.dart';
import 'package:common/features/login_signup/presentation/screens/retire100_login.dart';
import 'package:common/features/login_signup/presentation/screens/retire100_signup_screen.dart';
import 'package:common/features/my_profile/presentation/screens/my_profile_main_screen.dart';
import 'package:common/features/privacy_policy/presentation/privacy_policy_page.dart';
import 'package:common/features/terms_conditions/presentation/terms_conditions_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/login_signup/presentation/screens/signup_success_screen.dart';
import '../../infrastructure/local_storage_data_source/secure_storage.dart';
import '../extensions/widget_extension.dart';
import '../styles/color_utils.dart';
import '../styles/sizes.dart';
import '../utils/app_text.dart';

// GoRouter configuration
final commonRouterConfig = GoRouter(
  routes: commonRoutes,
  initialLocation: '/common',
  // redirect: (context, state) => '/nps/',
);
final commonRoutes = [
  // GoRoute(
  //   path: '/',
  //   redirect: (_, __) => '/care100',
  // ),
  ShellRoute(
    builder: (context, state, child) => child,
    routes: [
      GoRoute(
        path: '/common',
        name: 'common',
        builder: (_, __) => Center(
          child: Container(),
        ),
        routes: [
          GoRoute(
            path: 'login-signup',
            name: CommonRouteString.loginSignupRoute,
            builder: (_, __) => const Retire100SignUpScreen(),
          ),
          GoRoute(
            path: 'login',
            name: CommonRouteString.newLoginRoute,
            builder: (_, __) => const Retire100LoginPage(),
          ),
          GoRoute(
            path: 'successfull-signup',
            name: CommonRouteString.successSignupRoute,
            builder: (_, __) => const SignUpSuccessScreen(),
          ),

          //TODO : revert if native code won't work
          // GoRoute(
          //   path: 'paymentgateway',
          //   name: 'payment-gateway',
          //   builder: (context, state) => PaymentGatewayPage(
          //     details: state.extra as CheckoutDetails,
          //   ),
          // ),
          GoRoute(
            path: 'paymentgateway',
            name: 'payment-gateway',
            builder: (context, state) => PaymentGatewayNativePage(
              podDetails: state.extra as Map<String, dynamic>,
            ),
          ),
        ],
      ),
      GoRoute(
          path: '/my-profile',
          name: CommonRouteString.myProfileRoute,
          builder: (context, state) => const MyProfileMainScreen()),
      /*GoRoute(
          path: '/${CommonRouteString.widgetBook}',
          name: CommonRouteString.widgetBook,
          builder: (context, state) => const Retire100WidgetBook()),*/
      GoRoute(
        path: '/logout',
        name: 'logout',
        builder: (_, __) => const Logout(),
      ),
      GoRoute(
        path: "/blog-details",
        name: "/blog-details",
        builder: (context, state) =>
            BlogDetailScreen(blogItemData: state.extra as BlogItemData),
      ),
      GoRoute(
        path: "/blog-videos-listing",
        name: "blog-videos-listing",
        builder: (context, state) => BlogVideosListingScreen(
            params: state.extra as Map<String, dynamic>?),
      ),
      GoRoute(
        path: "/coming-soon",
        name: "/coming-soon",
        builder: (context, state) => ComingSoonScreen(
          title: (state.extra is String) ? (state.extra as String) : null,
        ),
      ),
      GoRoute(
          path: "/${CommonRouteString.termsAndConditions}",
          name: CommonRouteString.termsAndConditions,
          builder: (context, state) {
            return const TermsConditionsPage();
          }),
      GoRoute(
          path: "/${CommonRouteString.legalDisclaimer}",
          name: CommonRouteString.legalDisclaimer,
          builder: (context, state) {
            return const LegalDisclaimerPage();
          }),
      GoRoute(
          path: "/${CommonRouteString.privacyPolicy}",
          name: CommonRouteString.privacyPolicy,
          builder: (context, state) {
            return const PrivacyPolicyPage();
          }),
      GoRoute(
        path: CommonRouteString.commonHtmlView,
        name: CommonRouteString.commonHtmlView,
        builder: (context, state) => CommonHtmlPage(
          title:
              state.extra is Map ? ((state.extra as Map)["title"] ?? "") : "",
          htmlContentUrl: state.extra is Map
              ? (state.extra as Map)["htmlContentUrl"] ?? ""
              : "",
        ),
      ),
    ],
  ),
];

final commonRoutesArray = commonRoutes[0].routes;

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 16.0, bottom: 12.0),
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              style: unfilledButtonStyle(),
              onPressed: () {
                SecureStorage().deleteAllPref();
              },
              child: const AppText(
                  data: "Log Out",
                  fontSize: Sizes.textSize12,
                  fontColor: ColorUtils.kBlueColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
