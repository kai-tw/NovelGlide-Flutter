import 'package:flutter/material.dart';

import '../../../domain/entities/book.dart';
import '../../shared/book_cover_image.dart';

class BookshelfCoverWidget extends StatelessWidget {
  const BookshelfCoverWidget({
    super.key,
    required this.bookData,
    this.borderRadius,
  });

  final Book bookData;
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
          coverData: bookData.cover,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
