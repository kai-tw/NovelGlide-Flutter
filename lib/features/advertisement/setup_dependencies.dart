import '../../main.dart';
import 'data/data_sources/ad_data_source.dart';
import 'data/data_sources/impl/admob_data_source.dart';
import 'data/repositories/ad_repository_impl.dart';
import 'domain/repositories/ad_repository.dart';
import 'domain/use_cases/ad_check_enabled_use_case.dart';
import 'domain/use_cases/ad_load_banner_ad_use_case.dart';
import 'presentation/cubit/advertisement_cubit.dart';

void setupAdDependencies() {
  // Register data source
  sl.registerLazySingleton<AdDataSource>(() => AdMobDataSource());

  // Register repositories
  sl.registerLazySingleton<AdRepository>(() => AdRepositoryImpl(
        sl<AdDataSource>(),
      ));

  // Register use cases
  sl.registerFactory<AdLoadBannerAdUseCase>(() => AdLoadBannerAdUseCase(
        sl<AdRepository>(),
      ));
  sl.registerFactory<AdCheckEnabledUseCase>(() => AdCheckEnabledUseCase(
        sl<AdRepository>(),
      ));

  // Register cubits
  sl.registerFactory<AdvertisementCubit>(() => AdvertisementCubit(
        sl<AdLoadBannerAdUseCase>(),
        sl<AdCheckEnabledUseCase>(),
      ));
}
