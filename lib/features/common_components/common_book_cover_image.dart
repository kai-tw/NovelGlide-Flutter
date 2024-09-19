import 'dart:math';
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
    final double widthRatio = constraints.maxWidth / image.width;
    final double heightRatio = constraints.maxHeight / image.height;

    final double maxRatio = max(widthRatio, heightRatio);

    final int displayWidth = (image.width * maxRatio).truncate();
    final int displayHeight = (image.height * maxRatio).truncate();

    return Bitmap.fromHeadless(image.width, image.height, image.getBytes())
        .apply(BitmapResize.to(width: displayWidth, height: displayHeight))
        .buildHeaded();
  }
}
