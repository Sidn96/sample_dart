// import 'package:flutter/material.dart';
//
// import '../helpers/localization_helper.dart';
// import '../routing/app_router.dart';
// import '../styles/font_styles.dart';
// import '../styles/sizes.dart';
// import '../widgets/custom_button.dart';
// import '../widgets/custom_text.dart';
//
// class RouteErrorComponent extends StatelessWidget {
//   const RouteErrorComponent({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         CustomText.f20(
//           context,
//           tr(context).screenNotFound,
//           textAlign: TextAlign.center,
//           weight: FontStyles.fontWeightSemiBold,
//         ),
//         const SizedBox(
//           height: Sizes.marginV28,
//         ),
//         CustomButton(
//           text: tr(context).goToHome,
//           onPressed: () {
//             const SignInRoute().go(context);
//           },
//           buttonColor: Theme.of(context).colorScheme.primary,
//         )
//       ],
//     );
//   }
// }
