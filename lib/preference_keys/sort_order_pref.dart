class SortOrderPref {
  final String sortOrder;
  final String isAscending;

  factory SortOrderPref(String prefix) =>
      SortOrderPref._internal('$prefix.sortOrder', '$prefix.isAscending');

  SortOrderPref._internal(this.sortOrder, this.isAscending);
}
