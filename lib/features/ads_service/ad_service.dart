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

  static bool get isAllowed => Platform.isAndroid;

  static bool _isInit = false;

  static void ensuredInitialized() {
    if (isAllowed && !_isInit) {
      MobileAds.instance.initialize();
      _isInit = true;
    }
  }
}
