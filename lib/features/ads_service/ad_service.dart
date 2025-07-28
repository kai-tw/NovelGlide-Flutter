import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'data/ad_unit_id.dart';
part 'presentation/advertisement.dart';
part 'presentation/cubit/advertisement_cubit.dart';
part 'presentation/cubit/advertisement_state.dart';

class AdService {
  AdService._();

  static bool get isAllowed => false;

  static bool _isInit = false;

  static Future<void> ensuredInitialized() async {
    if (isAllowed && !_isInit) {
      await MobileAds.instance.initialize();
      _isInit = true;
    }
  }
}
