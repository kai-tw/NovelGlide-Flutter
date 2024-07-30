import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class AdvertisementCubit extends Cubit<AdvertisementState> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  late int _width;
  final String adUnitId;
  BannerAd? bannerAd;

  AdvertisementCubit({required this.adUnitId}) : super(const AdvertisementState());

  void init(int width) async {
    _width = width;
    _subscription = InAppPurchase.instance.purchaseStream.listen(_purchaseSubscriptionHandler, onDone: () {
      _subscription.cancel();
    }, onError: (error) {});
    InAppPurchase.instance.restorePurchases();
  }

  void loadAd() async {
    final AnchoredAdaptiveBannerAdSize? size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(_width);

    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: size ?? AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!isClosed) {
            emit(AdvertisementState(bannerAd: ad as BannerAd));
          }
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  void _purchaseSubscriptionHandler(List<PurchaseDetails> purchaseDetailsList) {
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.restored:
          final Set<String> noAdIdSet = {"starter.monthly"};
          if (noAdIdSet.contains(purchaseDetails.productID)) {
            return;
          }
          InAppPurchase.instance.completePurchase(purchaseDetails);
          break;
        default:
      }
    }
    loadAd();
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
