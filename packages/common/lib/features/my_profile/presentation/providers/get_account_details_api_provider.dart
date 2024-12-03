import 'package:common/features/my_profile/infrastructure/dtos/get_account_details_response_dto.dart';
import 'package:common/features/my_profile/infrastructure/repo/my_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_account_details_api_provider.g.dart';

@riverpod
class GetAccountDetailsApiNotifier extends _$GetAccountDetailsApiNotifier {
  late TextEditingController emailTextController;

  @override
  FutureOr<GetAccountDetailsResponseDto?> build() {
    emailTextController = TextEditingController();
    return null;
  }

  Future<dynamic> callGetAccountDetailsApi() async {
    try {
      state = const AsyncValue.loading();
      final getMemberInfoRepo = ref.watch(myProfileRepoProvider);

      final response = await getMemberInfoRepo.getAccountDetailsRepo();
      if (response.status == 200) {
        if (response.data?.personalEmail != null) {
          emailTextController.text = response.data!.personalEmail!;
        }
        state = AsyncValue.data(response);
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      rethrow;
    }
  }
}

@riverpod
AccountDetailsData? accountDetailsData(AccountDetailsDataRef ref) {
  final accountDetailsResponse =
      ref.watch(getAccountDetailsApiNotifierProvider);

  if (accountDetailsResponse.value?.status == 200) {
    return accountDetailsResponse.value?.data;
  }

  return null;
}
