import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/chapter_object.dart';
import '../reader/scaffold.dart';
import 'bloc/toc_bloc.dart';

class TOCSliverChapterList extends StatelessWidget {
  const TOCSliverChapterList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TOCCubit, TOCState>(
      builder: (BuildContext context, TOCState state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextButton(
                  onPressed: () => Navigator.of(context).push(_navigateToReader(state.chapterList[index])),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  child: Text(
                    '${AppLocalizations.of(context)!.chapter_label(state.chapterList[index].ordinalNumber)} - ${state.chapterList[index].title}',
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

  Route _navigateToReader(ChapterObject chapterObject) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ReaderWidget(chapterObject),
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
