import 'package:common/features/my_profile/infrastructure/dtos/get_permissions_response_dto.dart';
import 'package:common/features/my_profile/infrastructure/repo/get_permissions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_manage_permission_api_provider.g.dart';

@Riverpod(keepAlive: true)
class GetManagePermissionApiNotifier extends _$GetManagePermissionApiNotifier {
  // late bool monthlyNSDLStatementAutoGeneration;
  // late bool emailSync;
  // late bool monthlyECASSync;

  // setMonthlyNSDL(bool value) {
  //   monthlyNSDLStatementAutoGeneration = value;
  // }
  //
  // setEmailSync(bool value) {
  //   emailSync = value;
  // }
  //
  // setMonthlyECASSync(bool value) {
  //   monthlyECASSync = value;
  // }

  @override
  FutureOr<GetPermissionResponseDto?> build() {
    return null;
  }

  Future<dynamic> callGetManagePermissionApi() async {
    try {
      // state = const AsyncValue.loading();
      final getPermissionInfoRepo = ref.watch(getPermissionsRepoProvider);

      final response = await getPermissionInfoRepo.getPermissionRepo();
      if (response.status == 200) {
        if (response.data?.config != null) {
          ref.read(permissionNSDLApiNotifierProvider.notifier).setValue(
              response.data!.config!.monthlyNSDLStatementAutoGeneration!);
          ref
              .read(getManagePermissionEmailSyncApiNotifierProvider.notifier)
              .setValue(response.data!.config!.emailSync!);
          ref
              .read(getManagePermissionMonthlyECASApiNotifierProvider.notifier)
              .setValue(response.data!.config!.monthlyECASSync!);
        }
        state = AsyncValue.data(response);
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      rethrow;
    }
  }

  callSavePermissionsApi() async {
    try {
      state = const AsyncValue.loading();
      final savePermissionRepo = ref.watch(getPermissionsRepoProvider);
      dynamic requestBody = {
        "monthlyNSDLStatementAutoGeneration": ref.watch(permissionNSDLApiNotifierProvider)== 0,
        "monthlyECASSync": ref.watch(getManagePermissionMonthlyECASApiNotifierProvider) == 0,
        "emailSync": ref.watch(getManagePermissionEmailSyncApiNotifierProvider)== 0,
      };

      final result = await savePermissionRepo.savePermissionRepo(requestBody);
      state = AsyncValue.data(result);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
class PermissionNSDLApiNotifier extends _$PermissionNSDLApiNotifier {
  @override
  int build() {
    return -1;
  }

  setValue(bool newValue) {
    if (newValue) {
      state = 0;
    } else {
      state = 1;
    }
  }
}

@Riverpod(keepAlive: true)
class GetManagePermissionMonthlyECASApiNotifier
    extends _$GetManagePermissionMonthlyECASApiNotifier {
  @override
  int build() {
    return -1;
  }

  setValue(bool newValue) {
    if (newValue) {
      state = 0;
    } else {
      state = 1;
    }
  }
}

@Riverpod(keepAlive: true)
class GetManagePermissionEmailSyncApiNotifier
    extends _$GetManagePermissionEmailSyncApiNotifier {
  @override
  int build() {
    return -1;
  }

  setValue(bool newValue) {
    if (newValue) {
      state = 0;
    } else {
      state = 1;
    }
  }
}
