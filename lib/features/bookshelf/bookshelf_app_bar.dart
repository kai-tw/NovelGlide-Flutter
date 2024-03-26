import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_app_bar_default.dart';
import 'bookshelf_app_bar_selecting.dart';

class BookshelfAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const BookshelfAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookshelfCubit, BookshelfState>(
      builder: (BuildContext context, BookshelfState state) {
        switch (state.code) {
          case BookshelfStateCode.selecting:
            return const BookshelfAppBarSelecting();
          default:
            return const BookshelfAppBarDefault();
        }
      },
    );
  }
}
