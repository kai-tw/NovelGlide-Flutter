import 'dart:math';

/// A utility class for managing collections of emoticons.
class EmoticonCollection {
  // Private constructor to prevent instantiation.
  EmoticonCollection._();

  /// A collection of emoticons representing shock.
  static const List<String> shock = <String>[
    'Σ(｀L_｀ )',
    '(ﾟ々｡)',
    'Σ(;ﾟдﾟ)',
    'Σ(￣ロ￣)',
    '(⊙_☉)',
    '（°o°）',
    'Σ(ﾟДﾟ)',
    '（⊙＿⊙）',
    '（⊙_⊙）',
    '（°◇°）',
    '（°ロ°）'
  ];

  /// Returns a random emoticon from the shock collection.
  static String getRandomShock() {
    final Random random = Random();
    final int randomIndex = random.nextInt(shock.length);
    return shock[randomIndex];
  }
}
