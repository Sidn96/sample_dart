import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/my_profile/presentation/providers/get_manage_permission_api_provider.dart';
import 'package:common/features/my_profile/presentation/widgets/permission_switch_widget.dart';
import 'package:flutter/material.dart';

class ManagePermissionToggleWidget extends HookConsumerWidget {
  final String title;

  const ManagePermissionToggleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSwitchPressed = useState<bool>(true);
    return Row(
      children: [
        AppText(
          data: title,
          fontSize: 14,
          height: 1.2,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w400,
          fontColor: ColorUtils.greyTextColor,
        ),
        const Spacer(),
        PermissionSwitchWidget(
          isSwitchPressedValue: permissionValues(ref),
          onSwitchPressed: (value) {
            if (title == AppConstants.monthlyNSDL) {
              ref.read(permissionNSDLApiNotifierProvider.notifier).setValue(value);
            } else if (title == AppConstants.monthlyECAS) {
              ref.read(getManagePermissionMonthlyECASApiNotifierProvider.notifier).setValue(value);
            } else {
              ref.read(getManagePermissionEmailSyncApiNotifierProvider.notifier).setValue(value);
            }
            ref
                .read(getManagePermissionApiNotifierProvider.notifier)
                .callSavePermissionsApi();
          },
        ),
        //toggleView(ansChosen, ref)
      ],
    );
  }

  bool permissionValues(WidgetRef ref){
    if( title == AppConstants.monthlyNSDL){
     return ref.watch(permissionNSDLApiNotifierProvider) == 0;
    } else if(title == AppConstants.monthlyECAS){
     return ref.watch(getManagePermissionMonthlyECASApiNotifierProvider) == 0;
    }else{
     return ref.watch(getManagePermissionEmailSyncApiNotifierProvider) == 0;
    }
  }
}
