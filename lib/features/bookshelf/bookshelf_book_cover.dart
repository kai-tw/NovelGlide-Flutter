import 'package:flutter/material.dart';

import '../../shared/book_object.dart';

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
          child: bookObject.getCover(),
        ),
      ),
    );
  }

}