import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image/image.dart' as img;

import '../../data/book_data.dart';

class CommonBookCoverImage extends StatelessWidget {
  final BookData bookData;

  const CommonBookCoverImage({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    img.Image? image = bookData.coverImage;
    if (image == null) {
      final Brightness brightness = Theme.of(context).brightness;

      return Image.asset(
        'assets/images/book_cover_${brightness == Brightness.dark ? 'dark' : 'light'}.jpg',
        fit: BoxFit.cover,
        gaplessPlayback: true,
        semanticLabel: AppLocalizations.of(context)!.accessibilityBookCover,
      );
    } else {
      final Bitmap bitmap = Bitmap.fromHeadless(image.width, image.height, image.getBytes());

      return LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder(
            future: _bitmapOptimize(image, constraints),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  semanticLabel: AppLocalizations.of(context)!.accessibilityBookCover,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        },
      );
    }
  }

  Future<Uint8List?> _bitmapOptimize(img.Image image, BoxConstraints constraints) async {
    return Bitmap.fromHeadless(image.width, image.height, image.getBytes())
        .apply(BitmapResize.to(width: constraints.maxWidth.truncate(), height: constraints.maxHeight.truncate()))
        .buildHeaded();
  }
}
