import 'package:flutter_test/flutter_test.dart';
import 'package:novel_glide/features/locale/domain/entities/app_locale.dart';

void main() {
  group('AppLocale', () {
    test('props are correct for languageCode only', () {
      const AppLocale appLocale = AppLocale('en');
      expect(appLocale.props, <String?>['en', null, null]);
    });
    test('props are correct for languageCode and scriptCode', () {
      const AppLocale appLocale = AppLocale('zh', 'Hans');
      expect(appLocale.props, <String?>['zh', 'Hans', null]);
    });
    test('props are correct for languageCode, scriptCode, and countryCode', () {
      const AppLocale appLocale = AppLocale('zh', 'Hans', 'CN');
      expect(appLocale.props, <String>['zh', 'Hans', 'CN']);
    });
    test('toString combines parts correctly', () {
      const AppLocale appLocale1 = AppLocale('en');
      expect(appLocale1.toString(), 'en');
      const AppLocale appLocale2 = AppLocale('zh', 'Hans');
      expect(appLocale2.toString(), 'zh_Hans');
      const AppLocale appLocale3 = AppLocale('zh', 'Hans', 'CN');
      expect(appLocale3.toString(), 'zh_Hans_CN');
    });
    group('fromString', () {
      test('parses languageCode only correctly', () {
        final AppLocale appLocale = AppLocale.fromString('en');
        expect(appLocale.languageCode, 'en');
        expect(appLocale.scriptCode, null);
        expect(appLocale.countryCode, null);
      });
      test('parses languageCode and scriptCode correctly', () {
        final AppLocale appLocale = AppLocale.fromString('zh_Hans');
        expect(appLocale.languageCode, 'zh');
        expect(appLocale.scriptCode, 'Hans');
        expect(appLocale.countryCode, null);
      });
      test('parses languageCode, scriptCode, and countryCode correctly', () {
        final AppLocale appLocale = AppLocale.fromString('zh_Hans_CN');
        expect(appLocale.languageCode, 'zh');
        expect(appLocale.scriptCode, 'Hans');
        expect(appLocale.countryCode, 'CN');
      });
    });
  });
}
