import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/service_recommendation_and_rating/data/data_sources/service_list_datasource.dart';
import 'package:common/features/service_recommendation_and_rating/data/dtos/service_list_dto.dart';
import 'package:common/features/service_recommendation_and_rating/domain/entities/service_data_entity.dart';

part 'service_list_provider.g.dart';

@riverpod
class ServiceListNotifier extends _$ServiceListNotifier {
  @override
  FutureOr<List<ServiceDataEntity>?> build() {
    return null;
  }

  FutureOr<List<ServiceDataEntity>?> getServiceCategories(int id) async {
    try {
      state = const AsyncValue.loading();

      final serviceListDataProvider =
          ref.read(serviceListRemoteDataSourceImplProvider);

      final data = await serviceListDataProvider.getPalCategories(id);

      List<ServiceSubGroup>? serviceSubGroups = data?.data?.serviceSubGroups;
      if (serviceSubGroups == null) return []; // early exit
      if (serviceSubGroups.isEmpty) return []; // early exit

      List<ServiceDataEntity> newServices = [];

      /// merge services from all serviceSubGroups
      for (int i = 0; i < serviceSubGroups.length; i++) {
        final services = serviceSubGroups[i].services;
        if (services != null) {
          for (int j = 0; j < services.length; j++) {
            newServices.add(ServiceDataEntity(
                id: services[j].id, serviceName: services[j].name));
          }
        }
      }

      state = AsyncValue.data(newServices);
      return state.value;
    } catch (e) {
      state = const AsyncError("error", StackTrace.empty);
      return state.value;
    }
  }
}
