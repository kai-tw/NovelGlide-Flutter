import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_list_empty.dart';
import '../../common_components/common_loading.dart';
import '../bloc/bookmark_manager_bloc.dart';
import 'bookmark_manager_sliver_list_item.dart';

class BookmarkManagerSliverList extends StatelessWidget {
  const BookmarkManagerSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkManagerCubit, BookmarkManagerState>(
      buildWhen: (previous, current) => previous.code != current.code || previous.bookmarkList != current.bookmarkList,
      builder: (context, state) {
        switch (state.code) {
          case BookmarkManagerStateCode.normal:
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return BookmarkManagerSliverListItem(bookmarkData: state.bookmarkList[index]);
                },
                childCount: state.bookmarkList.length,
              ),
            );

          case BookmarkManagerStateCode.empty:
            return const SliverFillRemaining(
              child: Center(
                child: CommonListEmpty(),
              ),
            );

          default:
            return const SliverFillRemaining(
              child: Center(
                child: CommonLoading(),
              ),
            );
        }
      },
    );
  }
}
