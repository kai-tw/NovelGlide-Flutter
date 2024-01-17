import 'package:flutter/material.dart';

import '../../shared/book_process.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: bookObject,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
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
                title: Text(
                  bookObject.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                centerTitle: false,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
