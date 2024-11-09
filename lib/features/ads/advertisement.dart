import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';

part 'advertisement_id.dart';
part 'bloc/advertisement_bloc.dart';

class Advertisement extends StatelessWidget {
  final String adUnitId;

  const Advertisement({super.key, required this.adUnitId});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
    // return LayoutBuilder(
    //     builder: (BuildContext context, BoxConstraints constraints) {
    //   final width = constraints.maxWidth.truncate();
    //   return BlocProvider(
    //     create: (context) => _AdCubit(adUnitId, width),
    //     child: BlocBuilder<_AdCubit, _State>(
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
  }
}
