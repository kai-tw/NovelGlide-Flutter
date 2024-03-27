import 'package:flutter/material.dart';

class BookshelfBookCoverDefault extends StatelessWidget {
  const BookshelfBookCoverDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/book_cover_light.jpg', fit: BoxFit.cover);
  }
}