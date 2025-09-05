import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../collection/domain/entities/collection_data.dart';
import '../../../collection/presentation/collection_list/cubit/collection_list_cubit.dart';
import '../../../shared_components/shared_list/presentation/widgets/shared_list_delete_drag_target.dart';
import '../../domain/entities/book.dart';
import '../book_list/cubit/bookshelf_cubit.dart';
import 'cubit/bookshelf_cubit.dart';
import 'cubit/bookshelf_state.dart';

class BookshelfDeleteDragTarget extends StatelessWidget {
  const BookshelfDeleteDragTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (BookshelfState previous, BookshelfState current) =>
          previous.tabIndex != current.tabIndex,
      builder: (BuildContext context, BookshelfState state) {
        if (state.tabIndex == 1) {
          // Collection Deletion Drag Target
          return const SharedListDeleteDragTarget<CollectionListCubit,
              CollectionData>();
        }

        // BookList Deletion Drag Target
        return const SharedListDeleteDragTarget<BookListCubit, Book>();
      },
    );
  }
}
