import 'package:flutter/material.dart';

import '../../../data_model/book_data.dart';
import '../../common_components/common_book_cover_image.dart';

class BookshelfBookWidget extends StatelessWidget {
  final BookData bookData;

  const BookshelfBookWidget({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: AspectRatio(
            aspectRatio: 1 / 1.5,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: CommonBookCoverImage(bookData: bookData),
            ),
          ),
        ),
        Text(
          bookData.name,
          maxLines: 3,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
