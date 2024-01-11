import 'package:flutter/material.dart';

class BookChapterList extends StatelessWidget {
  const BookChapterList({super.key, required this.bookName});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(bookName),
      ),
    );
  }
}
