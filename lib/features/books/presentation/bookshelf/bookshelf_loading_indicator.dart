import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/bookshelf_cubit.dart';

class BookshelfLoadingIndicator extends StatelessWidget {
  const BookshelfLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      buildWhen: (BookshelfState previous, BookshelfState current) =>
          previous.code != current.code,
      builder: (BuildContext context, BookshelfState state) {
        if (state.code.isBackgroundLoading) {
          return const LinearProgressIndicator();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
