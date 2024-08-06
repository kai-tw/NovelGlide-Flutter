import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../bloc/bookshelf_bloc.dart';

class BookshelfSelectCheckbox extends StatelessWidget {
  final BookData bookData;

  const BookshelfSelectCheckbox({super.key, required this.bookData});

  @override
  Widget build(BuildContext context) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (previous, current) => previous.selectedBooks != current.selectedBooks,
      builder: (BuildContext context, BookshelfState state) {
        return Checkbox(
          value: state.selectedBooks.contains(bookData.name),
          onChanged: (_) {
            if (cubit.state.selectedBooks.contains(bookData.name)) {
              cubit.deselectBook(bookData.name);
            } else {
              cubit.selectBook(bookData.name);
            }
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          semanticLabel: 'Select this book to add to the deletion pending list.',
        );
      },
    );
  }
}