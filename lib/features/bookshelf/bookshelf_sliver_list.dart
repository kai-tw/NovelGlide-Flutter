import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/sliver_list_empty.dart';
import '../../shared/sliver_loading.dart';
import 'bookshelf_book.dart';
import 'bloc/bookshelf_bloc.dart';

class BookshelfSliverList extends StatelessWidget {
  const BookshelfSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookshelfCubit>(context).refresh();

    return BlocBuilder<BookshelfCubit, BookshelfState>(
      builder: (BuildContext context, BookshelfState state) {
        switch (state.code) {
          case BookshelfStateCode.loading:
            return const CommonSliverLoading();

          case BookshelfStateCode.normal:
          case BookshelfStateCode.selecting:
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                childAspectRatio: 150 / 330,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return BookshelfBook(state.bookList[index]);
                },
                childCount: state.bookList.length,
              ),
            );
          default:
            return const CommonSliverListEmpty();
        }
      },
    );
  }
}
