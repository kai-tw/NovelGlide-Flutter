class IntUtils {
  IntUtils._();

  static int parse(dynamic value, {int? radix}) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value, radix: radix) ?? 0;
    } else if (value is double) {
      return value.toInt();
    }
    return 0;
  }
}
