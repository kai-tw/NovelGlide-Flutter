part of 'preference_keys.dart';

class SortOrderPref {
  factory SortOrderPref(String prefix) =>
      SortOrderPref._internal('$prefix.sortOrder', '$prefix.isAscending');

  SortOrderPref._internal(this.sortOrder, this.isAscending);

  final String sortOrder;
  final String isAscending;
}
