import '../../domain/entities/ad_data.dart';
import '../../domain/entities/ad_unit_id.dart';

abstract class AdDataSource {
  Future<AdData> loadBannerAd(AdUnitId unitId, int width);
}
