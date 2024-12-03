import 'package:common/core/infrastructure/dtos/user_info_request_dto.dart';
import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/features/my_profile/infrastructure/dtos/get_account_details_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_account_details_datasource.g.dart';

@Riverpod(keepAlive: true)
GetAccountDetailsDataSource getAccountDetailsDataSource(
    GetAccountDetailsDataSourceRef ref) {
  return GetAccountDetailsDataSource(ref.read(apiFacadeProvider));
}

class GetAccountDetailsDataSource {
  final ApiFacade _api;

  GetAccountDetailsDataSource(this._api);

  final String _getAccountDetailsPath = "/member/account-details";
  final String _editProfilePath = "/member/edit-profile";

  Future<GetAccountDetailsResponseDto> getAccountDetails() async {
    try {
      final response =
          await _api.getData(path: _getAccountDetailsPath, sendToken: true);
      if (response.data != null) {
        GetAccountDetailsResponseDto newInfo =
            GetAccountDetailsResponseDto.fromJson(response.data);

        return newInfo;
      } else {
        throw const ServerException(
          type: ServerExceptionType.notFound,
          message: 'data not found.',
        );
      }
    } on DioException catch (e) {
      return GetAccountDetailsResponseDto.fromJson(e.response?.data);
    } catch (e) {
      throw ServerException(
        type: ServerExceptionType.notFound,
        message: '$e',
      );
    }
  }

  Future<bool> updateProfile(UserInfoRequestDto requestBody) async {
    try {
      final body = {};

      requestBody.toJson().entries.forEach((element) {
        if (element.value != null) {
          body.addEntries({element.key: element.value}.entries);
        }
      });

      final response = await _api.postDataRaw(
          path: _editProfilePath, sendToken: true, data: body);
      if (response.data != null) {
        return response.data["success"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
