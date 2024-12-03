import 'package:common/core/presentation/widgets/toast_custom_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:location/location.dart" as loc;
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/consts/constant_app_strings.dart';
import '../../../../core/presentation/utils/app_images.dart';
import '../../../../core/presentation/widgets/retire100_images_asset_widget.dart';
import '../providers/address_map_provider.dart';
import '../providers/google_map_meta_provider.dart';
import '../providers/location_permission_handler_provider.dart';

class LocateMeButton extends ConsumerWidget {
  final ValueNotifier<bool> isLoading;
  final Function()? onPermanentDenied;

  const LocateMeButton({
    super.key,
    required this.isLoading,
    this.onPermanentDenied,
  });

  Future<void> allowedLocationAction(WidgetRef ref) async {
    final LatLng latLang = await getUserCurrentLocation();
    ref.read(latLangCommonCallProvider(latLang));
  }

  @override
  Widget build(BuildContext context, ref) {
    return ElevatedButton.icon(
      onPressed: () async {
        isLoading.value = true;
        loc.Location location = loc.Location();
        bool serviceEnabled = await location.requestService();
        if (serviceEnabled) {
          final PermissionStatus status = await checkLocationStatus();
          if (status == PermissionStatus.granted) {
            await allowedLocationAction(ref);
          } else if (status == PermissionStatus.denied) {
            final locationPermission = await ref
                .read(locationPermissionHandlerProvider.notifier)
                .requestLocationPermission();

            if (locationPermission == MapLocationAccess.allowedLocation) {
              await allowedLocationAction(ref);
            } else {
              if (kIsWeb) {
                showToastBox(context,
                    message: AppStrings.locationPermissionDenied,
                    status: ToastStatus.defaultt);
              }
            }
          } else if (status == PermissionStatus.permanentlyDenied) {
            final locationPermission = await ref
                .read(locationPermissionHandlerProvider.notifier)
                .requestLocationPermission();

            if (locationPermission ==
                MapLocationAccess.noLocationPermissionPermanent) {
              onPermanentDenied?.call();
            } else if (locationPermission ==
                MapLocationAccess.allowedLocation) {
              await allowedLocationAction(ref);
            }
          }
        }
        isLoading.value = false;
      },
      icon: const Retire100SvgImageAssetWidget(
        path: AppImages.locateme,
        color: ColorUtils.orange,
        width: 20,
        height: 20,
        package: "common",
      ),
      label: const AppText(
        data: "Locate Me",
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontColor: ColorUtils.orange,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtils.warningCircle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: const BorderSide(color: ColorUtils.orange, width: 1.0),
        ),
      ),
    );
  }
}
