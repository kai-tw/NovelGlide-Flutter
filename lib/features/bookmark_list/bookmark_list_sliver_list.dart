import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_bookmark.dart';

class BookmarkListSliverList extends StatelessWidget {
  const BookmarkListSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      builder: (BuildContext context, BookmarkListState state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return BookmarkListBookmark(state.bookmarkList[index]);
            },
            childCount: state.bookmarkList.length,
          ),
        );
      },
    );
  }
}
