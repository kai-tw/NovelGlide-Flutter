import 'package:flutter/material.dart';

import '../../../data/book_data.dart';
import '../../common_components/common_book_cover_image.dart';

class TocCoverBanner extends StatelessWidget {
  final BookData bookData;
  final double? aspectRatio;

  const TocCoverBanner({super.key, this.aspectRatio, required this.bookData});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          ),
          clipBehavior: Clip.hardEdge,
          child: CommonBookCoverImage(bookData: bookData),
        );
      },
    );
  }
}