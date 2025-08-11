import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/ad_data.dart';
import '../entities/ad_unit_id.dart';
import '../repositories/ad_repository.dart';

class AdLoadBannerAdUseCaseParam {
  AdLoadBannerAdUseCaseParam({
    required this.unitId,
    required this.width,
  });

  final AdUnitId unitId;
  final int width;
}

class AdLoadBannerAdUseCase
    extends UseCase<Future<AdData>, AdLoadBannerAdUseCaseParam> {
  AdLoadBannerAdUseCase(this._repository);

  final AdRepository _repository;

  @override
  Future<AdData> call(AdLoadBannerAdUseCaseParam parameter) {
    return _repository.loadBannerAd(parameter.unitId, parameter.width);
  }
}
