import 'package:flutter/material.dart';

class LibraryWidget extends StatelessWidget {
  const LibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Hero(
        tag: 'MainPage2AddBookPage',
        child: Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(width: double.infinity, height: double.infinity)));
  }
}
