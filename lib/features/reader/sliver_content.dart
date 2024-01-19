import 'package:flutter/material.dart';

import '../../shared/chapter_object.dart';

class ReaderSliverContent extends StatelessWidget {
  const ReaderSliverContent(this.chapterObject, {super.key});

  final ChapterObject chapterObject;

  @override
  Widget build(BuildContext context) {
    List<String> contentLines = chapterObject.getLines();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Text(contentLines[index]),
          );
        },
        childCount: contentLines.length,
      ),
    );
  }
}
