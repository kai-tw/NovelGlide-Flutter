import 'package:flutter/material.dart';

import '../../shared/book_process.dart';

class TOCSliverBookName extends StatelessWidget {
  const TOCSliverBookName(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(36.0, 0, 24.0, 24.0),
        child: Text(
          bookObject.name,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
