import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../reader/reader.dart';
import 'bloc/toc_bloc.dart';

class TOCSliverChapterList extends StatelessWidget {
  const TOCSliverChapterList({super.key});

  @override
  Widget build(BuildContext context) {
    final TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    return BlocBuilder<TOCCubit, TOCState>(
      builder: (BuildContext context, TOCState state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              int chapterNumber = state.chapterList[index].ordinalNumber;
              String chapterTitle = state.chapterList[index].title;
              String localizedOrdinal = AppLocalizations.of(context)!.chapter_label(chapterNumber);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextButton(
                  onPressed: () => Navigator.of(context).push(_navigateToReader(cubit.bookObject.name, chapterNumber)),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  child: Text(
                    '$localizedOrdinal - $chapterTitle',
                    textAlign: TextAlign.left,
                  ),
                ),
              );
            },
            childCount: state.chapterList.length,
          ),
        );
      },
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
