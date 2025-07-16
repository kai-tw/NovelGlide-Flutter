part of 'preference_keys.dart';

class SharedListPrefs {
  factory SharedListPrefs(String prefix) {
    return SharedListPrefs._internal(
      sortOrder: '$prefix.sortOrder',
      isAscending: '$prefix.isAscending',
      listView: '$prefix.listView',
    );
  }

  SharedListPrefs._internal({
    required this.sortOrder,
    required this.isAscending,
    required this.listView,
  });

  final String sortOrder;
  final String isAscending;
  final String listView;
}
