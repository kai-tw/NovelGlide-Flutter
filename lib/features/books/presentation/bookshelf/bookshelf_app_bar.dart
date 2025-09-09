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
        if (state.tabIndex == 1) {
          // Collection App Bar
          return const CollectionListAppBar();
        }

        // BookList App Bar
        return const BookListAppBar();
      },
    );
  }
}
