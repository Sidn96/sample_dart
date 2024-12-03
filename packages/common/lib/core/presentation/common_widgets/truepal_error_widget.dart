import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/core/presentation/widgets/retire100_images_asset_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class TruepalErrorWidget extends ConsumerWidget {
  final Function() onSuccessHandler;
  const TruepalErrorWidget({
    super.key,
    required this.onSuccessHandler,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Retire100SvgImageAssetWidget(
            path: AppImages.cancelledCircle,
            package: "common",
          ),
          20.height,
          const AppText(
            data: "Something went wrong\nplease try again",
            height: 1.4,
            fontSize: 18,
          ),
          20.height,
          MemberAngelAppButton(
            label: "Retry",
            onSuccessHandler: onSuccessHandler,
          )
        ],
      ),
    );
  }
}
