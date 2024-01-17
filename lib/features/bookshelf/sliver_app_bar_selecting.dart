import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bookshelf_bloc.dart';

class BookshelfSliverAppBarSelecting extends StatelessWidget {
  const BookshelfSliverAppBarSelecting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      builder: (BuildContext context, BookshelfState state) {
        final bool isSelectedAll = state.selectedSet.length == state.bookList.length;
        return SliverAppBar(
          pinned: true,
          leading: IconButton(
            onPressed: () {
              if (isSelectedAll) {
                BlocProvider.of<BookshelfCubit>(context).clearSelect();
              } else {
                BlocProvider.of<BookshelfCubit>(context).allSelect();
              }
            },
            icon: Icon(isSelectedAll ? Icons.check_box_rounded : Icons.indeterminate_check_box_rounded),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(state.selectedSet.length.toString()),
          ),
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<BookshelfCubit>(context).deleteSelect();
              },
              icon: const Icon(Icons.delete_outline_rounded),
            )
          ],
        );
      },
    );
  }
}
