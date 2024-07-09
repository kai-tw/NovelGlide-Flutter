import '../data/book_data.dart';

class GuideProcessor {
  /// Create the guide
  static Future<void> create() async {
    final BookData bookData = BookData.fromName('The Guide');

    if (bookData.isExist()) {
      bookData.delete();
    }

    bookData.create();
  }
}