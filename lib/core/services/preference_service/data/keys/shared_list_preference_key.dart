part of '../../preference_service.dart';

class SharedListPreferenceKey {
  factory SharedListPreferenceKey(String prefix) {
    return SharedListPreferenceKey._(
      sortOrder: '$prefix.sortOrder',
      isAscending: '$prefix.isAscending',
      listType: '$prefix.listType',
    );
  }

  SharedListPreferenceKey._({
    required this.sortOrder,
    required this.isAscending,
    required this.listType,
  });

  final String sortOrder;
  final String isAscending;
  final String listType;
}
