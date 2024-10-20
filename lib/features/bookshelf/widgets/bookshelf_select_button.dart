import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_list_select_text_button.dart';
import '../bloc/bookshelf_bloc.dart';

class BookshelfSelectButton extends StatelessWidget {
  const BookshelfSelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (previous, current) =>
          previous.isSelecting != current.isSelecting ||
          previous.bookList != current.bookList ||
          previous.selectedBooks != current.selectedBooks,
      builder: (context, state) {
        Widget? child;

        if (state.isSelecting) {
          child = CommonListSelectTextButton(
            isEmpty: state.bookList.isEmpty,
            isSelectAll: state.selectedBooks.length == state.bookList.length,
            selectAll: cubit.selectAllBooks,
            deselectAll: cubit.deselectAllBooks,
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: child,
        );
      },
    );
  }
}
