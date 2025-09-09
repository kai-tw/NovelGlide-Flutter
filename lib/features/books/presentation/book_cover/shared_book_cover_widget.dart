import 'package:flutter/material.dart';

import '../../domain/entities/book_cover.dart';
import 'book_cover_widget.dart';

class SharedBookCoverWidget extends StatelessWidget {
  const SharedBookCoverWidget({
    super.key,
    required this.coverData,
    this.borderRadius,
  });

  final BookCover coverData;
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
          coverData: coverData,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
