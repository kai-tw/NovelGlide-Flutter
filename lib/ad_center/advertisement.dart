import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'bloc/advertisement_bloc.dart';

class Advertisement extends StatelessWidget {
  final String adUnitId;

  const Advertisement({super.key, required this.adUnitId});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return BlocProvider(
          create: (context) => AdvertisementCubit(adUnitId: adUnitId)..init(constraints.maxWidth.truncate()),
          child: BlocBuilder<AdvertisementCubit, AdvertisementState>(
            builder: (context, state) {
              return state.bannerAd == null ? const SizedBox() : SizedBox(
                width: constraints.maxWidth,
                height: state.bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: state.bannerAd!),
              );
            },
          ),
        );
      }
    );
  }
}