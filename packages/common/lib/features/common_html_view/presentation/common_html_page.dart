import 'package:common/core/presentation/components_v2/app_bar_v2.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:common/env/env.dart';
import 'package:common/features/common_html_view/presentation/common_html_app_view.dart'
    if (dart.library.html) 'package:common/features/common_html_view/presentation/common_html_mweb_view.dart';
import 'package:common/features/common_html_view/provider/common_html_state_notifier.dart';
import 'package:common/features/privacy_policy/provider/privacy_state_notifier.dart';
import 'package:common/features/terms_conditions/provider/tnc_state_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';

class CommonHtmlPage extends HookConsumerWidget {
  final String title;
  final String htmlContentUrl;

  const CommonHtmlPage(
      {super.key, required this.title, required this.htmlContentUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future((){
        ref
            .read(commonHtmlStateNotifierProvider.notifier)
            .fetchAndSetContent(htmlContentUrl);
      });

      return null;
    }, []);
    return Scaffold(
        appBar: AppBarV2(
            toolbarHeight: kToolbarHeight,
            actionWidgets: const [SizedBox()],
            backgroundColor: ColorUtilsV2.hex_F5F5FF,
            title: title,
            centerTitle: true,
            onLeadingTap: null),
        body: Consumer(
          builder: (context, ref, child) {
            AsyncValue state = ref.watch(commonHtmlStateNotifierProvider);
            return state.when(
              data: (data) {
                return CommonHtmlView(htmlContent: data);
              },
              error: (error, stackTrace) {
                print("inside error");
                return Center(
                  child: AppTextV2(
                      data: error.toString(),
                      fontSize: 12.0,
                      fontColor: Colors.black),
                );
              },
              loading: () {
                return const CommonTrueFinLoader();
              },
            );
          },
        ));
  }
}
