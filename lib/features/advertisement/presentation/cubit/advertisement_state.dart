import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdvertisementState extends Equatable {
  const AdvertisementState({
    required this.isEnabled,
    this.adMobBannerAd,
  });

  final bool isEnabled;
  final BannerAd? adMobBannerAd;

  @override
  List<Object?> get props => <Object?>[
        isEnabled,
        adMobBannerAd,
      ];

  AdvertisementState copyWith({
    bool? isEnabled,
    BannerAd? adMobBannerAd,
  }) {
    return AdvertisementState(
      isEnabled: isEnabled ?? this.isEnabled,
      adMobBannerAd: adMobBannerAd ?? this.adMobBannerAd,
    );
  }
}
