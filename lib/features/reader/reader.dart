import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/reader_cubit.dart';
import 'bloc/reader_progress_bar_bloc.dart';
import 'reader_scaffold.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget(this.bookName, this.chapterNumber, {super.key, this.isAutoJump = false});

  final String bookName;
  final int chapterNumber;
  final bool isAutoJump;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ReaderCubit>(
            create: (_) => ReaderCubit(bookName, chapterNumber, isAutoJump: isAutoJump)..initialize(),
          ),
          BlocProvider<ReaderProgressBarCubit>(
            create: (_) => ReaderProgressBarCubit(),
          ),
        ],
        child: const ReaderScaffold(),
      ),
    );
  }
}
