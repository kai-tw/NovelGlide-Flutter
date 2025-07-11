part of '../feedback_service.dart';

class FeedbackFormUrlData {
  FeedbackFormUrlData._();

  static final Map<Locale, String> _localeFormIdMap = <Locale, String>{
    const Locale('en'):
        '1FAIpQLScMbqxt1GTgz3-VyGpSk8avoPgWxvB9crIFvgdYrGZYbtE2zg',
    const Locale('zh'):
        '1FAIpQLSdo77Am6qvaoIz9K9FWmySt21p9VnLiikUv0KfxWKV1jf01jQ',
    const Locale.fromSubtags(
            languageCode: 'zh', countryCode: 'CN', scriptCode: 'Hans'):
        '1FAIpQLSdlDoVsZdyt9GBEivAUxNcv7ohDOKaEv5OornD-DMTxiQWm7g',
  };

  static String getUrlByLocale(Locale locale) {
    final String id = _localeFormIdMap[locale] ?? '';
    return 'https://docs.google.com/forms/d/e/$id/viewform';
  }
}
