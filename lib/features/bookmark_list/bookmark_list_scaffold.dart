import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bookmark_list_bloc.dart';
import 'bookmark_list_app_bar.dart';
import 'bookmark_list_sliver_list.dart';

class BookmarkListScaffold extends StatelessWidget {
  const BookmarkListScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarkListCubit cubit = BlocProvider.of<BookmarkListCubit>(context)..refresh();
    return Scaffold(
      appBar: const BookmarkListAppBar(),
      body: RefreshIndicator(
        onRefresh: () async => cubit.refresh(),
        child: const CustomScrollView(
          slivers: [
            BookmarkListSliverList(),
          ],
        ),
      ),
    );
  }
}
