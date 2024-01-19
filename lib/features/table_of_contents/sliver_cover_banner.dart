import 'package:flutter/material.dart';

import '../../shared/book_object.dart';

class TOCSliverCoverBanner extends StatelessWidget {
  const TOCSliverCoverBanner(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Hero(
            tag: bookObject,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: deviceHeight / 2,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              ),
              clipBehavior: Clip.hardEdge,
              child: bookObject.getCover(),
            ),
          ),
        ),
      ),
    );
  }

}