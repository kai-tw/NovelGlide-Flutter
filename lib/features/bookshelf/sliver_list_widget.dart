import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/sliver_list_empty.dart';
import '../../shared/sliver_loading.dart';
import 'book_widget.dart';
import 'bloc/bookshelf_bloc.dart';

class BookshelfSliverList extends StatelessWidget {
  const BookshelfSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      builder: (BuildContext context, BookshelfState state) {
        switch (state.code) {
          case BookshelfStateCode.unload:
            BlocProvider.of<BookshelfCubit>(context).refresh();
            return const CommonSliverListEmpty();
          case BookshelfStateCode.loading:
            return const CommonSliverLoading();
          case BookshelfStateCode.empty:
            return const CommonSliverListEmpty();
          case BookshelfStateCode.normal:
          case BookshelfStateCode.selecting:
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                childAspectRatio: 150 / 330,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return BookshelfBookWidget(state.bookList[index]);
                },
                childCount: state.bookList.length,
              ),
            );
        }
      },
    );
  }
}
