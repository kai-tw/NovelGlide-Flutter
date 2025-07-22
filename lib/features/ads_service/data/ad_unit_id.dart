part of '../ad_service.dart';

enum AdUnitId {
  homepage(
    android: 'ca-app-pub-1579558558142906/6034508731',
    ios: 'ca-app-pub-1579558558142906/3980025184',
  ),
  tableOfContents(
    android: 'ca-app-pub-1579558558142906/1014366989',
    ios: '',
  ),
  reader(
    android: 'ca-app-pub-1579558558142906/5399183177',
    ios: '',
  );

  const AdUnitId({
    required this.android,
    required this.ios,
  });

  final String android;
  final String ios;

  String get id => Platform.isAndroid ? android : ios;
}
