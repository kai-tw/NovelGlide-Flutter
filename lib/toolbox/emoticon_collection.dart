import 'dart:math';

class EmoticonCollection {
  static const List<String> shock = ['Σ(｀L_｀ )', '(ﾟ々｡)', 'Σ(;ﾟдﾟ)'];

  // Return a random emoticon in shock collection.
  static String getRandomShock() {
    final Random random = Random();
    final randNum = random.nextInt(shock.length);
    return shock[randNum];
  }

  EmoticonCollection._();
}
