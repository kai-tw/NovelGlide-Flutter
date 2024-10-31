part of 'advertisement.dart';

class AdvertisementId {
  static String get adaptiveBanner {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1579558558142906/6034508731';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1579558558142906/3980025184';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
