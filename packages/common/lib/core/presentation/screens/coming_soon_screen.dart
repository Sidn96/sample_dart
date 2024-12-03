import 'package:common/core/presentation/common_widgets/truefin_appbar.dart';
import 'package:common/core/presentation/components_v2/app_bar_v2.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComingSoonScreen extends StatelessWidget {
  final String? title;
  const ComingSoonScreen({super.key,this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarV2(
        toolbarHeight: kToolbarHeight,
        actionWidgets: const [SizedBox()],
        backgroundColor: ColorUtilsV2.hex_F5F5FF,
        title: title ??"",
        centerTitle: true,
        onLeadingTap: () {
        //  ref.read(selectedMoodCardsNotifierProvider.notifier).clearState();
         // context.pop();
        },
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ComingSoonWidgetView()),
    );
  }
}

class ComingSoonWidgetView extends StatelessWidget {
  const ComingSoonWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Image.asset(AssetUtils.comingSoonBg),
        ),
        Image.asset(AssetUtils.comingSoonMain,height: 350.w)
      ],
    );
  }
}
