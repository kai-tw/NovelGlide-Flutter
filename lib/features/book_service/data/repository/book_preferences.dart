part of '../../book_service.dart';

class BookPreference {
  BookPreference();

  /// ==== Preference keys ====
  final String _sortOrderKey = PreferenceKeys.bookshelf.sortOrder;
  final String _isAscendingKey = PreferenceKeys.bookshelf.isAscending;
  final String _listViewKey = PreferenceKeys.bookshelf.listView;

  /// ==== Preference values ====
  SharedPreferences? _prefs;
  late SortOrderCode _sortOrder;
  late bool _isAscending;
  late SharedListType _listType;

  /// ==== Sort Order ====

  /// Sort order getter
  SortOrderCode get sortOrder => _sortOrder;

  /// Sort order setter
  set sortOrder(SortOrderCode value) {
    _sortOrder = value;
    _prefs?.setInt(_sortOrderKey, value.index);
  }

  /// ==== Ascending ====

  /// Is ascending getter
  bool get isAscending => _isAscending;

  /// Is ascending setter
  set isAscending(bool value) {
    _isAscending = value;
    _prefs?.setBool(_isAscendingKey, value);
  }

  /// ==== List View ====

  /// ListView Type getter
  SharedListType get listType => _listType;

  /// ListView Type setter
  set listType(SharedListType value) {
    _listType = value;
    _prefs?.setInt(_listViewKey, value.index);
  }

  /// ==== Operations ====

  /// Lazy load preferences.
  Future<void> load() async {
    _prefs ??= await SharedPreferences.getInstance();

    int sortOrder;
    try {
      sortOrder = _prefs?.getInt(_sortOrderKey) ?? SortOrderCode.name.index;
    } catch (_) {
      sortOrder = SortOrderCode.name.index;
    }

    int listViewType;
    try {
      listViewType = _prefs?.getInt(_listViewKey) ?? SharedListType.grid.index;
    } catch (_) {
      listViewType = SharedListType.grid.index;
    }

    _sortOrder = SortOrderCode.values[sortOrder];
    _isAscending = _prefs?.getBool(_isAscendingKey) ?? true;
    _listType = SharedListType.values[listViewType];
  }

  /// Reset preferences.
  Future<void> reset() async {
    _prefs ??= await SharedPreferences.getInstance();
    _prefs?.remove(_sortOrderKey);
    _prefs?.remove(_isAscendingKey);
    _prefs?.remove(_listViewKey);
  }
}
