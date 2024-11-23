class DoubleUtils {
  DoubleUtils._();

  static double parse(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0;
    } else if (value is int) {
      return value.toDouble();
    }
    return 0;
  }
}
