import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../main.dart';
import '../domain/entities/ad_unit_id.dart';
import 'cubit/advertisement_cubit.dart';
import 'cubit/advertisement_state.dart';

class Advertisement extends StatelessWidget {
  const Advertisement({
    super.key,
    required this.unitId,
    this.height,
  });

  final AdUnitId unitId;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return BlocProvider<AdvertisementCubit>(
          create: (_) => sl<AdvertisementCubit>()
            ..loadAd(
              unitId,
              constraints.maxWidth.toInt(),
            ),
          child: BlocBuilder<AdvertisementCubit, AdvertisementState>(
            builder: (BuildContext context, AdvertisementState state) {
              if (state.isEnabled) {
                if (state.adMobBannerAd == null) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    width: constraints.maxWidth,
                    height: height,
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    width: constraints.maxWidth,
                    height: state.adMobBannerAd!.size.height.toDouble(),
                    child: Center(
                      child: AdWidget(ad: state.adMobBannerAd!),
                    ),
                  );
                }
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }
}
