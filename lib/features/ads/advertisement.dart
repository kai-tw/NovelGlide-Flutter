import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'cubit/advertisement_cubit.dart';

export 'cubit/advertisement_cubit.dart';

class Advertisement extends StatelessWidget {
  final String adUnitId;

  const Advertisement({super.key, required this.adUnitId});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final width = constraints.maxWidth.truncate();
      return BlocProvider(
        create: (context) => AdvertisementCubit(adUnitId, width),
        child: BlocBuilder<AdvertisementCubit, AdvertisementState>(
          builder: (context, state) {
            return state.bannerAd == null
                ? const SizedBox.shrink()
                : SizedBox(
                    width: constraints.maxWidth,
                    height: state.bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: state.bannerAd!),
                  );
          },
        ),
      );
    });
  }
}
