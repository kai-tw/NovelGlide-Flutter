import 'dart:math';
import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import '../../data_model/book_data.dart';
import '../../generated/i18n/app_localizations.dart';

class CommonBookCoverImage extends StatelessWidget {
  const CommonBookCoverImage({super.key, required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final img.Image? image = bookData.coverImage;
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
        builder: (BuildContext context, BoxConstraints constraints) {
          return FutureBuilder<Uint8List?>(
            future: _bitmapOptimize(image, constraints),
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (snapshot.hasData) {
                return Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  semanticLabel:
                      AppLocalizations.of(context)!.accessibilityBookCover,
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

  Future<Uint8List?> _bitmapOptimize(
    img.Image image,
    BoxConstraints constraints,
  ) async {
    const int ratio = 4;
    final double widthRatio = constraints.maxWidth / image.width;
    final double heightRatio = constraints.maxHeight / image.height;

    final double maxRatio = max(widthRatio, heightRatio);

    final int displayWidth = (image.width * maxRatio * ratio).truncate();
    final int displayHeight = (image.height * maxRatio * ratio).truncate();

    return Bitmap.fromHeadless(image.width, image.height, image.getBytes())
        .apply(BitmapResize.to(width: displayWidth, height: displayHeight))
        .buildHeaded();
  }
}
