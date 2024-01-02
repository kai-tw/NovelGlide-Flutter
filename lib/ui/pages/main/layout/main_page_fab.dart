import 'package:flutter/material.dart';
import 'package:novelglide/ui/pages/add_book/layout/add_book_page_scaffold.dart';

class MainPageFab extends StatelessWidget {
  const MainPageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddBookPage()));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary));
  }
}