import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdData extends Equatable {
  const AdData({
    this.adMobBannerAd,
  });

  final BannerAd? adMobBannerAd;

  @override
  List<Object?> get props => <Object?>[
        adMobBannerAd,
      ];
}
