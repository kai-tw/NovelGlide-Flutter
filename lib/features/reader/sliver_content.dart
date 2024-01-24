import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/chapter_object.dart';
import 'bloc/reader_bloc.dart';

class ReaderSliverContent extends StatelessWidget {
  const ReaderSliverContent(this.chapterObject, {super.key});

  final ChapterObject chapterObject;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReaderCubit>(context).loadSettings();
    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (BuildContext context, ReaderState state) {
        List<String> contentLines = chapterObject.getLines();
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Text(
                  contentLines[index],
                  style: TextStyle(fontSize: state.fontSize, height: state.lineHeight),
                ),
              );
            },
            childCount: contentLines.length,
          ),
        );
      },
    );
  }
}
