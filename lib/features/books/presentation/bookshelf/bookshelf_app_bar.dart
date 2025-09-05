import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../collection/presentation/collection_list/collection_list_app_bar.dart';
import '../book_list/book_list_app_bar.dart';
import 'cubit/bookshelf_cubit.dart';
import 'cubit/bookshelf_state.dart';

class BookshelfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookshelfAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (BookshelfState previous, BookshelfState current) =>
          previous.tabIndex != current.tabIndex,
      builder: (BuildContext context, BookshelfState state) {
        switch (state.tabIndex) {
          case 0:
            return const BookListAppBar();

          case 1:
            return const CollectionListAppBar();
        }

        return AppBar();
      },
    );
  }
}
