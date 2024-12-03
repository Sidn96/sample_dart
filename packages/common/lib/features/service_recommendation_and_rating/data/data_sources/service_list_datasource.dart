import 'package:common/core/infrastructure/network/main_api/api_callers/api_facade.dart';
import 'package:common/features/service_recommendation_and_rating/data/dtos/service_list_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_list_datasource.g.dart';

@riverpod
ServiceListRemoteDataSourceImpl serviceListRemoteDataSourceImpl(
    ServiceListRemoteDataSourceImplRef ref) {
  return ServiceListRemoteDataSourceImpl(api: ref.watch(apiFacadeProvider));
}

abstract class OnboardingFlowDataSource {
  FutureOr<ServiceListDto?> getPalCategories(int serviceId);
}

class ServiceListRemoteDataSourceImpl implements OnboardingFlowDataSource {
  final ApiFacade api;

  static const String servicesCategoryEndPoint = '/tp/pal/service-category';

  ServiceListRemoteDataSourceImpl({required this.api});

  @override
  FutureOr<ServiceListDto?> getPalCategories(int serviceId) async {
    try {
      final response = await api.getData(
          path: servicesCategoryEndPoint,
          queryParameters: {"id": serviceId},
          sendToken: true);
      if (response.data == null) {
        return null;
      }

      return ServiceListDto.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }
}
