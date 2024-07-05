import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdvertisementCubit extends Cubit<AdvertisementState> {
  final String adUnitId;
  BannerAd? bannerAd;

  AdvertisementCubit({required this.adUnitId}) : super(const AdvertisementState());

  void init(int width) async {
    final AnchoredAdaptiveBannerAdSize? size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);

    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: size != null ? AdSize(width: size.width, height: size.height) : AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          emit(AdvertisementState(bannerAd: ad as BannerAd));
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );
    // loadAd();
  }

  void loadAd() {
    bannerAd?.load();
  }

  @override
  Future<void> close() async {
    super.close();
    state.bannerAd?.dispose();
  }
}

class AdvertisementState extends Equatable {
  final BannerAd? bannerAd;

  @override
  List<Object?> get props => [bannerAd];

  const AdvertisementState({
    this.bannerAd,
  });
}
