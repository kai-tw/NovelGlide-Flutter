import 'dart:math';

import 'package:flutter/material.dart';

class RandomShockEmoticonText extends StatelessWidget {
  const RandomShockEmoticonText({
    super.key,
    this.style,
  });

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      getRandomShock(),
      style: style,
    );
  }

  /// Returns a random emoticon from the shock collection.
  static String getRandomShock() {
    final List<String> shock = <String>[
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
    final Random random = Random();
    final int randomIndex = random.nextInt(shock.length);
    return shock[randomIndex];
  }
}
