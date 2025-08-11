import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/ad_data.dart';
import '../../domain/entities/ad_unit_id.dart';
import '../../domain/use_cases/ad_check_enabled_use_case.dart';
import '../../domain/use_cases/ad_load_banner_ad_use_case.dart';
import 'advertisement_state.dart';

class AdvertisementCubit extends Cubit<AdvertisementState> {
  AdvertisementCubit(
    this._loadBannerAdUseCase,
    this._checkEnabledUseCase,
  ) : super(const AdvertisementState());

  final AdLoadBannerAdUseCase _loadBannerAdUseCase;
  final AdCheckEnabledUseCase _checkEnabledUseCase;

  Future<void> loadAd(AdUnitId unitId, int width) async {
    if (!_checkEnabledUseCase()) {
      // Ad is not enabled.
      return;
    }

    final AdData data = await _loadBannerAdUseCase(AdLoadBannerAdUseCaseParam(
      unitId: unitId,
      width: width,
    ));

    emit(AdvertisementState(
      adMobBannerAd: data.adMobBannerAd,
    ));
  }

  @override
  Future<void> close() async {
    state.adMobBannerAd?.dispose();
    super.close();
  }
}
