int parseInt(dynamic value, {int? radix, int defaultValue = 0}) {
  if (value is int) {
    return value;
  } else if (value is String) {
    return int.tryParse(value, radix: radix) ?? defaultValue;
  } else if (value is double) {
    return value.toInt();
  }
  return defaultValue;
}
