import 'package:flutter/material.dart';

import '../../data/book_data.dart';
import 'bookshelf_book_cover.dart';
import 'bookshelf_book_title.dart';

class BookshelfBookWidget extends StatelessWidget {
  final BookData bookObject;

  const BookshelfBookWidget({super.key, required this.bookObject});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: BookshelfBookCover(bookObject),
        ),
        BookshelfBookTitle(bookObject),
      ],
    );
  }
}