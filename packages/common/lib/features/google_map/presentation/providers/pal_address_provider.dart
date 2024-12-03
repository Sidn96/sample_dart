import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../infrastructure/entity/member_address_entity.dart';

part 'pal_address_provider.g.dart';

@riverpod
class PalAddressesNotifier extends _$PalAddressesNotifier {
  void addNewAddress(MapAddressEntity newAddress) {
    List<MapAddressEntity> rawAddresses = [...state];
    rawAddresses.add(newAddress);
    state = [...rawAddresses];
  }

  @override
  List<MapAddressEntity> build() {
    return [];
  }

  void updateAddress(MapAddressEntity editedAddress) {
    List<MapAddressEntity> rawAddresses = [...state];
    rawAddresses[editedAddress.editingIndex!] = editedAddress;
    state = [...rawAddresses];
  }

  void updateState(List<MapAddressEntity>? modelData) {
    if (modelData != null) {
      state = modelData;
    }
  }
}

@riverpod
class SelectedAddressIndexNotifier extends _$SelectedAddressIndexNotifier {
  @override
  int build() {
    return 0;
  }

  void updateIndex(int index) {
    state = index;
  }
}
