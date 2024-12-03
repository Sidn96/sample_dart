import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/widgets/retire100_images_asset_widget.dart';
import 'package:common/core/presentation/widgets/toast_custom_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:location/location.dart" as loc;
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/consts/constant_app_strings.dart';
import '../providers/address_map_provider.dart';
import '../providers/google_map_meta_provider.dart';
import '../providers/location_permission_handler_provider.dart';
import '../providers/member_booking_map_address_provider.dart';

class UseMyCurrentLocationWidget extends ConsumerWidget {
  final ValueNotifier<bool> isloading;
  final bool isFromMapPage;
  final Function()? onClick;
  final Function()? onPermanentDenied;

  const UseMyCurrentLocationWidget({
    super.key,
    required this.isloading,
    this.isFromMapPage = true,
    this.onClick,
    this.onPermanentDenied,
  });

  Future<void> allowedLocationAction(
      WidgetRef ref, BuildContext context) async {
    if (isFromMapPage) {
      isloading.value = true;
      FocusScope.of(context).unfocus();
      final LatLng latLang = await getUserCurrentLocation();
      ref.read(latLangCommonCallProvider(latLang));
      ref.read(addressSuggestionNotifierProvider.notifier).changeState(false);
      // ref.read(serviceHomeProvider.notifier).getServiceHomeData();
      isloading.value = false;
    } else {
      onClick?.call();
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(locationPermissionHandlerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () async {
          loc.Location location = loc.Location();
          bool serviceEnabled = await location.requestService();
          if (serviceEnabled) {
            final PermissionStatus status = await checkLocationStatus();
            if (status == PermissionStatus.granted) {
              await allowedLocationAction(ref, context);
            } else if (status == PermissionStatus.denied) {
              final locationPermission = await ref
                  .read(locationPermissionHandlerProvider.notifier)
                  .requestLocationPermission();

              if (locationPermission == MapLocationAccess.allowedLocation) {
                await allowedLocationAction(ref, context);
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
                await allowedLocationAction(ref, context);
              }
            }
          }
        },
        child: Row(
          children: [
            const Retire100ImageAssetWidget(
              path: AppImages.mylocationcircle,
              height: 20,
              package: "common",
            ),
            6.width,
            const AppText(
              data: AppStrings.useMyCurrentLocation,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontColor: ColorUtils.kblueMid,
            ),
          ],
        ),
      ),
    );
  }
}
