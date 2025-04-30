import 'dart:math';
import 'dart:typed_data';

import 'package:bitmap/bitmap.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import '../../../../generated/i18n/app_localizations.dart';
import '../../data/model/book_data.dart';

class BookCoverImage extends StatelessWidget {
  const BookCoverImage({
    super.key,
    required this.bookData,
    required this.fit,
  });

  final BookData bookData;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final img.Image? image = bookData.coverImage;
    if (image == null) {
      final Brightness brightness = Theme.of(context).brightness;

      return Image.asset(
        'assets/images/book_cover_${brightness == Brightness.dark ? 'dark' : 'light'}.jpg',
        fit: BoxFit.cover,
        gaplessPlayback: true,
        semanticLabel: appLocalizations.accessibilityBookCover,
      );
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Widget child = Image.memory(
            _bitmapOptimize(image, constraints),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            fit: fit,
            gaplessPlayback: true,
            semanticLabel: appLocalizations.accessibilityBookCover,
          );

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: child,
          );
        },
      );
    }
  }

  Uint8List _bitmapOptimize(img.Image image, BoxConstraints constraints) {
    const int ratio = 4;
    final double widthRatio = constraints.maxWidth / image.width * ratio;
    final double heightRatio = constraints.maxHeight / image.height * ratio;

    final double maxRatio = max(widthRatio, heightRatio);

    final int displayWidth = (image.width * maxRatio).truncate();
    final int displayHeight = (image.height * maxRatio).truncate();

    return Bitmap.fromHeadless(image.width, image.height, image.getBytes())
        .apply(BitmapResize.to(width: displayWidth, height: displayHeight))
        .buildHeaded();
  }
}
