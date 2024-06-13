import 'dart:math';

class RandomUtility {
  static String getRandomString(int length) {
    const String alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(length, (_) => alphabet.codeUnitAt(Random().nextInt(alphabet.length))));
  }
}