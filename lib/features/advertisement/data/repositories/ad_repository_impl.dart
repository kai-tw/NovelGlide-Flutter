import 'package:flutter/foundation.dart';

import '../../domain/entities/ad_data.dart';
import '../../domain/entities/ad_unit_id.dart';
import '../../domain/repositories/ad_repository.dart';
import '../data_sources/ad_data_source.dart';

class AdRepositoryImpl implements AdRepository {
  AdRepositoryImpl(this._adMobDataSource);

  final AdDataSource _adMobDataSource;

  @override
  bool get enabled => kReleaseMode;

  @override
  Future<AdData> loadBannerAd(AdUnitId unitId, int width) async {
    return _adMobDataSource.loadBannerAd(unitId, width);
  }
}
