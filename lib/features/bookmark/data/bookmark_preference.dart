part of '../bookmark_service.dart';

class BookmarkPreference extends SharedListPreference {
  BookmarkPreference();

  /// ==== Preference keys ====
  @override
  final String sortOrderKey = PreferenceKeys.bookmark.sortOrder;
  @override
  final String isAscendingKey = PreferenceKeys.bookmark.isAscending;
  @override
  final String listTypeKey = PreferenceKeys.bookmark.listType;
}
