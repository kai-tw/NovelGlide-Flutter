part of '../../book_service.dart';

class BookPreference extends SharedListPreference {
  BookPreference();

  /// ==== Preference keys ====
  @override
  final String sortOrderKey = PreferenceKeys.bookshelf.sortOrder;
  @override
  final String isAscendingKey = PreferenceKeys.bookshelf.isAscending;
  @override
  final String listTypeKey = PreferenceKeys.bookshelf.listType;
}
