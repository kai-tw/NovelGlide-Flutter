import 'package:flutter/material.dart';

import '../../../domain/entities/book.dart';
import '../../../domain/entities/book_cover.dart';
import '../../book_cover/book_cover_widget.dart';

class TocCoverBanner extends StatelessWidget {
  const TocCoverBanner({
    super.key,
    required this.bookData,
    required this.coverData,
  });

  final Book bookData;
  final BookCover coverData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      ),
      clipBehavior: Clip.hardEdge,
      child: BookCoverWidget(
        coverData: coverData,
        fit: BoxFit.contain,
      ),
    );
  }
}
