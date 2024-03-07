import 'package:flutter/material.dart';

import '../../shared/book_object.dart';

class BookshelfBookTitle extends StatelessWidget {
  const BookshelfBookTitle(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return Text(
      bookObject.name,
      maxLines: 3,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}