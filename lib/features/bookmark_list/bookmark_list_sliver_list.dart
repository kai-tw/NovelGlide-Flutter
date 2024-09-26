import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enum/loading_state_code.dart';
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
          case LoadingStateCode.loaded:
            if (state.bookmarkList.isEmpty) {
              return const CommonSliverListEmpty();
            } else {
              return SliverPadding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return BookmarkListSliverListItem(state.bookmarkList[index]);
                    },
                    childCount: state.bookmarkList.length,
                  ),
                ),
              );
            }

          case LoadingStateCode.initial:
          case LoadingStateCode.loading:
            return const CommonSliverLoading();
        }
      },
    );
  }
}
