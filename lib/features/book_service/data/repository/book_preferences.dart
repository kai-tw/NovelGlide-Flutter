part of '../../book_service.dart';

class BookPreference {
  BookPreference();

  final String _sortOrderKey = PreferenceKeys.bookshelf.sortOrder;
  final String _isAscendingKey = PreferenceKeys.bookshelf.isAscending;

  SharedPreferences? _prefs;
  late SortOrderCode _sortOrder;
  late bool _isAscending;

  SortOrderCode get sortOrder => _sortOrder;

  set sortOrder(SortOrderCode value) => _prefs?.setInt(_sortOrderKey, value.index);

  bool get isAscending => _isAscending;

  set isAscending(bool value) => _prefs?.setBool(_isAscendingKey, value);

  Future<void> load() async {
    _prefs ??= await SharedPreferences.getInstance();

    int sortOrder;
    try {
      sortOrder = _prefs?.getInt(_sortOrderKey) ?? SortOrderCode.name.index;
    } catch (_) {
      sortOrder = SortOrderCode.name.index;
    }

    _sortOrder = SortOrderCode.values[sortOrder];
    _isAscending = _prefs?.getBool(_isAscendingKey) ?? true;
  }

  Future<void> reset() async {
    _prefs ??= await SharedPreferences.getInstance();
    _prefs?.remove(_sortOrderKey);
    _prefs?.remove(_isAscendingKey);
  }
}
