import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../collection/presentation/collection_list/collection_list_floating_action_button.dart';
import '../book_list/book_list_floating_action_button.dart';
import 'cubit/bookshelf_cubit.dart';
import 'cubit/bookshelf_state.dart';

class BookshelfFloatingActionButton extends StatelessWidget {
  const BookshelfFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (BookshelfState previous, BookshelfState current) =>
          previous.tabIndex != current.tabIndex ||
          previous.isTabRunning != current.isTabRunning,
      builder: (BuildContext context, BookshelfState state) {
        if (state.tabIndex == 1) {
          // Collection Floating Action Button
          return CollectionListFloatingActionButton(
            enabled: !state.isTabRunning,
          );
        }

        // BookList Floating Action Button
        return BookListFloatingActionButton(
          enabled: !state.isTabRunning,
        );
      },
    );
  }
}
