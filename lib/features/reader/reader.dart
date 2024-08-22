import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/book_data.dart';
import 'bloc/reader_cubit.dart';
import 'reader_scaffold.dart';

class ReaderWidget extends StatelessWidget {
  final BookData bookData;
  final int chapterNumber;
  final bool isAutoJump;

  const ReaderWidget(this.bookData, this.chapterNumber, {super.key, this.isAutoJump = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderCubit(
        bookData: bookData,
        chapterNumber: chapterNumber,
        currentTheme: Theme.of(context),
      )..initialize(isAutoJump: isAutoJump),
      child: const ReaderScaffold(),
    );
  }
}
