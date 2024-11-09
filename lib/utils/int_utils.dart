class IntUtils {
  IntUtils._();

  static int parse(String? value, {int? radix}) {
    return int.tryParse(value ?? '0', radix: radix) ?? 0;
  }
}
