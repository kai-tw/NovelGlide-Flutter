import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/chapter_object.dart';
import '../bloc/reader_cubit.dart';
import '../bloc/reader_state.dart';
import '../wrapper.dart';

class ReaderNavNextChapterButton extends StatelessWidget {
  const ReaderNavNextChapterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (BuildContext context, ReaderState state) {
        return IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: state.nextChapterObj == null ? null : () => _onPressed(context, state.nextChapterObj!),
        );
      },
    );
  }

  void _onPressed(BuildContext context, ChapterObject chapterObject) {
    Navigator.of(context).pushReplacement(_navigateToNextChapter(chapterObject));
  }

  Route _navigateToNextChapter(ChapterObject chapterObject) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ReaderWidget(chapterObject),
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0)).animate(
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