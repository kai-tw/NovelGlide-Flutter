import 'package:flutter/material.dart';

import '../../shared/chapter_object.dart';

class ReaderSliverAppBar extends StatelessWidget {
  const ReaderSliverAppBar(this.chapterObject, {super.key});

  final ChapterObject chapterObject;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
