import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/sliver_list_empty.dart';
import '../../shared/sliver_loading.dart';
import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_sliver_list_item.dart';

class BookmarkListSliverList extends StatelessWidget {
  const BookmarkListSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      builder: (BuildContext context, BookmarkListState state) {
        switch (state.code) {
          case BookmarkListStateCode.normal:
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return BookmarkListSliverListItem(state.bookmarkList[index]);
                },
                childCount: state.bookmarkList.length,
              ),
            );

          case BookmarkListStateCode.loading:
            return const CommonSliverLoading();

          default:
            return const CommonSliverListEmpty();
        }
      },
    );
  }
}
