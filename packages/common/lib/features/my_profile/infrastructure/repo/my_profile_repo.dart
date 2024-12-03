import 'package:common/core/infrastructure/dtos/user_info_request_dto.dart';
import 'package:common/core/infrastructure/network/network_info.dart';
import 'package:common/features/my_profile/infrastructure/data_sources/get_account_details_datasource.dart';
import 'package:common/features/my_profile/infrastructure/dtos/get_account_details_response_dto.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_profile_repo.g.dart';

@Riverpod(keepAlive: true)
MyProfileRepo myProfileRepo(MyProfileRepoRef ref) {
  return MyProfileRepo(
      getAccountDetailsDataSource:
          ref.watch(getAccountDetailsDataSourceProvider),
      networkInfo: ref.watch(networkInfoProvider));
}

class MyProfileRepo {
  MyProfileRepo(
      {required this.getAccountDetailsDataSource, required this.networkInfo});

  final NetworkInfo networkInfo;
  final GetAccountDetailsDataSource getAccountDetailsDataSource;

  Future<GetAccountDetailsResponseDto> getAccountDetailsRepo() async {
    dynamic accountDetails;
    try {
      accountDetails = await getAccountDetailsDataSource.getAccountDetails();

      return accountDetails;
    } catch (e) {
      debugPrint("Repo Error: $e");
    }
    return accountDetails;
  }

  Future<bool> updateProfileRepo(UserInfoRequestDto requestBody) async {
    dynamic accountDetails;
    try {
      accountDetails =
          await getAccountDetailsDataSource.updateProfile(requestBody);

      return accountDetails;
    } catch (e) {
      debugPrint("Repo Error: $e");
    }
    return accountDetails;
  }
}
