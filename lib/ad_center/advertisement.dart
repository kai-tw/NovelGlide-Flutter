import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'bloc/advertisement_bloc.dart';

class Advertisement extends StatelessWidget {
  final String adUnitId;

  const Advertisement({super.key, required this.adUnitId});

  @override
  Widget build(BuildContext context) {
    final int width = MediaQuery.of(context).size.width.truncate();
    return BlocProvider(
      create: (context) => AdvertisementCubit(adUnitId: adUnitId),
      // create: (context) => AdvertisementCubit(adUnitId: adUnitId)..init(width),
      child: BlocBuilder<AdvertisementCubit, AdvertisementState>(
        builder: (context, state) {
          return state.bannerAd == null ? const SizedBox() : SizedBox(
            // width: state.bannerAd!.size.width.toDouble(),
            width: MediaQuery.of(context).size.width,
            height: state.bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: state.bannerAd!),
          );
        },
      ),
    );
  }
}