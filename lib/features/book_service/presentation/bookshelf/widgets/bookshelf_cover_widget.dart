part of '../../../book_service.dart';

class BookshelfCoverWidget extends StatelessWidget {
  const BookshelfCoverWidget({
    super.key,
    required this.bookData,
    this.borderRadius,
  });

  final BookData bookData;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.5,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: borderRadius,
        ),
        clipBehavior: Clip.hardEdge,
        child: BookCoverImage(
          bookData: bookData,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
