import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/reader_cubit.dart';
import 'reader_scaffold.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget(this.bookName, this.chapterNumber, {super.key});

  final String bookName;
  final int chapterNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderCubit(bookName, chapterNumber),
      child: const ReaderScaffold(),
    );
  }
}
