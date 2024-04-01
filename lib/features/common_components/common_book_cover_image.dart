import 'dart:io';

import 'package:flutter/material.dart';

class CommonBookCoverImage extends StatelessWidget {
  final String? path;

  const CommonBookCoverImage({super.key, this.path});

  @override
  Widget build(BuildContext context) {
    if (path != null) {
      final File file = File(path!);

      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        );
      }
    }

    final Brightness brightness = MediaQuery.of(context).platformBrightness;

    return Image.asset(
      'assets/images/book_cover_${brightness == Brightness.dark ? 'dark' : 'light'}.jpg',
      fit: BoxFit.cover,
      gaplessPlayback: true,
    );
  }
}
