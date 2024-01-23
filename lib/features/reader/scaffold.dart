import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/features/reader/nav_bar.dart';

import '../../shared/chapter_object.dart';
import 'bloc/reader_bloc.dart';
import 'sliver_app_bar.dart';
import 'sliver_content.dart';
import 'sliver_title.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget(this.chapterObject, {super.key});

  final ChapterObject chapterObject;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderCubit(),
      child: Scaffold(
        body: CustomScrollView(slivers: [
          ReaderSliverAppBar(chapterObject),
          ReaderSliverTitle(chapterObject),
          ReaderSliverContent(chapterObject)
        ]),
        bottomNavigationBar: const ReaderNavBar(),
      ),
    );
  }
}
