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

      return Image.memory(
        bitmap.buildHeaded(),
        fit: BoxFit.cover,
        gaplessPlayback: true,
        semanticLabel: AppLocalizations.of(context)!.accessibilityBookCover,
      );
    }
  }
}
