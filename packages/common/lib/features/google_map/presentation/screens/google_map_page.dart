import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/google_map_meta_provider.dart';
import '../providers/location_permission_handler_provider.dart';

class GoogleMapPage extends ConsumerWidget {
  final Function(LatLng)? onTap;
  const GoogleMapPage({super.key, this.onTap});

  @override
  Widget build(BuildContext context, ref) {
    final gMapController = ref.watch(truePalGoogleMapControllerProvider);
    final mapMarkers = ref.watch(mapMarkersProvider);
    final mapPolygons = ref.watch(mapPolygonProvider);
    final mapPolylines = ref.watch(mapPolylineProvider);
    final mapCircle = ref.watch(mapCircleProvider);
    final locationPermission = ref.watch(locationPermissionHandlerProvider);
    final currentLocation = ref.watch(initialMapLatalangProvider);
    return currentLocation.when(
      data: (data) {
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: data,
              zoom: locationPermission == MapLocationAccess.allowedLocation
                  ? 14.47
                  : 4.5),
          markers: mapMarkers,
          polygons: mapPolygons,
          polylines: mapPolylines,
          circles: mapCircle,
          onMapCreated: (GoogleMapController controller) {
            gMapController.complete(controller);
          },
          myLocationButtonEnabled: false,
          onTap: onTap,
        );
      },
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}
