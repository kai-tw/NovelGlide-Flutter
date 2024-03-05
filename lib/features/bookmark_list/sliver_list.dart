import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/bookmark_object.dart';
import 'bloc/bookmark_list_bloc.dart';
import 'sliver_list_item.dart';

class BookmarkSliverList extends StatelessWidget {
  const BookmarkSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      builder: (BuildContext context, BookmarkListState state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return BookmarkSliverListItem(state.bookmarkList[index]);
            },
            childCount: state.bookmarkList.length,
          ),
        );
      },
    );
  }
}
