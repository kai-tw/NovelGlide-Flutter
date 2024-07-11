import 'package:flutter/material.dart';

import '../../data/book_data.dart';

class BookshelfBookTitle extends StatelessWidget {
  const BookshelfBookTitle(this.bookObject, {super.key});

  final BookData bookObject;

  @override
  Widget build(BuildContext context) {
    return Text(
      bookObject.name,
      maxLines: 3,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}