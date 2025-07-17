part of '../shared_list.dart';

abstract class SharedListPreference {
  SharedListPreference();

  /// ==== Preference keys ====
  abstract final String sortOrderKey;
  abstract final String isAscendingKey;
  abstract final String listTypeKey;

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
    _prefs?.setInt(sortOrderKey, value.index);
  }

  /// ==== Ascending ====

  /// Is ascending getter
  bool get isAscending => _isAscending;

  /// Is ascending setter
  set isAscending(bool value) {
    _isAscending = value;
    _prefs?.setBool(isAscendingKey, value);
  }

  /// ==== List View ====

  /// ListView Type getter
  SharedListType get listType => _listType;

  /// ListView Type setter
  set listType(SharedListType value) {
    _listType = value;
    _prefs?.setInt(listTypeKey, value.index);
  }

  /// ==== Operations ====

  /// Lazy load preferences.
  Future<void> load() async {
    _prefs ??= await SharedPreferences.getInstance();

    _sortOrder = SortOrderCode.values[PreferenceEnumUtils.getEnumIndex(
      _prefs,
      sortOrderKey,
      defaultValue: SortOrderCode.name.index,
    )];

    _isAscending = _prefs?.getBool(isAscendingKey) ?? true;

    _listType = SharedListType.values[PreferenceEnumUtils.getEnumIndex(
      _prefs,
      listTypeKey,
      defaultValue: SharedListType.grid.index,
    )];
  }

  /// Reset preferences.
  Future<void> reset() async {
    _prefs ??= await SharedPreferences.getInstance();
    _prefs?.remove(sortOrderKey);
    _prefs?.remove(isAscendingKey);
    _prefs?.remove(listTypeKey);
  }
}
