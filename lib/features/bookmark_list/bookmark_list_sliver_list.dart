import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_sliver_list_item.dart';

class BookmarkListSliverList extends StatelessWidget {
  const BookmarkListSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookmarkListCubit>(context).refresh();
    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      builder: (context, state) {
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
            return const SliverFillRemaining(
              child: SafeArea(
                child: CommonLoading(),
              ),
            );

          default:
            return const SliverFillRemaining(
              child: SafeArea(
                child: CommonListEmpty(),
              ),
            );
        }
      },
    );
  }
}
