import 'package:flutter/material.dart';

import '../../shared/book_process.dart';

class TOCSliverCoverBanner extends StatelessWidget {
  const TOCSliverCoverBanner(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
        constraints: BoxConstraints(
          maxHeight: deviceHeight / 2,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
        clipBehavior: Clip.hardEdge,
        child: AspectRatio(
          aspectRatio: 1,
          child: bookObject.getCover(),
        ),
      ),
    );
  }

}