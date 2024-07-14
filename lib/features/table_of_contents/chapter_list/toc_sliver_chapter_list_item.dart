import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/chapter_data.dart';
import '../../../processor/bookmark_processor.dart';
import '../../common_components/common_loading.dart';
import '../../reader/reader.dart';
import '../bloc/toc_bloc.dart';
import 'toc_chapter_title.dart';

class TocSliverChapterListItem extends StatelessWidget {
  final ChapterData chapterData;

  const TocSliverChapterListItem(this.chapterData, {super.key});

  @override
  Widget build(BuildContext context) {
    final double fontSize = Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14.0;
    final double verticalPadding = MediaQuery.of(context).textScaler.scale(fontSize) / 2;
    final int chapterNumber = chapterData.ordinalNumber;
    final String bookName = chapterData.bookName;
    final double iconSize = IconTheme.of(context).size ?? 24.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: verticalPadding),
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return BlocBuilder<TocCubit, TocState>(
          buildWhen: (previous, current) =>
              previous.bookmarkData.isValid != current.bookmarkData.isValid ||
              previous.bookmarkData.chapterNumber != current.bookmarkData.chapterNumber,
          builder: (BuildContext context, TocState state) {
            final bool isBookmarked = state.bookmarkData.isValid && chapterNumber == state.bookmarkData.chapterNumber;
            return LongPressDraggable(
              onDragStarted: () => BlocProvider.of<TocCubit>(context).setDragging(true),
              onDragEnd: (_) => BlocProvider.of<TocCubit>(context).setDragging(false),
              onDragCompleted: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Dialog(
                    child: CommonLoading(),
                  ),
                );
                chapterData.delete().then((isSuccess) {
                  Navigator.of(context).pop();
                  if (isSuccess) {
                    /// Delete the bookmark
                    BookmarkProcessor.chapterDeleteCheck(bookName, chapterData.ordinalNumber);

                    BlocProvider.of<TocCubit>(context).refresh();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.deleteChapterSuccessfully),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.deleteChapterFailed),
                      ),
                    );
                  }
                });
              },
              data: chapterData,
              feedback: Container(
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                      blurRadius: 8.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: _chapterWidget(context, chapterData, isBookmarked),
              ),
              childWhenDragging: Opacity(
                opacity: 0.3,
                child: Container(
                  width: constraints.maxWidth,
                  color: Theme.of(context).colorScheme.surface,
                  child: _chapterWidget(context, chapterData, isBookmarked),
                ),
              ),
              child: Container(
                width: constraints.maxWidth,
                color: Theme.of(context).colorScheme.surface,
                child: _chapterWidget(context, chapterData, isBookmarked),
              ),
            );
          },
        );
      }),
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

  Widget _chapterWidget(BuildContext context, ChapterData chapterData, bool isBookmarked) {
    final int chapterNumber = chapterData.ordinalNumber;
    final String bookName = chapterData.bookName;
    final double iconSize = IconTheme.of(context).size ?? 24.0;
    return TextButton.icon(
      onPressed: () => Navigator.of(context)
          .push(_navigateToReader(bookName, chapterNumber))
          .then((_) => BlocProvider.of<TocCubit>(context).refresh()),
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      icon: Icon(
        isBookmarked ? Icons.bookmark_rounded : Icons.numbers_rounded,
        size: MediaQuery.of(context).textScaler.scale(iconSize),
        color: isBookmarked ? Theme.of(context).colorScheme.error : null,
      ),
      label: TocChapterTitle(chapterData),
    );
  }
}
