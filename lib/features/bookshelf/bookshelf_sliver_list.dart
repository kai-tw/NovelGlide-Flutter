import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/loading_state_code.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import 'bookshelf_sliver_list_item.dart';
import 'bloc/bookshelf_bloc.dart';

class BookshelfSliverList extends StatelessWidget {
  const BookshelfSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookshelfCubit>(context).refresh();
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (previous, current) =>
          previous.code != current.code ||
          previous.bookList != current.bookList ||
          previous.isAscending != current.isAscending ||
          previous.sortOrder != current.sortOrder,
      builder: (BuildContext context, BookshelfState state) {
        switch (state.code) {
          case LoadingStateCode.loaded:
            if (state.bookList.isEmpty) {
              return const CommonSliverListEmpty();
            } else {
              final double bottomPadding = MediaQuery
                  .of(context)
                  .padding
                  .bottom + 48.0;
              return SliverPadding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150.0,
                    childAspectRatio: 150 / 300,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return BookshelfSliverListItem(state.bookList[index]);
                    },
                    childCount: state.bookList.length,
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
