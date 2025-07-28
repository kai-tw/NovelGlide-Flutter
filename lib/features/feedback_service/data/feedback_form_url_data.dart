part of '../feedback_service.dart';

class FeedbackFormUrlData {
  FeedbackFormUrlData._();

  static String getUrlByLocale(Locale locale) {
    final String id = switch (locale) {
      const Locale('en') =>
        '1FAIpQLScMbqxt1GTgz3-VyGpSk8avoPgWxvB9crIFvgdYrGZYbtE2zg',
      const Locale('zh') =>
        '1FAIpQLSdo77Am6qvaoIz9K9FWmySt21p9VnLiikUv0KfxWKV1jf01jQ',
      const Locale.fromSubtags(
            languageCode: 'zh', countryCode: 'CN', scriptCode: 'Hans') =>
        '1FAIpQLSdlDoVsZdyt9GBEivAUxNcv7ohDOKaEv5OornD-DMTxiQWm7g',
      const Locale('ja') =>
        '1FAIpQLSeibENYH3G57PWw28pawmnJF_rMtzrr-3QbQpiuhF6W6HfLnw',
      _ => '',
    };
    return id.isEmpty ? '' : 'https://docs.google.com/forms/d/e/$id/viewform';
  }
}
