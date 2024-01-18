import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bookshelf_bloc.dart';
import 'sliver_app_bar.dart';
import 'sliver_list_widget.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: RefreshIndicator(
        onRefresh: () async => BlocProvider.of<BookshelfCubit>(context).refresh(),
        child: const CustomScrollView(slivers: [
          BookshelfSliverAppBar(),
          BookshelfSliverList()
        ]),
      ),
    );
  }
}
