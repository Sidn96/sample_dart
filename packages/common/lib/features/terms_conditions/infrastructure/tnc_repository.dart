import 'package:common/core/infrastructure/error/app_exception.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/core/presentation/utils/api_source_constants.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/env/env.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tnc_repository.g.dart';

@riverpod
TnCRepository getTnCRepository(GetTnCRepositoryRef ref) {
  return TnCRepository(apiFacade: ref.read(apiFacadeProvider));
}

class TnCRepository {
  final ApiFacade apiFacade;

  TnCRepository({required this.apiFacade});

  Future<Either<String, String>> getTnc() async {
    try {
      final response = await apiFacade.getData(
          path: "${Env.baseUrlFromEnv}member/admin/getPolicyDoc?type=tnc");
      if (response.statusCode == 200) {
        return right(response.data);
      }
      return left(AppConstants.somethingWrong);
    } catch (e) {
      if (e is ServerException) return left(e.message);
      return left(e.toString());
    }
  }

  Future<Either<String, String>> getPrivacyPolicy() async{
     try {
      final response = await apiFacade.getData(
          path: "${Env.baseUrlFromEnv}member/admin/getPolicyDoc?type=privacy");
      if (response.statusCode == 200) {
        return right(response.data);
      }
      return left(AppConstants.somethingWrong);
    } catch (e) {
      if (e is ServerException) return left(e.message);
      return left(e.toString());
    }
  }

  Future<Either<String, String>> getCommonHtmlContent(String url) async{
    try {
      final response = await apiFacade.getData(
          path: url);
      if (response.statusCode == 200) {
        return right(response.data);
      }
      return left(AppConstants.somethingWrong);
    } catch (e) {
      if (e is ServerException) return left(e.message);
      return left(e.toString());
    }
  }

  Future<Either<String, String>> getLegalDisclaimer() async{
     try {
      final response = await apiFacade.getData(
          path: "${Env.baseUrlFromEnv}member/admin/getPolicyDoc?type=legal");
      if (response.statusCode == 200) {
        return right(response.data);
      }
      return left(AppConstants.somethingWrong);
    } catch (e) {
      if (e is ServerException) return left(e.message);
      return left(e.toString());
    }
  }
}
