part of '../../ad_service.dart';

class AdvertisementState extends Equatable {
  const AdvertisementState({
    this.bannerAd,
  });

  final BannerAd? bannerAd;

  @override
  List<Object?> get props => <Object?>[bannerAd];
}
