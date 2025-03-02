part of 'advertisement_cubit.dart';

class AdvertisementState extends Equatable {
  final BannerAd? bannerAd;

  @override
  List<Object?> get props => [bannerAd];

  const AdvertisementState({
    this.bannerAd,
  });
}
