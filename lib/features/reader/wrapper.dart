import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/chapter_object.dart';
import 'bloc/reader_cubit.dart';
import 'scaffold.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget(this.chapterObject, {super.key});

  final ChapterObject chapterObject;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderCubit(chapterObject),
      child: const ReaderScaffold(),
    );
  }
}
