import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/chapter_object.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';
import '../wrapper.dart';

/// The button that navigate to the previous chapter.
/// Abbreviation reference: https://www.abbreviations.com/
class RdrNavPrevChBtn extends StatelessWidget {
  const RdrNavPrevChBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (BuildContext context, ReaderState state) {
        return IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: state.prevChapterObj == null ? null : () => _onPressed(context, state.prevChapterObj!),
        );
      },
    );
  }

  void _onPressed(BuildContext context, ChapterObject chapterObject) {
    Navigator.of(context).pushReplacement(_navigateToPrevChapter(chapterObject));
  }

  Route _navigateToPrevChapter(ChapterObject chapterObject) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ReaderWidget(chapterObject),
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0)).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
    );
  }
}