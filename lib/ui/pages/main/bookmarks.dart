import 'package:flutter/material.dart';

class BookmarkWidget extends StatelessWidget {
  const BookmarkWidget({super.key});
  final String title = "Bookmarks";

  @override
  Widget build(BuildContext context) {
    return const Card(
        shadowColor: Colors.transparent,
        child: Center(
            child: Text("Bookmark")
        )
    );
  }
}