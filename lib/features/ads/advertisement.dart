import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'cubit/advertisement_cubit.dart';

export 'cubit/advertisement_cubit.dart';

class Advertisement extends StatelessWidget {
  const Advertisement({super.key, required this.adType});

  final AdvertisementType adType;

  @override
  Widget build(BuildContext context) {
    // Ads are disabled currently.
    if (kReleaseMode && 1 == 0) {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return BlocProvider<AdvertisementCubit>(
          create: (BuildContext context) =>
              AdvertisementCubit(adType.id, constraints.maxWidth),
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
