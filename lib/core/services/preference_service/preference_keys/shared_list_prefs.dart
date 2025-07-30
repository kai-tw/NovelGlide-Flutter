part of '../preference_service.dart';

class SharedListPrefs {
  factory SharedListPrefs(String prefix) {
    return SharedListPrefs._internal(
      sortOrder: '$prefix.sortOrder',
      isAscending: '$prefix.isAscending',
      listType: '$prefix.listType',
    );
  }

  SharedListPrefs._internal({
    required this.sortOrder,
    required this.isAscending,
    required this.listType,
  });

  final String sortOrder;
  final String isAscending;
  final String listType;
}
