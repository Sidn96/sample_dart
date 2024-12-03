import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../providers/address_map_provider.dart';
import '../providers/location_permission_handler_provider.dart';
import '../widgets/address_map_widget_body.dart';
import '../widgets/map_body_widget.dart';
import '../widgets/no_location_permission_widget.dart';

class MapVisitAddressPage extends ConsumerStatefulWidget {
  final Widget bottomWidget;
  final bool asklocationPermission;
  final Function()? onPermanentDenied;

  const MapVisitAddressPage({
    super.key,
    required this.bottomWidget,
    this.asklocationPermission = false,
    this.onPermanentDenied,
  });

  @override
  ConsumerState<MapVisitAddressPage> createState() =>
      _MapVisitAddressPageState();
}

class _MapVisitAddressPageState extends ConsumerState<MapVisitAddressPage>
    with WidgetsBindingObserver {
  bool _detectPermission = false;

  @override
  Widget build(BuildContext context) {
    ref.watch(searchedGoogleMapAddressProvider);
    ref.watch(servicablePincodeEnableProvider);
    final locationPermission = ref.watch(locationPermissionHandlerProvider);
    final showBottomSheet = ref.watch(showAddressBottomSheetProvider);
    final showForceMap = ref.watch(showForceMapProvider);

    return Scaffold(
      body: widget.asklocationPermission == false
          ? MapBodyWidget(
              onPermanentDenied: widget.onPermanentDenied,
            )
          : locationPermission == MapLocationAccess.initialLoading
              ? const SizedBox.shrink()
              : (locationPermission != MapLocationAccess.allowedLocation &&
                      showForceMap == false)
                  ? const NoLocationPermissionWidget(forPermenentDenied: true)
                  : const AddressMapWidgetBody(),
      bottomNavigationBar: showBottomSheet ? widget.bottomWidget : null,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!kIsWeb) {
      // if (state == AppLifecycleState.resumed) {
      //   ref
      //       .read(locationPermissionHandlerProvider.notifier)
      //       .requestLocationPermission();
      // }
      final locationPermission = ref.watch(locationPermissionHandlerProvider);
      if (state == AppLifecycleState.resumed &&
          _detectPermission &&
          (locationPermission ==
              MapLocationAccess.noLocationPermissionPermanent)) {
        _detectPermission = false;
        if ((widget.asklocationPermission)) {
          ref
              .read(locationPermissionHandlerProvider.notifier)
              .requestLocationPermission();
        }
      } else if (state == AppLifecycleState.paused &&
          locationPermission ==
              MapLocationAccess.noLocationPermissionPermanent) {
        _detectPermission = true;
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.asklocationPermission) {
      ref
          .read(locationPermissionHandlerProvider.notifier)
          .requestLocationPermission();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    if (widget.asklocationPermission) {
      if (!kIsWeb) {
        ref
            .read(locationPermissionHandlerProvider.notifier)
            .requestLocationPermission();
      }
    }
    super.initState();
  }
}
