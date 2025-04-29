import 'dart:io';

enum AdvertisementType {
  bookshelf(
    android: 'ca-app-pub-1579558558142906/6034508731',
    ios: 'ca-app-pub-1579558558142906/3980025184',
  );

  const AdvertisementType({required this.android, required this.ios});

  final String android;
  final String ios;

  String get id => Platform.isAndroid ? android : ios;
}
