import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/my_profile/presentation/providers/get_manage_permission_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:common/features/my_profile/presentation/widgets/manage_permission_toggle_widget.dart';

class ManagePermissionComponent extends HookConsumerWidget {
  const ManagePermissionComponent({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(getManagePermissionApiNotifierProvider.notifier).callGetManagePermissionApi();
      });

      return null;
    }, []);
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0,bottom: 30),
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
        height: 256,
        width: Sizes.screenWidth() * 0.9,
        decoration: BoxDecoration(
            border: Border.all(color: ColorUtils.kGreyBorderColor),
            borderRadius: BorderRadius.circular(5)),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: AppConstants.managePermission,
              fontSize: 18,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w600,
              fontColor: ColorUtils.midnight,
            ),
            SizedBox(height: 32),
            ManagePermissionToggleWidget(title: AppConstants.monthlyNSDL),
            SizedBox(height: 32),
            ManagePermissionToggleWidget(title: AppConstants.monthlyECAS),
            SizedBox(height: 32),
            ManagePermissionToggleWidget(title: AppConstants.emailSync),
          ],
        ),
      ),
    );
  }
}
