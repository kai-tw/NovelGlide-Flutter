import 'dart:math';

extension RandomExtension on Random {
  // Generates a random string of the specified length
  String nextString(int length) {
    const String alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(
      Iterable<int>.generate(
        length,
        (_) => alphabet.codeUnitAt(nextInt(alphabet.length)),
      ),
    );
  }
}
