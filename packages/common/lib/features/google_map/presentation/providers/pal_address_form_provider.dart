import 'package:common/features/profile/presentation/common_imports.dart';

import '../../infrastructure/entity/member_address_entity.dart';

part 'pal_address_form_provider.g.dart';

@Riverpod(keepAlive: true)
class PalAddressFormState extends _$PalAddressFormState {
  @override
  MapAddressEntity build() {
    return const MapAddressEntity();
  }

  void setAddressLine1(String value) {
    state = state.copyWith(addressLine1: value);
  }

  void setAddressLine2(String value) {
    state = state.copyWith(addressLine2: value);
  }

  void setCity(String value) {
    state = state.copyWith(city: value);
  }

  void setLabel(String value) {
    state = state.copyWith(label: value);
  }

  void setLabelInfo(String value) {
    state = state.copyWith(labelInfo: value);
  }

  void setLandmark(String value) {
    state = state.copyWith(landmark: value);
  }

  void setLat(String value) {
    state = state.copyWith(lat: value);
  }

  void setLong(String value) {
    state = state.copyWith(long: value, hasEditedOrNewAdded: true);
  }

  void setPincode(String value) {
    state = state.copyWith(pincode: value);
  }

  void setStateData(String value) {
    state = state.copyWith(state: value);
  }

  void updateAddressState(MapAddressEntity newOrEditAddress,
      {int? editingIndex}) {
    state = newOrEditAddress;
    state =
        state.copyWith(editingIndex: editingIndex, hasEditedOrNewAdded: true);
  }
}
