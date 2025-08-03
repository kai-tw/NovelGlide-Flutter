import '../entities/locale_settings.dart';

abstract class LocaleRepository {
  Future<LocaleSettings> getLocaleSettings();
  Future<void> saveLocaleSettings(LocaleSettings settings);
}
