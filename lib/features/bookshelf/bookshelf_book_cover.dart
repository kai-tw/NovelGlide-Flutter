import 'package:flutter/material.dart';

import '../../shared/book_object.dart';
import '../common_components/common_book_cover_image.dart';

class BookshelfBookCover extends StatelessWidget {
  const BookshelfBookCover(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.5,
      child: Hero(
        tag: bookObject.name,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(16.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: CommonBookCoverImage(path: bookObject.getCoverPath()),
        ),
      ),
    );
  }

}