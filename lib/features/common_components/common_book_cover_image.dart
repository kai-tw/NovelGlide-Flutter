import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonBookCoverImage extends StatelessWidget {
  final Uint8List? bytes;

  const CommonBookCoverImage({super.key, this.bytes});

  @override
  Widget build(BuildContext context) {
    if (bytes == null) {
      final Brightness brightness = Theme.of(context).brightness;

      return Image.asset(
        'assets/images/book_cover_${brightness == Brightness.dark ? 'dark' : 'light'}.jpg',
        fit: BoxFit.cover,
        gaplessPlayback: true,
        semanticLabel: AppLocalizations.of(context)!.accessibilityBookCover,
      );
    } else {
      return Image.memory(
        bytes!,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        semanticLabel: AppLocalizations.of(context)!.accessibilityBookCover,
      );
    }
  }
}
