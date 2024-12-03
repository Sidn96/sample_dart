import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/reverse_penny_drop/data/dtos/rpd_dto.dart';
import 'package:common/features/reverse_penny_drop/domain/repos/reverse_penny_drop_repo.dart';

part 'reverse_penny_drop_provider.g.dart';

@riverpod
class ReversePennyDrop extends _$ReversePennyDrop {
  @override
  FutureOr<RpdDto> build() async {
    return fetchRpdDetials();
  }

  Future<RpdDto> fetchRpdDetials() async {
    return await ref.read(rpdRepositoryProvider).fetchRpdDetials();
  }

  String? getPaymentLinks(String mode) {
    final allLinks = state.value?.data?.result?.paymentLinks;
    String? paymentUrl =
        allLinks?.where((link) => link.mode == mode).first.paymentUrl;
    return paymentUrl;
  }
}
