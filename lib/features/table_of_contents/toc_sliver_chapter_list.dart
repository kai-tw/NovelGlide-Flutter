import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/toc_bloc.dart';
import 'toc_sliver_chapter_list_item.dart';

class TOCSliverChapterList extends StatelessWidget {
  const TOCSliverChapterList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TOCCubit, TOCState>(
      builder: (BuildContext context, TOCState state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              int chapterNumber = state.chapterList[index].ordinalNumber;
              String chapterTitle = state.chapterList[index].getTitle();

              return TOCSliverChapterListItem(title: chapterTitle, chapterNumber: chapterNumber);
            },
            childCount: state.chapterList.length,
          ),
        );
      },
    );
  }
}
