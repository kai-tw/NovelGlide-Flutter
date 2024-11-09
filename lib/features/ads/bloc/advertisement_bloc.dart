part of '../advertisement.dart';

class _AdCubit extends Cubit<_State> {
  late int _width;
  final String _adUnitId;

  final Logger _logger = Logger();

  factory _AdCubit(String adUnitId, int width) {
    final cubit = _AdCubit._internal(
      adUnitId,
      const _State(),
    );
    cubit.init(width);
    return cubit;
  }

  _AdCubit._internal(this._adUnitId, super.initialState);

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
            emit(_State(bannerAd: ad as BannerAd));
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

class _State extends Equatable {
  final BannerAd? bannerAd;

  @override
  List<Object?> get props => [bannerAd];

  const _State({
    this.bannerAd,
  });
}
