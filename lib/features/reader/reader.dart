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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReaderCubit>(
          create: (_) => ReaderCubit(bookData, chapterNumber)..initialize(isAutoJump: isAutoJump),
        ),
      ],
      child: const ReaderScaffold(),
    );
  }
}
