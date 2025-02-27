enum SortOrderCode {
  name,
  modifiedDate,
  savedTime;

  static SortOrderCode? fromString(String? value) {
    Iterable<SortOrderCode> r =
        SortOrderCode.values.where((element) => element.toString() == value);
    return r.length == 1 ? r.first : null;
  }
}
