import 'dart:math';

/// A utility class for managing collections of emoticons.
class EmoticonCollection {
  /// A collection of emoticons representing shock.
  static const List<String> shock = [
    'Σ(｀L_｀ )',
    '(ﾟ々｡)',
    'Σ(;ﾟдﾟ)',
    'Σ(￣□￣)',
    '(⊙_☉)',
    '（°o°）',
    'Σ(ﾟДﾟ)',
    '（⊙＿⊙）',
    '（°□°）',
    '（⊙_⊙）',
    '（°◇°）',
    '（°ロ°）'
  ];

  /// Returns a random emoticon from the shock collection.
  static String getRandomShock() {
    final random = Random();
    final randomIndex = random.nextInt(shock.length);
    return shock[randomIndex];
  }

  // Private constructor to prevent instantiation.
  EmoticonCollection._();
}
