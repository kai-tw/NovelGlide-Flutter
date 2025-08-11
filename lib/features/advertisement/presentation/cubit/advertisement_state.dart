import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdvertisementState extends Equatable {
  const AdvertisementState({
    this.adMobBannerAd,
  });

  final BannerAd? adMobBannerAd;

  @override
  List<Object?> get props => <Object?>[adMobBannerAd];
}
