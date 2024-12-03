import 'package:common/core/infrastructure/dtos/pincode_list_dto.dart';
import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/features/profile/presentation/common_imports.dart';

part 'pincode_repo.g.dart';

@Riverpod(keepAlive: true)
FutureOr<PincodeListDto> getPincodes(ref) async {
  return await ref.read(pincodeRepoProvider).getPincodeList();
}

@Riverpod(keepAlive: true)
PincodeRepo pincodeRepo(PincodeRepoRef ref) {
  return PincodeRepo(ref, api: ref.watch(apiFacadeProvider));
}

class PincodeRepo {
  // static const String sendOnBoardingOtp = "/care100/pincode/base/list";
  final PincodeRepoRef ref;
  final ApiFacade api;

  PincodeRepo(this.ref, {required this.api});

  // Future<PincodeListDto> getPincodeList() async {
  //   try {
  //     final response =
  //         await api.getDataRaw(path: sendOnBoardingOtp, sendToken: true);
  //     if (response.data != null) {
  //       return pincodeListDtoFromJson(jsonEncode(response.data));
  //     } else {
  //       return pincodeListDtoFromJson(jsonEncode(response.data));
  //     }
  //   } on DioException catch (e) {
  //     return pincodeListDtoFromJson(jsonEncode(e.response?.data));

  //     // print('inside DioException catch: ${e.response?.data.toString()}');
  //   } catch (e) {
  //     throw ServerException(
  //       type: ServerExceptionType.notFound,
  //       message: '$e',
  //     );
  //   }
  // }
}
