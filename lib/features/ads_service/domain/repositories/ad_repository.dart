import '../entities/ad_data.dart';
import '../entities/ad_unit_id.dart';

abstract class AdRepository {
  bool get enabled;

  Future<AdData> loadBannerAd(AdUnitId unitId, int width);
}
