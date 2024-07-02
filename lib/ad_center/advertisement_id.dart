import 'dart:io';

class AdvertisementId {
  static String get adaptiveBanner {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1579558558142906/6034508731';
    // } else if (Platform.isIOS) {
    //   return '';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}