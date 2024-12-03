import 'dart:developer';

import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';

import '../../infrastructure/dtos/member_details_dto.dart';
import '../../infrastructure/entity/member_addresses_entity.dart';

part 'member_booking_map_address_provider.g.dart';

@riverpod
class AddressSuggestionController extends _$AddressSuggestionController {
  @override
  TextEditingController build() => TextEditingController();

  changeState(String value) {
    state.text = value;
  }
}

@Riverpod(keepAlive: true)
class AddressSuggestionNotifier extends _$AddressSuggestionNotifier {
  @override
  bool build() => false;
  changeState(bool value) => state = value;
}

@riverpod
class MapAddressButtonEnable extends _$MapAddressButtonEnable {
  @override
  bool build() => false;
  changeState(bool value) => state = value;

  checkValidate() async {
    final saveAddress = ref.read(memberBookingMapAddressProvider);
    // final PincodeListDto data = await ref.watch(getPincodesProvider.future);

    saveAddress.toJson().entries.forEach((data) {
      if (data.value == null || data.value == "") {
        state = false;
        return;
      } else {
        state = true;
      }
    });

    log("form $state");
  }
}

@Riverpod(keepAlive: true)
class MemberBookingMapAddress extends _$MemberBookingMapAddress {
  @override
  AddressElement build() {
    return AddressElement();
  }

  changeState(AddressElement newvalue, {bool? forEditAddress}) {
    AddressElement updatedValue = AddressElement(
      forEdit: forEditAddress ?? state.forEdit ?? forEditAddress,
      forTap: newvalue.forTap ?? state.forTap,
      memberAddresses: MemberAddress(
        id: newvalue.memberAddresses?.id ?? state.memberAddresses?.id,
        lat: newvalue.memberAddresses?.lat ?? state.memberAddresses?.lat,
        long: newvalue.memberAddresses?.long ?? state.memberAddresses?.long,
        addressLine1: newvalue.memberAddresses?.addressLine1 ??
            state.memberAddresses?.addressLine1,
        addressLine2: newvalue.memberAddresses?.addressLine2 ??
            state.memberAddresses?.addressLine2,
        landmark: newvalue.memberAddresses?.landmark ??
            state.memberAddresses?.landmark,
        label: newvalue.memberAddresses?.label ?? state.memberAddresses?.label,
        city: newvalue.memberAddresses?.city ?? state.memberAddresses?.city,
        state: newvalue.memberAddresses?.state ?? state.memberAddresses?.state,
        pincode:
            newvalue.memberAddresses?.pincode ?? state.memberAddresses?.pincode,
      ),
    );

    state = updatedValue;
  }
}
