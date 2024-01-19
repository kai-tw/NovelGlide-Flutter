import 'package:flutter/material.dart';

import '../../shared/book_process.dart';
import '../edit_book/scaffold.dart';

class TOCSliverAppBar extends StatelessWidget {
  const TOCSliverAppBar(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_rounded),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              scrollControlDisabledMaxHeightRatio: 1.0,
              showDragHandle: true,
              builder: (BuildContext context) {
                return EditBookPage(bookObject);
              },
            ).then((isSuccess) {
              if (isSuccess) {
                bookObject.refreshCover();
              }
            });
          },
          icon: const Icon(Icons.edit_rounded),
        ),
      ],
    );
  }

}