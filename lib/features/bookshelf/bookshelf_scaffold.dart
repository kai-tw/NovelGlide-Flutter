import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_book/add_book_callee_add_button.dart';
import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_sliver_app_bar.dart';
import 'bookshelf_sliver_list.dart';

class BookshelfScaffold extends StatelessWidget {
  const BookshelfScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: RefreshIndicator(
          onRefresh: () async => cubit.refresh(),
          child: const CustomScrollView(slivers: [
            BookshelfSliverAppBar(),
            BookshelfSliverList()
          ]),
        ),
      ),
      floatingActionButton: AddBookCalleeAddButton(
        callback: (_) => cubit.refresh(),
      ),
    );
  }

}