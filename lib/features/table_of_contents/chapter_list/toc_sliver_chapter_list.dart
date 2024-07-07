import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/toc_bloc.dart';
import 'toc_sliver_chapter_list_item.dart';

class TocSliverChapterList extends StatelessWidget {
  const TocSliverChapterList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TocCubit, TocState>(
      builder: (BuildContext context, TocState state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => TocSliverChapterListItem(state.chapterList[index]),
            childCount: state.chapterList.length,
          ),
        );
      },
    );
  }
}
