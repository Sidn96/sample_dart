import 'package:common/features/my_profile/presentation/components/manage_permission_component.dart';
import 'package:common/features/my_profile/presentation/components/my_profile_account_details_section.dart';
import 'package:common/features/my_profile/presentation/components/my_profile_header_view.dart';
import 'package:common/features/my_profile/presentation/providers/get_account_details_api_provider.dart';
import 'package:common/features/my_profile/presentation/providers/get_manage_permission_api_provider.dart';
import 'package:common/features/my_profile/presentation/widgets/my_profile_card_template.dart';
import 'package:common/features/my_profile/presentation/widgets/my_profile_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyProfileMainScreen extends HookConsumerWidget {
  const MyProfileMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref
            .read(getAccountDetailsApiNotifierProvider.notifier)
            .callGetAccountDetailsApi();

       // ref.read(getManagePermissionApiNotifierProvider.notifier).callGetManagePermissionApi();
      });

      return null;
    }, []);
    final TabController tabController = useTabController(initialLength: 4);
    var tabIndex = useState(0);

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          const MyProfileHeaderView(),
          MyProfileTabBarView(
              tabController: tabController,
              selectedTab: tabIndex.value,
              onTabChanged: (v) {
                tabIndex.value = v;
              }),
          const MyProfileCardTemplate(
            widget: MyProfileAccountDetails(),
          ),
          const ManagePermissionComponent(),
        ],
      ),
    );
  }
}
