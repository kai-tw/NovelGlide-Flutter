import 'package:flutter/material.dart';

import '../../shared/book_process.dart';

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
      title: Text(
        bookObject.name,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      expandedHeight: 150.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
          ),
          child: bookObject.getCover(),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_rounded),
        ),
      ],
    );
  }

}