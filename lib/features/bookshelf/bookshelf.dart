import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_sliver_app_bar.dart';
import 'bookshelf_sliver_list.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    final BookshelfCubit cubit = BlocProvider.of<BookshelfCubit>(context);
    return Container(
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
    );
  }
}
