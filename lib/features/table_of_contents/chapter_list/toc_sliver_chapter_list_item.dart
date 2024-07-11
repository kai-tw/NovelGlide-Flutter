import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/chapter_data.dart';
import '../../common_components/common_loading.dart';
import '../bloc/toc_bloc.dart';
import 'toc_chapter_widget.dart';

class TocSliverChapterListItem extends StatelessWidget {
  final ChapterData chapterData;

  const TocSliverChapterListItem(this.chapterData, {super.key});

  @override
  Widget build(BuildContext context) {
    final double fontSize = Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14.0;
    final double verticalPadding = MediaQuery.of(context).textScaler.scale(fontSize) / 2;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: verticalPadding),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
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
              child: TocChapterWidget(chapterData),
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: Container(
                width: constraints.maxWidth,
                color: Theme.of(context).colorScheme.surface,
                child: TocChapterWidget(chapterData),
              ),
            ),
            child: Container(
              width: constraints.maxWidth,
              color: Theme.of(context).colorScheme.surface,
              child: TocChapterWidget(chapterData),
            ),
          );
        }
      ),
    );
  }
}
