import 'package:flutter/material.dart';

import 'confirm_map_location_bottom_sheet_widget.dart';
import 'map_location_bottom_sheet_widget.dart';

// this showModalBottomSheet for add another address and to edit address
showModalBottomSheetAnotherAddressForm(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    showDragHandle: false,
    backgroundColor: Colors.white,
    builder: (BuildContext bc) {
      return const MapLocationBottomSheetWidget();
    },
  );
}

// this showModalBottomSheet to confirm address and to edit address
showModalBottomSheetConfirmAddressLocation(
  BuildContext context, {
  Function()? onPermanentDenied,
}) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    showDragHandle: false,
    backgroundColor: Colors.white,
    builder: (BuildContext bc) {
      return ConfirmMapLocationBottomSheetWidget(
        onPermanentDenied: onPermanentDenied,
      );
    },
  );
}
