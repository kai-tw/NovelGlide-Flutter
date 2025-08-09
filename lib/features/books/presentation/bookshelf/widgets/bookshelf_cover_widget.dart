import 'package:flutter/material.dart';

import '../../../domain/entities/book.dart';
import '../../book_cover/book_cover_widget.dart';

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
        child: BookCoverWidget(
          identifier: bookData.coverIdentifier,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
