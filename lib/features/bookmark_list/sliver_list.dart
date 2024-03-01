import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/bookmark_object.dart';
import 'bloc/bookmark_list_bloc.dart';

class BookmarkSliverList extends StatelessWidget {
  const BookmarkSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkListCubit, BookmarkListState>(
      builder: (BuildContext context, BookmarkListState state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final BookmarkObject bookmarkObject = state.bookmarkList[index];

              return Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                child: Text(bookmarkObject.bookName),
              );
            },
            childCount: state.bookmarkList.length,
          ),
        );
      },
    );
  }
}
