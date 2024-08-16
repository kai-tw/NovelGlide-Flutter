import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/chapter_data.dart';
import '../../../processor/bookmark_processor.dart';
import '../../common_components/common_loading.dart';
import '../../common_components/draggable_feedback_widget.dart';
import '../../common_components/draggable_placeholder_widget.dart';
import '../../reader/reader.dart';
import '../bloc/toc_bloc.dart';
import '../widgets/toc_chapter_widget.dart';

class TocSliverChapterListItem extends StatelessWidget {
  final ChapterData chapterData;

  const TocSliverChapterListItem(this.chapterData, {super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    final double fontSize = Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14.0;
    final double verticalPadding = MediaQuery.of(context).textScaler.scale(fontSize) / 2;
    final int chapterNumber = chapterData.ordinalNumber;
    final String bookName = chapterData.bookName;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: verticalPadding),
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return BlocBuilder<TocCubit, TocState>(
          buildWhen: (previous, current) => previous.bookmarkData?.chapterNumber != current.bookmarkData?.chapterNumber,
          builder: (BuildContext context, TocState state) {
            final bool isBookmarked = chapterNumber == state.bookmarkData?.chapterNumber;
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
                    BookmarkProcessor.chapterCheck(bookName, chapterData.ordinalNumber);

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
              feedback: DraggableFeedbackWidget(
                width: constraints.maxWidth,
                child: TocChapterWidget(chapterData: chapterData, isBookmarked: isBookmarked),
              ),
              childWhenDragging: DraggablePlaceholderWidget(
                width: constraints.maxWidth,
                child: TocChapterWidget(chapterData: chapterData, isBookmarked: isBookmarked),
              ),
              child: Container(
                width: constraints.maxWidth,
                color: Theme.of(context).colorScheme.surface,
                child: TocChapterWidget(
                  chapterData: chapterData,
                  isBookmarked: isBookmarked,
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => ReaderWidget(bookName, chapterNumber),
                  ))
                      .then((_) => cubit.refresh()),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
