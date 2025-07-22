part of '../../book_service.dart';

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
        semanticLabel: appLocalizations.generalBookCover,
      );
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Image(
            image: CacheMemoryImageProvider(
              bookData.relativeFilePath,
              Bitmap.fromHeadless(image.width, image.height, image.getBytes())
                  .buildHeaded(),
            ),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            fit: fit,
            semanticLabel: appLocalizations.generalBookCover,
          );
        },
      );
    }
  }
}
