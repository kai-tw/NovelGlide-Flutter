import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'advertisement_state.dart';

class AdvertisementCubit extends Cubit<AdvertisementState> {
  factory AdvertisementCubit(String adUnitId, double width) {
    final AdvertisementCubit cubit = AdvertisementCubit._internal(
      adUnitId,
      const AdvertisementState(),
    );
    cubit.loadAd(width.truncate());
    return cubit;
  }

  AdvertisementCubit._internal(this._adUnitId, super.initialState);

  final String _adUnitId;

  Future<void> loadAd(int width) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);

    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: size ?? AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          if (!isClosed) {
            // Dispose of the old ad.
            state.bannerAd?.dispose();

            // Update the state to display the new ad.
            emit(AdvertisementState(bannerAd: ad as BannerAd));
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError err) {
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Future<void> close() async {
    state.bannerAd?.dispose();
    super.close();
  }
}
