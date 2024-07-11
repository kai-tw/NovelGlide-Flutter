import 'package:flutter/material.dart';

import '../../../data/chapter_data.dart';
import '../../reader/reader.dart';
import 'toc_chapter_title.dart';

class TocChapterWidget extends StatelessWidget {
  final ChapterData chapterData;

  const TocChapterWidget(this.chapterData, {super.key});

  @override
  Widget build(BuildContext context) {
    final int chapterNumber = chapterData.ordinalNumber;
    final String bookName = chapterData.bookName;
    final double iconSize = IconTheme.of(context).size ?? 24.0;

    return TextButton.icon(
      onPressed: () => Navigator.of(context).push(_navigateToReader(bookName, chapterNumber)),
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      icon: Icon(
        Icons.numbers_rounded,
        size: MediaQuery.of(context).textScaler.scale(iconSize),
      ),
      label: TocChapterTitle(chapterData),
    );
  }

  Route _navigateToReader(String bookName, int chapterNumber) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ReaderWidget(bookName, chapterNumber),
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}