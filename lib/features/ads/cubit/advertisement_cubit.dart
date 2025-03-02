import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

part 'advertisement_id.dart';
part 'advertisement_state.dart';

class AdvertisementCubit extends Cubit<AdvertisementState> {
  late int _width;
  final String _adUnitId;

  final Logger _logger = Logger();

  factory AdvertisementCubit(String adUnitId, int width) {
    final cubit = AdvertisementCubit._internal(
      adUnitId,
      const AdvertisementState(),
    );
    // cubit.init(width);
    return cubit;
  }

  AdvertisementCubit._internal(this._adUnitId, super.initialState);

  void init(int width) async {
    loadAd();
  }

  void loadAd() async {
    final size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(_width);

    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: size ?? AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!isClosed) {
            // Dispose of the old ad.
            state.bannerAd?.dispose();

            // Update the state to display the new ad.
            emit(AdvertisementState(bannerAd: ad as BannerAd));
          }
        },
        onAdFailedToLoad: (ad, err) {
          _logger.e('onAdFailedToLoad: $err');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Future<void> close() async {
    state.bannerAd?.dispose();
    _logger.close();
    super.close();
  }
}
