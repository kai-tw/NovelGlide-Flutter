import 'package:bitmap/bitmap.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/cache_memory_image_provider.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../domain/entities/book_cover.dart';

class BookCoverWidget extends StatelessWidget {
  const BookCoverWidget({
    super.key,
    required this.coverData,
    required this.fit,
  });

  final BookCover coverData;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    // Bytes are not null
    if (coverData.bytes != null && coverData.hasSize) {
      // Use bitmap to display the cover
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Image(
            image: CacheMemoryImageProvider(
              coverData.identifier,
              Bitmap.fromHeadless(
                coverData.width!.truncate(),
                coverData.height!.truncate(),
                coverData.bytes!,
              ).buildHeaded(),
            ),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            fit: fit,
            semanticLabel: appLocalizations.generalBookCover,
          );
        },
      );
    }

    // Url are not empty
    if (coverData.url != null) {
      // Load the network image
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Image.network(
            coverData.url!.toString(),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            fit: fit,
            semanticLabel: appLocalizations.generalBookCover,
          );
        },
      );
    }

    // There is not an image. Use the image in the asset.
    final Brightness brightness = Theme.of(context).brightness;

    return Image.asset(
      'assets/images/book_cover_${brightness == Brightness.dark ? 'dark' : 'light'}.jpg',
      fit: BoxFit.cover,
      gaplessPlayback: true,
      semanticLabel: appLocalizations.generalBookCover,
    );
  }
}
