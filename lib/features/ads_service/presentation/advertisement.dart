part of '../ad_service.dart';

class Advertisement extends StatelessWidget {
  const Advertisement({super.key, required this.unitId});

  final AdUnitId unitId;

  @override
  Widget build(BuildContext context) {
    if (AdService.isAllowed) {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return BlocProvider<AdvertisementCubit>(
          create: (_) => AdvertisementCubit(unitId.id, constraints.maxWidth),
          child: BlocBuilder<AdvertisementCubit, AdvertisementState>(
            builder: (BuildContext context, AdvertisementState state) {
              if (state.bannerAd == null) {
                return const SizedBox.shrink();
              } else {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: state.bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: state.bannerAd!),
                );
              }
            },
          ),
        );
      });
    } else {
      return const SizedBox.shrink();
    }
  }
}
