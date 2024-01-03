import 'package:flutter/material.dart';

class MainPageLibraryItem extends StatelessWidget {
  const MainPageLibraryItem(this.bookName, {super.key});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(width: 0.2, color: Theme.of(context).colorScheme.outline))),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 16.0), child: Text(bookName)));
  }
}
