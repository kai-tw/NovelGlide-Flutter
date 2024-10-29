import 'package:flutter/material.dart';

class Advertisement extends StatelessWidget {
  final String adUnitId;

  const Advertisement({super.key, required this.adUnitId});

  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(
    //     builder: (BuildContext context, BoxConstraints constraints) {
    //   final width = constraints.maxWidth.truncate();
    //   return BlocProvider(
    //     create: (context) => AdvertisementCubit(adUnitId, width),
    //     child: BlocBuilder<AdvertisementCubit, AdvertisementState>(
    //       builder: (context, state) {
    //         return state.bannerAd == null
    //             ? const SizedBox.shrink()
    //             : SizedBox(
    //                 width: constraints.maxWidth,
    //                 height: state.bannerAd!.size.height.toDouble(),
    //                 child: AdWidget(ad: state.bannerAd!),
    //               );
    //       },
    //     ),
    //   );
    // });
    return const SizedBox.shrink();
  }
}
